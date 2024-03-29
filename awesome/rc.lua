-- Standard awesome libraries
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local ruled = require("ruled")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local battery = require("components.battery")
local taglist = require("components.taglist")
local systray = require("components.systray")
local theme = require("default.theme")

require("awful.autofocus")
require("awful.hotkeys_popup.keys")

beautiful.init(gears.filesystem.get_configuration_dir() .. 'default/theme.lua')

-- Variable definitions
terminal = "termite"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
modkey = "Mod4"

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Possibile layots ;
tag.connect_signal("request::default_layouts", function()
    awful.layout.append_default_layouts({awful.layout.suit.fair})
end)

-- {{{ Wibar

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

screen.connect_signal("request::desktop_decoration", function(s)
    SCREEN_WIDTH = s.geometry.width
    SCREEN_HEIGHT = s.geometry.height
    barOrientation = SCREEN_WIDTH > 2200 and wibox.layout.fixed.vertical or wibox.layout.fixed.horizontal
    barAlignment = SCREEN_WIDTH > 2200 and wibox.layout.align.vertical or wibox.layout.align.horizontal
    barPosition = SCREEN_WIDTH > 2200 and "left" or "top"

    -- Each screen has its own tag table.
    awful.tag({"", "", "", "切", "", ""}, s, awful.layout.layouts[1])

    s.battery = battery

    -- Create a taglist widget
    s.mytaglist = taglist.init(s, barOrientation)

    s.systray = systray.init()

    -- Create the wibox
    s.mywibox = awful.wibar {
        position = barPosition,
        screen = s,
        widget = {
            layout = barAlignment,
            { -- Left widgets
                layout = wibox.layout.fixed.horizontal,
                s.mytaglist
            },
            wibox.widget.systray(),
            { -- Right widgets
                layout = wibox.layout.align.horizontal,
                s.battery,
                s.systray,
                wibox.widget.textclock("%H:%M ")
            }
        }
    }
end)
-- }}}

-- {{{ Mouse bindings
awful.mouse.append_global_mousebindings({awful.button({}, 3, function()
    mymainmenu:toggle()
end), awful.button({}, 4, awful.tag.viewprev), awful.button({}, 5, awful.tag.viewnext)})
-- }}}

-- {{{ Key bindings

-- General Awesome keys
awful.keyboard.append_global_keybindings({awful.key({modkey}, "s", hotkeys_popup.show_help, {
    description = "show help",
    group = "awesome"
}), awful.key({modkey, "Control"}, "r", awesome.restart, {
    description = "reload awesome",
    group = "awesome"
}), awful.key({modkey}, "Return", function()
    awful.spawn(terminal)
end, {
    description = "open a terminal",
    group = "launcher"
}), awful.key({modkey}, "r", function()
    awful.screen.focused().mypromptbox:run()
end, {
    description = "run prompt",
    group = "launcher"
}), awful.key({modkey}, "space", function()
    awful.spawn.with_shell("rofi -show drun", function(stdout)
        awful.spawn(stdout:gsub("\n$", ""))
    end)
end, {
    description = "run rofi",
    group = "launcher"
}), awful.key({}, "XF86MonBrightnessDown", function()
    awful.util.spawn("sudo ybacklight -15")
end), awful.key({}, "XF86MonBrightnessUp", function()
    awful.util.spawn("sudo ybacklight +15")
end)})

-- Tags related keybindings
awful.keyboard.append_global_keybindings({awful.key({modkey}, "Left", awful.tag.viewprev, {
    description = "view previous",
    group = "tag"
}), awful.key({modkey}, "Right", awful.tag.viewnext, {
    description = "view next",
    group = "tag"
}), awful.key({modkey}, "Escape", awful.tag.history.restore, {
    description = "go back",
    group = "tag"
})})

-- Focus related keybindings
awful.keyboard.append_global_keybindings({awful.key({modkey}, "j", function()
    awful.client.focus.byidx(1)
end, {
    description = "focus next by index",
    group = "client"
}), awful.key({modkey}, "k", function()
    awful.client.focus.byidx(-1)
end, {
    description = "focus previous by index",
    group = "client"
}), awful.key({modkey}, "Tab", function()
    awful.client.focus.history.previous()
    if client.focus then
        client.focus:raise()
    end
end, {
    description = "go back",
    group = "client"
}), awful.key({modkey, "Control"}, "j", function()
    awful.screen.focus_relative(1)
end, {
    description = "focus the next screen",
    group = "screen"
}), awful.key({modkey, "Control"}, "k", function()
    awful.screen.focus_relative(-1)
end, {
    description = "focus the previous screen",
    group = "screen"
}), awful.key({modkey, "Control"}, "n", function()
    local c = awful.client.restore()
    -- Focus restored client
    if c then
        c:activate{
            raise = true,
            context = "key.unminimize"
        }
    end
end, {
    description = "restore minimized",
    group = "client"
})})

-- Layout related keybindings
awful.keyboard.append_global_keybindings({awful.key({modkey, "Shift"}, "j", function()
    awful.client.swap.byidx(1)
end, {
    description = "swap with next client by index",
    group = "client"
}), awful.key({modkey, "Shift"}, "k", function()
    awful.client.swap.byidx(-1)
end, {
    description = "swap with previous client by index",
    group = "client"
}), awful.key({modkey}, "u", awful.client.urgent.jumpto, {
    description = "jump to urgent client",
    group = "client"
}), awful.key({modkey}, "l", function()
    awful.tag.incmwfact(0.05)
end, {
    description = "increase master width factor",
    group = "layout"
}), awful.key({modkey}, "h", function()
    awful.tag.incmwfact(-0.05)
end, {
    description = "decrease master width factor",
    group = "layout"
}), awful.key({modkey, "Shift"}, "h", function()
    awful.tag.incnmaster(1, nil, true)
end, {
    description = "increase the number of master clients",
    group = "layout"
}), awful.key({modkey, "Shift"}, "l", function()
    awful.tag.incnmaster(-1, nil, true)
end, {
    description = "decrease the number of master clients",
    group = "layout"
}), awful.key({modkey, "Control"}, "h", function()
    awful.tag.incncol(1, nil, true)
end, {
    description = "increase the number of columns",
    group = "layout"
}), awful.key({modkey, "Control"}, "l", function()
    awful.tag.incncol(-1, nil, true)
end, {
    description = "decrease the number of columns",
    group = "layout"
}), awful.key({modkey}, "space", function()
    awful.layout.inc(1)
end, {
    description = "select next",
    group = "layout"
}), awful.key({modkey, "Shift"}, "space", function()
    awful.layout.inc(-1)
end, {
    description = "select previous",
    group = "layout"
})})

awful.keyboard.append_global_keybindings({awful.key {
    modifiers = {modkey},
    keygroup = "numrow",
    description = "only view tag",
    group = "tag",
    on_press = function(index)
        local screen = awful.screen.focused()
        local tag = screen.tags[index]
        if tag then
            tag:view_only()
        end
    end
}, awful.key {
    modifiers = {modkey, "Control"},
    keygroup = "numrow",
    description = "toggle tag",
    group = "tag",
    on_press = function(index)
        local screen = awful.screen.focused()
        local tag = screen.tags[index]
        if tag then
            awful.tag.viewtoggle(tag)
        end
    end
}, awful.key {
    modifiers = {modkey, "Shift"},
    keygroup = "numrow",
    description = "move focused client to tag",
    group = "tag",
    on_press = function(index)
        if client.focus then
            local tag = client.focus.screen.tags[index]
            if tag then
                client.focus:move_to_tag(tag)
            end
        end
    end
}, awful.key {
    modifiers = {modkey, "Control", "Shift"},
    keygroup = "numrow",
    description = "toggle focused client on tag",
    group = "tag",
    on_press = function(index)
        if client.focus then
            local tag = client.focus.screen.tags[index]
            if tag then
                client.focus:toggle_tag(tag)
            end
        end
    end
}, awful.key {
    modifiers = {modkey},
    keygroup = "numpad",
    description = "select layout directly",
    group = "layout",
    on_press = function(index)
        local t = awful.screen.focused().selected_tag
        if t then
            t.layout = t.layouts[index] or t.layout
        end
    end
}})

client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({awful.button({}, 1, function(c)
        c:activate{
            context = "mouse_click"
        }
    end), awful.button({modkey}, 1, function(c)
        c:activate{
            context = "mouse_click",
            action = "mouse_move"
        }
    end), awful.button({modkey}, 3, function(c)
        c:activate{
            context = "mouse_click",
            action = "mouse_resize"
        }
    end)})
end)

client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({awful.key({modkey}, "f", function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end, {
        description = "toggle fullscreen",
        group = "client"
    }), awful.key({modkey, "Shift"}, "q", function(c)
        c:kill()
    end, {
        description = "close",
        group = "client"
    }), awful.key({}, "XF86AudioRaiseVolume", function()
        awful.util.spawn("amixer set Master 9%+")
    end), awful.key({}, "XF86AudioLowerVolume", function()
        awful.util.spawn("amixer set Master 9%-")
    end), awful.key({}, "XF86AudioMute", function()
        awful.util.spawn("amixer sset Master toggle")
    end), awful.key({modkey}, ";", function()
        awful.util.spawn("playerctl previous")
    end), awful.key({modkey}, "'", function()
        awful.util.spawn("playerctl play-pause")
    end), awful.key({modkey}, "\\", function()
        awful.util.spawn("playerctl next")
    end), awful.key({modkey, "Control"}, "space", awful.client.floating.toggle, {
        description = "toggle floating",
        group = "client"
    }), awful.key({modkey, "Control"}, "Return", function(c)
        c:swap(awful.client.getmaster())
    end, {
        description = "move to master",
        group = "client"
    }), awful.key({modkey}, "o", function(c)
        c:move_to_screen()
    end, {
        description = "move to screen",
        group = "client"
    }), awful.key({modkey}, "t", function(c)
        c.ontop = not c.ontop
    end, {
        description = "toggle keep on top",
        group = "client"
    }), awful.key({modkey}, "n", function(c)
        -- The client currently has the input focus, so it cannot be
        -- minimized, since minimized clients can't have the focus.
        c.minimized = true
    end, {
        description = "minimize",
        group = "client"
    }), awful.key({modkey}, "m", function(c)
        c.maximized = not c.maximized
        c:raise()
    end, {
        description = "(un)maximize",
        group = "client"
    }), awful.key({modkey, "Control"}, "m", function(c)
        c.maximized_vertical = not c.maximized_vertical
        c:raise()
    end, {
        description = "(un)maximize vertically",
        group = "client"
    }), awful.key({modkey, "Shift"}, "m", function(c)
        c.maximized_horizontal = not c.maximized_horizontal
        c:raise()
    end, {
        description = "(un)maximize horizontally",
        group = "client"
    })})
end)

-- }}}

-- {{{ Rules
-- Rules to apply to new clients.
ruled.client.connect_signal("request::rules", function()
    -- All clients will match this rule.
    ruled.client.append_rule {
        id = "global",
        rule = {},
        properties = {
            focus = awful.client.focus.filter,
            raise = true,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen
        }
    }

    -- Floating clients.
    ruled.client.append_rule {
        id = "floating",
        rule_any = {
            instance = {"copyq", "pinentry"},
            class = {"Arandr", "Blueman-manager", "Gpick", "Kruler", "Sxiv", "Tor Browser", "Wpa_gui", "veromix",
                     "xtightvncviewer"},
            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name = {"Event Tester" -- xev.
            },
            role = {"AlarmWindow", -- Thunderbird's calendar.
            "ConfigManager", -- Thunderbird's about:config.
            "pop-up" -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = {
            floating = true
        }
    }
end)

-- }}}

-- {{{ Notifications
ruled.notification.connect_signal('request::rules', function()
    -- All notifications will match this rule.
    ruled.notification.append_rule {
        rule = {},
        properties = {
            screen = awful.screen.preferred,
            implicit_timeout = 5
        }
    }
end)

naughty.connect_signal("request::display", function(n)
    naughty.layout.box {
        notification = n
    }
end)

-- }}}

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:activate{
        context = "mouse_enter",
        raise = false
    }
end)

-- Enable tap of touchpad
awful.spawn.with_shell('xinput set-prop "$(xinput list --name-only | grep -i touch)" "libinput Tapping Enabled" 1')

-- Set wallpaper
awful.spawn.with_shell('feh --bg-fill ' .. os.getenv('HOME') .. '/.config/awesome/default/background.png')

-- Open Network Manager Applet
awful.spawn.with_shell('nm-applet')
-- Open Bluetooth Managet Applet
awful.spawn.with_shell('blueman-applet')

-- Run picom
awful.spawn.with_shell('picom --config .dotfiles/picom.conf')

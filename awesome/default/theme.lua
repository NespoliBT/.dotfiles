---------------------------
-- Nespoli's Theme --
---------------------------
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local rnotification = require("ruled.notification")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_configuration_dir()

local theme = {}

-- $color_1: #1b2128;
-- $color_2: #212931;
-- $color_3: #dd83a0;
-- $color_4: #63aec0;
-- $color_5: #e25987;
-- $color_6: #85ba86;
-- $color_7: #b877b4;
-- $color_8: #fec262;
-- $color_9: #e5e5e5;

theme.font_small = "JetBrainsMono Nerd Font Mono 14"
theme.font = "JetBrainsMono Nerd Font Mono 24"

theme.bg_normal = "#212931"
theme.bg_focus = "#85ba86"
theme.bg_urgent = "#e25987"
theme.bg_minimize = "#181e30"
theme.bg_systray = theme.bg_normal

theme.fg_normal = "#aaaaaa"
theme.fg_focus = "#1b2128"
theme.fg_urgent = "#ffffff"
theme.fg_minimize = "#ffffff"

theme.useless_gap = dpi(10)
theme.border_width = dpi(5)
theme.border_color_normal = "#000000"
theme.border_color_active = "#b877b4"
theme.border_color_marked = "#91231c"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
-- theme.taglist_bg_focus = "#ff0000"

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path .. "default/submenu.png"
theme.menu_height = dpi(15)

theme.wibar_height = dpi(60)

theme.menu_width = dpi(100)

theme.wallpaper = themes_path .. "default/background.png"

-- Set different colors for urgent notifications.
rnotification.connect_signal('request::rules', function()
    rnotification.append_rule {
        rule = {
            urgency = 'critical'
        },
        properties = {
            bg = '#ff0000',
            fg = '#ffffff'
        }
    }
end)

return theme

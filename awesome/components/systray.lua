local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local theme = require("default.theme")

local systray = {}

local elMap = {{"", "asd"}, {"a", "asd"}}

function systray.init()
    local systrayEl = wibox.container.background()
    systrayEl.bg = "#00000000"

    local l = wibox.layout.fixed.horizontal()

    -- cicle elMap
    for _, v in pairs(elMap) do
        local el = wibox.container.background()

        el.bg = "#00000000"
        el.shape = gears.shape.rounded_rect
        el.widget = wibox.widget.textbox(v[1])

        el:connect_signal("button::release", function()
            awful.spawn.with_shell("sudo wpa_gui")
        end)

        l:add(el)
    end

    local tb1 = wibox.widget.textbox("foo")

    l:add(tb1)

    systrayEl.widget = l

    local button = awful.widget.button {
        image = image,
        buttons = {awful.button({}, 1, nil, function()
            print("Mouse was clicked")
        end), awful.button({}, 1, nil, function()
            print("asd")
        end)}
    }

    print("Systray was initialized")

    return systrayEl
end

return systray

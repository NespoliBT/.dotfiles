local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local taglist = {}

function taglist.init(s, barOrientation)
    local taglistWidget = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        layout = {
            layout = barOrientation
        },
        widget_template = {
            bg = "#0000ff00",
            widget = wibox.container.background,
            {
                left = 20,
                right = 20,
                top = 0,
                bottom = 0,
                widget = wibox.container.margin,
                {
                    widget = wibox.container.background,
                    id = "background_role",
                    {
                        left = 40,
                        right = 40,
                        widget = wibox.container.margin,
                        {
                            id = 'text_role',
                            widget = wibox.widget.textbox
                        }
                    }
                }
            }
        }
    }

    return taglistWidget
end

return taglist

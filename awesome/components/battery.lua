local awful = require("awful")

local theme = require("default.theme")

battery = awful.widget.watch('bash -c "acpi"', 5, function(widget, stdout)
    status = string.match(stdout, ": (%a+),")
    percentage = tonumber(string.match(stdout, "%d?%d%d"))

    batteryStr = percentage .. "%"

    if percentage < 10 then
        batteryStr = percentage .. "% "
    elseif percentage < 20 then
        batteryStr = percentage .. "% "
    elseif percentage < 30 then
        batteryStr = percentage .. "% "
    elseif percentage < 40 then
        batteryStr = percentage .. "% "
    elseif percentage < 50 then
        batteryStr = percentage .. "% "
    elseif percentage < 60 then
        batteryStr = percentage .. "% "
    elseif percentage < 70 then
        batteryStr = percentage .. "% "
    elseif percentage < 80 then
        batteryStr = percentage .. "% "
    elseif percentage < 90 then
        batteryStr = percentage .. "% "
    elseif percentage <= 100 then
        batteryStr = percentage .. "% "
    end

    batteryStr = batteryStr .. (status == "Charging" and "  " or " ")

    widget.text = batteryStr
    widget.font = theme.font_small

end)

return battery

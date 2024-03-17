import {
    Window,
    CenterBox,
    Box,
    Label,
} from 'resource:///com/github/Aylur/ags/widget.js';

const battery = await Service.import("battery")

const BatteryPercent = () => Label({ className: "percent" })
    .hook(battery, self => {
        self.label = ` ${battery.percent}%`
        self.visible = battery.available
    }, "changed")

const BatteryIcon = () => Label({ className: "icon" })
    .hook(battery, self => {
        let icon = ""
        if (battery.percent > 90) icon = "󰣐"
        else if (battery.percent > 60) icon = "󰁿"
        else if (battery.percent > 30) icon = "󰁼"
        else if (battery.percent > 10) icon = "󰁺"
        else icon = "󰂎"

        self.label = icon;
    }, "changed")

const BatteryStatus = () => Label({ className: "status" })
    .hook(battery, self => {
        self.label = battery.charging ? " 󱐋" : "";
    }, "changed")

const BatteryInfo = () =>
    Box({
        children: [
            BatteryIcon(),
            BatteryStatus(),
            BatteryPercent()
        ]
    })

export const BatteryM = () =>
    Box({
        className: "battery",
        child: BatteryInfo()
    })
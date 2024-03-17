import {
    Box,
    Label,
} from 'resource:///com/github/Aylur/ags/widget.js';

const WifiIcon = () => Label({ className: "icon", label: "󰤨" })
const WifiLabel = () => Label({
    label: ""
}).poll(2000, self => {
    self.label = Utils.exec('iwgetid -r') || ""
})

export const Wifi = () =>
    Box({
        className: "network",
        children: [
            WifiIcon(),
            WifiLabel()
        ]
    })

export const IP = () => Label({
    className: "ip",
    label: ""
}).poll(5000, self => {
    self.label = JSON.parse(Utils.exec("ip -json route get 8.8.8.8") || [{ prefsrc: "" }])[0].prefsrc
})
import {
    Slider,
    Box,
    Label,
} from 'resource:///com/github/Aylur/ags/widget.js';

const bInterface = Utils.exec("sh -c 'ls -w1 /sys/class/backlight | head -1'");
const brightnessFile = `/sys/class/backlight/${bInterface}/brightness`;
let brightness = Variable(Number(Utils.exec('brightnessctl get')));

Utils.monitorFile(brightnessFile, () => brightness.value = Number(Utils.exec('brightnessctl get')));

const BrightnessIcon = () => Label({ className: "icon", label: "󰃠" })
const BrightnessSlider = () => Slider({
    onChange: ({ value }) => Utils.exec(`brightnessctl s ${value}`),
    className: "slider",
    drawValue: false,
    value: brightness.bind(),
    min: 0,
    max: 255,
})

export const BrightnessM = () =>
    Box({
        className: "brightness",
        children: [
            BrightnessIcon(),
            BrightnessSlider()
        ]
    })
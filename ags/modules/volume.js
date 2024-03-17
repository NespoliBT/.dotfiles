import {
    Slider,
    Box,
    Label,
} from 'resource:///com/github/Aylur/ags/widget.js';

const audio = await Service.import('audio')

const VolumeIcon = () => Label({ className: "icon", label: "󰕾" })
const VolumeSlider = () => Slider({
    className: "slider",
    drawValue: false,
    onChange: ({ value }) => audio.speaker.volume = value,
    value: audio.speaker.bind('volume'),
})

export const VolumeM = () =>
    Box({
        className: "volume",
        children: [
            VolumeIcon(),
            VolumeSlider()
        ]
    })
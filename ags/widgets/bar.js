import {
    Window,
    CenterBox,
    Box,
    Label,
} from 'resource:///com/github/Aylur/ags/widget.js';
import { BatteryM } from "../modules/battery.js"
import { BrightnessM } from "../modules/brightness.js"
import { VolumeM } from "../modules/volume.js"
import { Workspaces } from "../modules/workspaces.js"
import { Wifi } from '../modules/network.js';
import { DateM } from '../modules/date.js';

const sentences = Utils.readFile(`${App.configDir}/consts/cits.txt`).split("\n")

const Left = () =>
    Box({
        className: "left",
        hpack: "start",
        children: [
            BatteryM(),
            BrightnessM(),
            VolumeM(),
            Workspaces()
        ]
    })

const Center = () =>
    Label({
        className: "center",
        hpack: "center",
        label: "",
    }).poll(3600000, self => {
        self.label = sentences[Math.floor((Math.random() * sentences.length))]
    })

const Right = () =>
    Box({
        className: "right",
        hpack: "end",
        children: [
            Wifi(),
            DateM()
        ]
    })

export const Bar = ({ monitor = 0 } = {}) =>
    Window({
        name: `bar${monitor || ''}`,
        monitor: monitor,
        anchor: ['top', 'left', 'right'],
        exclusivity: 'exclusive',
        child: CenterBox({
            className: 'bar',
            startWidget: Left(),
            centerWidget: Center(),
            endWidget: Right(),
        }),
    });
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
import { Players } from '../modules/music.js';
import { Connections } from '../modules/connections.js';

const Top = () =>
    Box({
        className: "top",
        vpack: "start",
        children: [
            Connections()
        ]
    })

const Center = () =>
    Box({
        className: "center"
    })

const Bottom = () =>
    Box({
        className: "bottom",
        vpack: "end",
        children: [
            Players(),
        ]
    })

export const Sidebar = ({ monitor = 0 } = {}) =>
    Window({
        name: `sidebar${monitor || ''}`,
        monitor: monitor,
        anchor: ['top', 'left', 'bottom'],
        exclusivity: 'ignore',
        child: CenterBox({
            className: 'sidebar',
            vertical: true,
            startWidget: Top(),
            centerWidget: Center(),
            endWidget: Bottom(),
        }),
    });
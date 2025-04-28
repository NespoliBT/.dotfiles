import {
    Window,
    CenterBox,
    Box,
    Label,
} from 'resource:///com/github/Aylur/ags/widget.js';
import { DateM } from '../modules/date.js';
import { IP } from '../modules/network.js';
import { Players } from '../modules/music.js';
import { Connections } from '../modules/connections.js';
import { PhoneStatus } from '../modules/phone.js';

const Motivation = () => Label({
    className: "title",
    label: "~ Porco Nettuno ~",
})

const Top = () => Box({
    className: "top",
    hpack: "center",
    homogeneous: true,
    children: [
        Motivation(),
        DateM(),
        IP()
    ]
})

const Center = () => Box({
    className: "center",
    children: [
        Players(),
        Connections(),
        PhoneStatus()
    ]
})

export const FullInfo = ({ monitor = 0 } = {}) =>
    Window({
        name: `fullInfo${monitor || ''}`,
        monitor: monitor,
        layer: "overlay",
        anchor: ['top', 'bottom', 'left', 'right'],
        exclusivity: "ignore",
        className: "fullInfo",
        visible: false,
        child: Box({
            vertical: true,
            children: [
                Top(),
                Center()
            ]
        })
    })
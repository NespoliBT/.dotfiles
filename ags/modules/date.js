import {
    Box,
    Label,
} from 'resource:///com/github/Aylur/ags/widget.js';

const DateLabel = () => Label({
    label: ""
}).poll(1000, label => label.label = Utils.exec('date +"%d %B - %H:%M"'))

export const DateM = () =>
    Box({
        className: "date",
        hpack: "center",
        child: DateLabel()
    })
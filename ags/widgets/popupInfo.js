import {
    Window,
    CenterBox,
    Box,
    Label,
} from 'resource:///com/github/Aylur/ags/widget.js';

import { NotificationPopups } from '../modules/notificationPopup.js';

export const PopupInfo = ({ monitor = 0 } = {}) =>
    Window({
        name: `popupInfo${monitor || ''}`,
        monitor: monitor,
        layer: "overlay",
        anchor: ['bottom', 'left'],
        exclusivity: "ignore",

        child: Box({
            className: "popupInfo",
            child: NotificationPopups()
        })
    })
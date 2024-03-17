import {
    Box,
    Label,
    EventBox,
    Button
} from 'resource:///com/github/Aylur/ags/widget.js';

const notifications = await Service.import("notifications")

notifications.popupTimeout = 10000;

function NotificationIcon(n) {
    console.log(n.appName);
    const iconMap = {
        "Spotify": "",
        "Telegram Desktop": ""
    }

    return Label(iconMap[n.appName] || "")
}

const Notification = (n) => {
    const icon = Box({
        vpack: "start",
        className: "icon",
        child: NotificationIcon(n),
    })

    const title = Label({
        className: "title",
        xalign: 0,
        justification: "left",
        hexpand: true,
        max_width_chars: 24,
        truncate: "end",
        wrap: true,
        label: n.summary,
        use_markup: true,
    })

    const body = Label({
        className: "body",
        hexpand: true,
        use_markup: true,
        xalign: 0,
        justification: "left",
        label: n.body,
        wrap: true,
    })

    const actions = Box({
        className: "actions",
        children: n.actions.map(({ id, label }) => Button({
            class_name: "action-button",
            on_clicked: () => {
                n.invoke(id)
                n.dismiss()
            },
            hexpand: true,
            child: Label(label),
        })),
    })

    return EventBox(
        {
            attribute: { id: n.id },
            on_primary_click: n.dismiss,
        },
        Box(
            {
                className: `notification ${n.urgency}`,
                vertical: true,
            },
            Box([
                icon,
                Box(
                    { vertical: true, vpack: "center" },
                    title,
                    body,
                ),
            ]),
            actions,
        ),
    )
}

export const NotificationPopups = () => {
    const list = Box({
        vertical: true,
        spacing: 32,
        children: notifications.popups.map(Notification),
    })

    function onNotified(_, /** @type {number} */ id) {
        const n = notifications.getNotification(id)
        if (n)
            list.children = [Notification(n), ...list.children]
    }

    function onDismissed(_, /** @type {number} */ id) {
        list.children.find(n => n.attribute.id === id)?.destroy()
    }

    list.hook(notifications, onNotified, "notified")
        .hook(notifications, onDismissed, "dismissed")

    return Box({
        css: "min-width: 0px; min-height: 0px;",
        class_name: "notifications",
        hpack: "center",
        vertical: true,
        child: list,
    })
}
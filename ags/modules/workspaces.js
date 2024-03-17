import {
    Button,
    Label,
} from 'resource:///com/github/Aylur/ags/widget.js';

const hyprland = await Service.import('hyprland')

const icons = ["", "", "", "", "󰎆", "-", "-", "-", "-"];

export const Workspaces = () => {
    const activeId = hyprland.active.workspace.bind("id")
    const workspaces = hyprland.bind("workspaces")
        .as(ws => ws.sort((a, b) => a.id > b.id).map(
            ({ id }) => Button(
                {
                    onClicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
                    child: Label({
                        label: `${icons[id - 1]}`,
                        className: activeId.as(i => `${i === id ? "focus" : ""}`)
                    }),
                    className: "workspace",
                }
            )
        ))

    return Widget.Box({
        className: "workspaces",
        children: workspaces,
    })
}
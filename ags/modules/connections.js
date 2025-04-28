import {
    Box,
    Button,
    Label
} from 'resource:///com/github/Aylur/ags/widget.js';

let connections = Utils.exec(`wpa_cli list_networks`)
    .split("\n").map((c) => {
        const connArray = c.split("\t")

        return {
            id: connArray[0],
            name: connArray[1],
            selected: connArray[3] == "[CURRENT]"
        }
    }).filter((item, index, self) =>
        index === self.findIndex((t) => t.name === item.name) && index
    )

setInterval(() => {
    connections = Utils.exec(`wpa_cli list_networks`)
        .split("\n").map((c) => {
            const connArray = c.split("\t")

            return {
                id: connArray[0],
                name: connArray[1],
                selected: connArray[3] == "[CURRENT]"
            }
        }).filter((item, index, self) =>
            index === self.findIndex((t) => t.name === item.name) && index
        )
}, 5000);


const ConnectionsContainer = () => Box({
    className: "connectionsContainer",
    vertical: true,
    children: []
}).poll(5000, self => {
    self.children = connections.map((c) => {
        return Button({
            className: `${c.selected ? "selected" : "asd"}`,
            onClicked: () => Utils.exec(`wpa_cli select_network ${c.id}`),
            child: Label(c.name)
        })
    })
})

export const Connections = () => Box({
    className: "connections",
    vertical: true,
    children: [
        Label({
            className: "title",
            label: "L'internet",
            hpack: "center"
        }),
        ConnectionsContainer()
    ]
})
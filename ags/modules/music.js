import {
    Box,
    Label,
    CenterBox,
    Button
} from 'resource:///com/github/Aylur/ags/widget.js';

const mpris = await Service.import('mpris')

let playersCount = 0;

const Cover = (player, full) => Box({
    className: "cover",
    children: full ? [Info(player)] : []
}).hook(player, self => {
    self.css = `background-image: url('${player.trackCoverUrl}');`
})

const Info = (player) => Box({
    vertical: true,
    className: "info",
    hpack: "fill",
    hexpand: true,
    vpack: "end",
    children: [
        Label({
            className: "title",
            wrap: true,
            justification: 'left',
            maxWidthChars: 32,
            hpack: "start",
        }).hook(player, self => {
            self.label = player.trackTitle
        }),
        Label({
            className: "author",
            wrap: true,
            justification: 'left',
            maxWidthChars: 32,
            hpack: "start",
        }).hook(player, self => {
            self.label = player.trackArtists.join(', ')
        }),
    ]
})

const Commands = (player) => CenterBox({
    className: "commands",
    startWidget: Button({
        className: "button",
        hpack: "start",
        onClicked: () => player.previous(),
        child: Widget.Label('󰒮'),
    }),
    centerWidget: Button({
        className: "button",
        hpack: "center",
        onClicked: () => player.playPause(),
        child: Widget.Label().hook(player, self => {
            self.label = player.playBackStatus == "Paused" ? "" : ""
        }),
    }),
    endWidget: Button({
        className: "button",
        hpack: "end",
        onClicked: () => player.next(),
        child: Widget.Label('󰒭'),
    }),
})

const FullPlayer = (player) => Box({
    className: "fullPlayer",
    vertical: true,
    hexpand: false,
    children: [
        Cover(player, true),
        Commands(player),
    ],
})

const HalfPlayer = (player) => Box({
    className: "halfPlayer",
    hexpand: false,
    children: [
        Cover(player, false),
        Box({
            vertical: true,
            hpack: "center",
            children: [
                Info(player),
                Commands(player, false)
            ]
        })
    ]
})

export const Players = () => Widget.Box({
    className: "players",
    vertical: true,
    children: mpris.bind('players').as(p => {
        playersCount = p.length;

        if (playersCount > 1)
            return p.map(HalfPlayer)
        else
            return p.map(FullPlayer)
    })
})

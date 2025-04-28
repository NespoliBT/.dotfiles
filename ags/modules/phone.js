import {
    Button,
    Label,
    Box
} from 'resource:///com/github/Aylur/ags/widget.js';

export const PhoneStatus = () => {
    return Box({
        vexpand: false,
        hexpand: false,
        vertical: true,
        child:
            Box({
                vexpand: false,
                hexpand: false,
                vertical: true,
                className: "phoneStatus",
                children: [
                    Label({
                        label: "Status Telefono",
                        className: "title"
                    }),
                    Button({
                        className: "statusButton",
                        vexpand: false,
                        hexpand: true,
                        hpack: "fill",
                        onClicked: () => {
                            let out = Utils.exec("python /home/nespoli/.dotfiles/scripts/phone_tunnel.py mount")
                            console.log(out);
                        },
                        child: Label({
                            label: "...",
                            vexpand: false,
                            hpack: "fill",
                            className: "inactive"
                        }).poll(5000, self => {
                            let status = Utils.exec("python /home/nespoli/.dotfiles/scripts/phone_tunnel.py status")

                            if (status == "true") {
                                self.label = ""
                                self.className = "active"
                            } else {
                                self.label = ""
                                self.className = "inactive"
                            }
                        }
                        ),
                    })]
            })
    })
}
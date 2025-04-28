import { Box, Label } from "resource:///com/github/Aylur/ags/widget.js";

const WifiIcon = () => Label({ className: "icon", label: "󰤨" });
const WifiLabel = () =>
  Label({
    label: "",
  }).poll(2000, (self) => {
    self.label = Utils.exec("iwgetid -r") || "";
  });

export const Wifi = () =>
  Box({
    className: "network",
    children: [WifiIcon(), WifiLabel()],
  });

export const IP = () =>
  Label({
    className: "ip",
    label: "",
  }).poll(5000, (self) => {
    // JS ERROR: SyntaxError: JSON.parse: unexpected character at line 1 column 1 of the JS
    // self.label = JSON.parse(Utils.exec("ip -json route get 8.8.8.8") || [{ prefsrc: "" }])[0].prefsrc
    let ip = Utils.exec("ip -json route get 8.8.8.8");

    try {
      JSON.parse(ip).forEach((route) => {
        if (route.prefsrc) self.label = route.prefsrc;
      });
    } catch (error) {
      console.error("Error parsing ip");
    }
  });

import "./globals";

import Bar from "./widgets/Bar";
import ThemeChanger from "./widgets/ThemeChanger";
import SideBar from "./widgets/SideBar";
import Notification from "./widgets/Notification";
import AppsWindow from "./widgets/Apps";
import Volume from "./widgets/Volume";

import style from "./scss/main.scss";

import { monitorFile } from "astal/file";
import { App } from "astal/gtk3";
import { exec, subprocess } from "astal/process";

const monitors = App.get_monitors();

subprocess(
  "sass -w ./scss/main.scss /tmp/style.css",
  (out) => console.log(out),
  (err) => console.error(err)
);

monitorFile("/tmp/style.css", () => {
  App.apply_css("/tmp/style.css");
});

App.start({
  css: style,
  requestHandler(request: string, res: (response: any) => void) {
    if (request == "reload scss") {
      exec("sass ./scss/main.scss /tmp/style.css");
      App.apply_css("/tmp/style.css");
      return res("Reloaded SCSS <[=].[=]> ");
    }

    if (request == "toggle launcher") {
      const current = OPEN_APP_LAUNCHER.get();
      OPEN_APP_LAUNCHER.set(!current);
      return res("Toggled App Launcher <[=].[=]> ");
    }

    if (request == "toggle sidebar") {
      const current = OPEN_SIDE_BAR.get();
      OPEN_SIDE_BAR.set(!current);
      return res("Toggled Side Bar <[=].[=]> ");
    }

    return res("Command not recognized <[=].[=]> ");
  },
  main: () => {
    monitors.map((monitor) => {
      SideBar(monitor);
      ThemeChanger(monitor);
      Bar(monitor);
      AppsWindow(monitor);
      Volume(monitor);
    });
    Notification(monitors[0]);
  },
});

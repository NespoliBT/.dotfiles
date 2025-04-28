import Bar from "./widgets/Bar";
import ThemeChanger from "./widgets/ThemeChanger";
import SideBar from "./widgets/SideBar";
import Notification from "./widgets/Notification";
import { App } from "astal/gtk3";
import style from "./scss/main.scss";
import "./globals";
import AppsWindow from "./widgets/Apps";

const monitors = App.get_monitors();

App.start({
  css: style,
  main: () => {
    monitors.map((monitor) => {
      Bar(monitor);
      ThemeChanger(monitor);
      SideBar(monitor);
      AppsWindow(monitor);
    });
    Notification(monitors[0]);
  },
});

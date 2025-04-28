import {
  Window,
  CenterBox,
  Box,
  EventBox,
  Label,
} from "resource:///com/github/Aylur/ags/widget.js";

const hyprland = await Service.import("hyprland");

import { Image } from "../modules/image.js";

let open = Variable(false);
const hyprPath = `${App.configDir}/../../.config/hypr`;
let firstHover = true;
let prevWorkspace = 0;

const handleHover = () => {
  if (firstHover) {
    prevWorkspace = hyprland.active.workspace.id;
    hyprland.messageAsync(`dispatch workspace 9`);
  }
  firstHover = false;
};

const changeTheme = (t) => {
  console.log("change theme");
};

const setTheme = (t) => {
  Utils.execAsync(`cp ${t.background} ${hyprPath}/background.jpg`).catch(
    (err) => print(err)
  );
  Utils.execAsync(`cp ${t.image} ${App.configDir}/img.jpg`).catch((err) =>
    print(err)
  );
  Utils.execAsync("ags --toggle-window 'themeChanger'").catch((err) =>
    print(err)
  );
  Utils.execAsync(`wal -n -i ${t.background}`).catch((err) => print(err));

  console.log(t.image);

  Utils.execAsync(`cp ${t.scss} ${App.configDir}/scss/variables.scss`);
  Utils.execAsync(`swww img ${t.background} --transition-type center`);
  Utils.execAsync(`cp ${t.hyprColors} ${hyprPath}/hypr-colors.conf`).catch(
    (err) => print(err)
  );

  // hyprland.messageAsync(`dispatch workspace ${prevWorkspace}`)

  firstHover = true;
};

const Themes = (themes) => {
  let themesPagination = [];

  let page = 0;
  themes.forEach((t, i) => {
    if (i % 3 == 0) {
      page = i / 3;
      themesPagination[page] = [];
    }
    themesPagination[page].push(t);
  });

  const list = themesPagination.map((p) => {
    return Box({
      className: "row",
      homogeneous: true,
      spacing: 32,
      children: p.map((t) => {
        return EventBox({
          onHover: () => changeTheme(t),
          onPrimaryClickRelease: () => setTheme(t),

          className: "theme",
          child: Box({
            hpack: "center",
            vpack: "center",
            child: Image(t.background, 360, 540),
          }),
        });
      }),
    });
  });

  return Box({
    className: "list",
    vertical: true,
    spacing: 32,
    children: list,
  });
};

const ThemesContainer = (themes) => {
  return Box({
    className: "container",
    vertical: true,
    hpack: "center",
    vpack: "center",
    children: [
      Label({
        className: "title",
        label: "~ Scegli responsabilmente ~",
        hpack: "center",
      }),
      Themes(themes),
    ],
  });
};

export const ThemeChanger = (themes, monitor = 0) => {
  const window = Window({
    name: `themeChanger${monitor || ""}`,
    monitor: monitor,
    layer: "overlay",
    anchor: ["top", "bottom", "left", "right"],
    exclusivity: "ignore",
    visible: open.bind(),
    child: EventBox({
      // onHover: () => handleHover(),
      className: "themeChanger",
      child: ThemesContainer(themes),
    }),
  });

  return window;
};

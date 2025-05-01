import { Astal, Gtk, Gdk, astalify, App } from "astal/gtk3";
import Title from "./Title";
import { timeout, Variable, bind } from "astal";
import { exec, execAsync } from "astal/process";
import { writeFile } from "astal/file";

import GLib from "gi://GLib";

const HOME = GLib.getenv("HOME");
const appDir = `${HOME}/.dotfiles/astal`;

const setTheme = (t) => {
  const hyprPath = `${appDir}/../hypr`;
  execAsync(
    `swww img ${t.background} --transition-type wave --transition-angle 180`
  );

  execAsync(`cp ${t.image} ${hyprPath}/img.jpg`).catch((err) => print(err));
  execAsync(`cp ${t.background} ${hyprPath}/background.jpg`).catch((err) =>
    print(err)
  );
  execAsync(`wal -n -i ${t.background}`).catch((err) => print(err));

  execAsync(`cp ${t.hyprColors} ${hyprPath}/hypr-colors.conf`).catch((err) =>
    print(err)
  );
  execAsync(`cp ${t.scss} ${appDir}/scss/variables.scss`).then(() => {
    exec(`sass ${appDir}/scss/main.scss /tmp/style.css`);

    App.apply_css("/tmp/style.css");
  });

  writeFile(`${appDir}/consts/theme.txt`, t.name);
};

const getThemes = () => {
  const themes = exec(`ls ${appDir}/themes`).split("\n");
  const themesMap = themes.map((theme) => {
    const path = `${appDir}/themes/${theme}`;
    const colors = exec(`cat ${path}/variables.scss`)
      .split("\n")
      .slice(0, 9)
      .map((c) => c.split(":")[1].replace(";", "").trim());

    return {
      name: theme,
      path,
      colors,
      scss: `${path}/variables.scss`,
      background: `${path}/background.jpg`,
      image: `${path}/img.jpg`,
      hyprColors: `${path}/hypr-colors.conf`,
    };
  });

  return themesMap;
};

const Themes = () => {
  const themes = getThemes();
  const pages = [];

  const themePerPage = 3;

  for (let i = 0; i < themes.length; i += themePerPage) {
    pages.push(themes.slice(i, i + themePerPage));
  }

  return (
    <box className="themes" vertical={Gtk.Orientation.VERTICAL}>
      {pages.map((page, index) => {
        return (
          <box
            className="page"
            halign={Gtk.Align.CENTER}
            valign={Gtk.Align.CENTER}
          >
            {page.map((theme) => {
              return (
                <box className="theme" vertical={Gtk.Orientation.VERTICAL}>
                  <button
                    className="image"
                    cursor={"pointer"}
                    css={`
                      background-image: url("${theme.background}");
                    `}
                    onClicked={() => {
                      setTheme(theme);
                    }}
                  />
                  <box
                    className="colors"
                    vertical={Gtk.Orientation.HORIZONTAL}
                    halign={Gtk.Align.CENTER}
                    valign={Gtk.Align.END}
                    css={`
                      background-color: ${theme.colors[0]};
                    `}
                  >
                    {theme.colors.map((color, i) => {
                      return i == 0 || i == 1 ? null : (
                        <box
                          className="color"
                          css={`
                            background-color: ${color};
                          `}
                        ></box>
                      );
                    })}
                  </box>
                </box>
              );
            })}
          </box>
        );
      })}
    </box>
  );
};

const ThemeChanger = (monitor = 0) => {
  const { TOP, LEFT, RIGHT, BOTTOM } = Astal.WindowAnchor;

  const isHover = Variable(false);
  return (
    <window
      className="ThemeChanger"
      gdkmonitor={monitor}
      exclusivity={Astal.Exclusivity.NONE}
      anchor={TOP | LEFT | RIGHT}
    >
      <eventbox
        valign={Gtk.Align.START}
        halign={Gtk.Align.CENTER}
        onHover={() => {
          isHover.set(true);
        }}
        onHoverLost={() => {
          isHover.set(false);
        }}
      >
        <revealer
          transitionType={Gtk.RevealerTransitionType.SLIDE_UP}
          revealChild={isHover(() => isHover.get())}
          className="revealer"
        >
          <box
            valign={Gtk.Align.START}
            halign={Gtk.Align.CENTER}
            vertical={Gtk.Orientation.VERTICAL}
            className="themeChanger"
          >
            <Title color={6} size={70}>
              Scegli responsabilmente
            </Title>
            <Themes />
          </box>
        </revealer>
      </eventbox>
    </window>
  );
};

export default ThemeChanger;

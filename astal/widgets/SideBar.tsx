import { Astal, Gtk, Gdk, astalify, App } from "astal/gtk3";
import Title from "./Title";
import { Variable, bind } from "astal";
import { exec, execAsync } from "astal/process";
import { readFile, monitorFile } from "astal/file";
import Network from "gi://AstalNetwork";
import GLib from "gi://GLib";

const HOME = GLib.getenv("HOME");
const appDir = `${HOME}/.dotfiles/astal`;

const NetworksEl = () => {
  const network = Network.get_default();
  network.wifi.scan();

  const networks = network.wifi.get_access_points();

  let tmpSet = new Set();
  const networkSet = Variable(
    networks
      .filter((n) => {
        if (tmpSet.has(n.ssid)) {
          return false;
        } else {
          tmpSet.add(n.ssid);
          return true;
        }
      })
      .sort((a, b) => {
        return b.strength - a.strength;
      })
  );

  tmpSet = new Set();

  setInterval(() => {
    let tmpSet = new Set();
    networkSet.set(
      network.wifi
        .get_access_points()
        .filter((n) => {
          if (tmpSet.has(n.ssid)) {
            return false;
          } else {
            tmpSet.add(n.ssid);
            return true;
          }
        })
        .sort((a, b) => {
          return b.strength - a.strength;
        })
    );
  }, 5000);

  return (
    <scrollable
      className="networkList"
      vertical={Gtk.Orientation.VERTICAL}
      heightRequest={460}
    >
      <box orientation={1}>
        {bind(networkSet).as(() => {
          const currentNetwork = network.wifi.get_active_access_point()?.ssid;

          const networkSetEl = networkSet.get().map((n) => {
            return (
              <button
                className={`network ${
                  n.ssid == currentNetwork ? "active" : ""
                }`}
                hexpand
                cursor={"pointer"}
                onClicked={() => {
                  execAsync(`nmcli device wifi connect "${n.ssid}"`)
                    .then((r) => {
                      console.log(r);
                    })
                    .catch((e) => {
                      print(e);
                    });
                }}
              >
                <box>
                  <label hexpand halign={Gtk.Align.START} className="name">
                    {n.ssid || n.bssid}
                  </label>
                  <icon
                    halign={Gtk.Align.END}
                    icon={bind(n, "iconName")}
                    className="icon"
                  />
                </box>
              </button>
            );
          });

          return networkSetEl;
        })}
      </box>
    </scrollable>
  );
};

const Profile = () => {
  const currentTheme = Variable(
    readFile(`${appDir}/consts/theme.txt`).split("\n")[0].trim()
  );

  monitorFile(`${appDir}/consts/theme.txt`, () => {
    currentTheme.set(
      readFile(`${appDir}/consts/theme.txt`).split("\n")[0].trim()
    );
  });

  return (
    <box className="profile" halign={Gtk.Align.CENTER}>
      <box
        className="image"
        css={bind(currentTheme).as(
          (t) => `
                background-image: url("${appDir}/themes/${t}/img.jpg");`
        )}
      />
    </box>
  );
};

const SideBar = (monitor = 0) => {
  const { TOP, LEFT, RIGHT, BOTTOM } = Astal.WindowAnchor;

  const isHover = Variable(false);

  return (
    <window
      className="SideBar"
      gdkmonitor={monitor}
      exclusivity={Astal.Exclusivity.NONE}
      anchor={RIGHT | TOP | BOTTOM}
    >
      <eventbox
        onHover={() => {
          isHover.set(true);
        }}
        onHoverLost={() => {
          isHover.set(false);
        }}
      >
        <revealer
          transitionType={Gtk.RevealerTransitionType.SLIDE_LEFT}
          revealChild={isHover(() => isHover.get())}
          className="revealer"
        >
          <box
            halign={Gtk.Align.CENTER}
            vertical={Gtk.Orientation.VERTICAL}
            className="sidebar"
          >
            <Title color={7} size={40}>
              Che dio ci aiuti
            </Title>
            <Profile />
            <box className="divider" />
            <NetworksEl />
            <box className="divider" />
          </box>
        </revealer>
      </eventbox>
    </window>
  );
};

export default SideBar;

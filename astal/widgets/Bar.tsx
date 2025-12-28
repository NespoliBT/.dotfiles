import { Astal, Gtk, Gdk, astalify, App } from "astal/gtk3";
import { monitorFile, readFile } from "astal/file";
import { exec } from "astal/process";
import { timeout, Variable, bind } from "astal";
import Battery from "gi://AstalBattery";
import Wp from "gi://AstalWp";
import Network from "gi://AstalNetwork";
import Bluetooth from "gi://AstalBluetooth";
import Hyprland from "gi://AstalHyprland";
import Search from "./Search";
import GLib from "gi://GLib";

const HOME = GLib.getenv("HOME");
const appDir = `${HOME}/.dotfiles/astal`;
const sentences = readFile(`${appDir}/consts/cits.txt`).split("\n");

const BatteryEl = () => {
  const bat = Battery.get_default();

  return (
    <box className="battery" valign={Gtk.Align.END}>
      <icon icon={bind(bat, "batteryIconName")} />
      <levelbar
        value={bind(bat, "percentage").as((p) => p)}
        min={0}
        max={1}
        widthRequest={100}
        hexpand
      />
    </box>
  );
};

const BrightnessEl = () => {
  const bInterface = exec("sh -c 'ls -w1 /sys/class/backlight | head -1'");
  const brightnessFile = `/sys/class/backlight/${bInterface}/brightness`;
  const maxBrightness = Number(
    exec(`cat /sys/class/backlight/${bInterface}/max_brightness`)
  );
  const brightness = Variable(
    Number(exec("brightnessctl get")) / maxBrightness
  );

  monitorFile(brightnessFile, () =>
    brightness.set(Number(exec("brightnessctl get")) / maxBrightness)
  );

  return (
    <box className="brightness">
      <label>󰃠</label>
      <slider
        widthRequest={100}
        hexpand
        min={0}
        max={1}
        cursor={"col-resize"}
        onDragged={(self) => {
          const value = self.value;
          brightness.set(value * maxBrightness);
          exec(`brightnessctl s ${value * maxBrightness}`);
        }}
        value={bind(brightness)}
      />
    </box>
  );
};

const VolumeEl = () => {
  const speaker = Wp.get_default()?.audio.defaultSpeaker!;

  return (
    <box className="volume">
      <icon icon={bind(speaker, "volumeIcon")} />
      <slider
        hexpand
        onDragged={({ value }) => (speaker.volume = value)}
        value={bind(speaker, "volume")}
        cursor={"col-resize"}
      />
    </box>
  );
};

const QuickSettings = () => {
  const network = Network.get_default();
  const bluetooth = Bluetooth.get_default();

  return (
    <box className="quicksettings">
      <box className="col" vertical={Gtk.Orientation.VERTICAL}>
        <button
          onClicked={() => {
            network.wifi.enabled = !network.wifi.enabled;
          }}
          className={bind(network.wifi, "enabled").as((apm) =>
            apm == true ? "toggle enabled" : "toggle"
          )}
          vexpand
        >
          <label>
            {bind(network.wifi, "enabled").as((apm) =>
              apm == true ? "" : "󰀝"
            )}
          </label>
        </button>
        <button
          className={bind(bluetooth, "enabled").as((bt) =>
            bt == true ? "toggle enabled" : "toggle"
          )}
          vexpand
        >
          <label></label>
        </button>
      </box>
    </box>
  );
};

const Left = () => {
  return (
    <box className="left subbox" halign={Gtk.Align.START}>
      <box
        className="status"
        halign={Gtk.Align.START}
        vertical={Gtk.Orientation.VERTICAL}
        valign={Gtk.Align.END}
      >
        <BatteryEl />
        <BrightnessEl />
        <VolumeEl />
      </box>

      <QuickSettings />
    </box>
  );
};

const Sentences = () => {
  const sentence = Variable(sentences[0]);
  let i = 0;

  setInterval(() => {
    i++;
    if (i >= sentences.length) {
      i = 0;
    }
    sentence.set(sentences[i]);
  }, 15000);

  return (
    <box
      className="sentences"
      vexpand={false}
      valign={Gtk.Align.END}
      halign={Gtk.Align.END}
    >
      <label>{bind(sentence)}</label>
    </box>
  );
};

const WorkspaceEl = () => {
  const hypr = Hyprland.get_default();
  const icons = ["", "", "", "", "󰎆"];

  return (
    <box
      className="workspaces"
      vexpand={false}
      valign={Gtk.Align.END}
      halign={Gtk.Align.CENTER}
    >
      {bind(hypr, "workspaces").as((wss) =>
        wss
          .sort((a, b) => a.id - b.id)
          .map((ws) => (
            <button
              className={bind(hypr, "focusedWorkspace").as((fw) =>
                ws === fw ? "focused" : ""
              )}
              onClicked={() => ws.focus()}
              cursor={"pointer"}
            >
              {icons[ws.id - 1] ?? "-"}
            </button>
          ))
      )}
    </box>
  );
};

const DateEl = () => {
  const date = Variable(
    new Date().toLocaleDateString("it-IT", {
      timeZone: "Europe/Rome",
      month: "long",
      day: "2-digit",
    }) +
      " " +
      new Date().toLocaleTimeString("it-IT", {
        timeZone: "Europe/Rome",
        hour: "2-digit",
        minute: "2-digit",
      })
  );

  setInterval(() => {
    date.set(
      new Date().toLocaleDateString("it-IT", {
        timeZone: "Europe/Rome",
        month: "long",
        day: "2-digit",
      }) +
        " - " +
        new Date().toLocaleTimeString("it-IT", {
          timeZone: "Europe/Rome",
          hour: "2-digit",
          minute: "2-digit",
        })
    );
  }, 1000);

  return (
    <box
      className="date"
      vexpand={false}
      valign={Gtk.Align.END}
      halign={Gtk.Align.END}
    >
      <label className="text" halign={Gtk.Align.CENTER}>
        {bind(date)}
      </label>
    </box>
  );
};

const Right = () => {
  return (
    <box
      className="right subbox"
      valign={Gtk.Align.END}
      halign={Gtk.Align.END}
      vertical={Gtk.Orientation.VERTICAL}
    >
      <Sentences />
      <DateEl />
    </box>
  );
};

const Center = () => {
  return (
    <box
      className="center subbox"
      halign={Gtk.Align.CENTER}
      vexpand={false}
      valign={Gtk.Align.END}
      vertical={Gtk.Orientation.VERTICAL}
    >
      <Search />
      <WorkspaceEl />
    </box>
  );
};

const Bar = (monitor = 0) => {
  const { TOP, LEFT, RIGHT, BOTTOM } = Astal.WindowAnchor;
  const isHover = Variable(false);

  const window = (
    <window
      name="Bar"
      className="Bar"
      title="Bar"
      gdkmonitor={monitor}
      exclusivity={Astal.Exclusivity.NONE}
      anchor={BOTTOM | LEFT | RIGHT}
      keymode={Astal.Keymode.ON_DEMAND}
      setup={(self) => {
        App.add_window(self);
      }}
      onKeyPressEvent={(self, event) => {
        const key = event.get_keyval()[1];
        const apps = APP_LIST.get();
        const selected = SELECTED_APP.get();

        const index = apps.findIndex((app: any) => app.entry == selected);
        switch (key) {
          case 65362: // Up arrow
            let prevIndex = (index - 1 + apps.length) % apps.length;
            if (prevIndex < 0) {
              prevIndex = apps.length - 1;
            }
            SELECTED_APP.set(apps[prevIndex]);
            break;

          case 65364: // Down arrow
            let nextIndex = (index + 1) % apps.length;
            if (nextIndex >= apps.length) {
              nextIndex = 0;
            }
            SELECTED_APP.set(apps[nextIndex]);
            break;

          case 65307: // Escape
            OPEN_APP_LAUNCHER.set(false);
            APP_LIST.set([]);
            break;
        }
      }}
    >
      <eventbox
        onHover={() => isHover.set(true)}
        onHoverLost={() => {
          isHover.set(false);
          OPEN_APP_LAUNCHER.set(false);
        }}
      >
        <revealer
          transitionType={Gtk.RevealerTransitionType.SLIDE_UP}
          revealChild={isHover(() => isHover.get())}
          className="revealer"
        >
          <centerbox className="centerbox">
            <Left />
            <Center />
            <Right />
          </centerbox>
        </revealer>
      </eventbox>
    </window>
  );

  OPEN_APP_LAUNCHER.subscribe((open) => {
    if (open) {
      window.set_keymode(Astal.Keymode.EXCLUSIVE);
      isHover.set(true);
    } else {
      window.set_keymode(Astal.Keymode.ON_DEMAND);
      isHover.set(false);
    }
  });

  return window;
};

export default Bar;

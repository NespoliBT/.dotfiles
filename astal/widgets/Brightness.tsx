import { Astal, Gtk, Gdk, astalify } from "astal/gtk3";
import { timeout, Variable, bind } from "astal";
import { exec } from "astal/process";
import { monitorFile } from "astal/file";

const Brightness = (monitor = 0) => {
  const { TOP, LEFT, RIGHT, BOTTOM, CENTER } = Astal.WindowAnchor;

  const bInterface = exec("sh -c 'ls -w1 /sys/class/backlight | head -1'");
  const brightnessFile = `/sys/class/backlight/${bInterface}/brightness`;
  const maxBrightness = Number(
    exec(`cat /sys/class/backlight/${bInterface}/max_brightness`)
  );
  const brightness = Variable(
    Number(exec("brightnessctl get")) / maxBrightness
  );

  const isOpen = Variable(false);

  let timeout = setTimeout(() => {
    isOpen.set(false);
  }, 2000);

  monitorFile(brightnessFile, () => {
    brightness.set(Number(exec("brightnessctl get")) / maxBrightness);

    clearTimeout(timeout);

    isOpen.set(true);
    timeout = setTimeout(() => {
      isOpen.set(false);
    }, 2000);
  });

  return (
    <window
      className="Brightness"
      gdkmonitor={monitor}
      exclusivity={Astal.Exclusivity.NONE}
      anchor={CENTER}
      layer={bind(isOpen).as((open) => (open ? 3 : 1))}
    >
      <revealer
        transitionType={Gtk.RevealerTransitionType.CROSSFADE}
        revealChild={bind(isOpen).as((open) => open)}
        className="revealer"
      >
        <box className="brightnessContainer">
          <icon icon="display-brightness-symbolic" />
          <slider
            widthRequest={200}
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
      </revealer>
    </window>
  );
};

export default Brightness;

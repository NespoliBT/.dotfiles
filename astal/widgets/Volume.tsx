import { Astal, Gtk, Gdk, astalify } from "astal/gtk3";
import { timeout, Variable, bind } from "astal";

const Volume = (monitor = 0) => {
  const { TOP, LEFT, RIGHT, BOTTOM } = Astal.WindowAnchor;
  const speaker = Wp.get_default()?.audio.defaultSpeaker!;
  const isOpen = Variable(false);

  speaker.subscribe(() => {
    isOpen.set(true);
    timeout(2000).then(() => {
      isOpen.set(false);
    });
  });

  return (
    <window
      className="Volume"
      gdkmonitor={monitor}
      exclusivity={Astal.Exclusivity.NONE}
      anchor={BOTTOM | LEFT | RIGHT}
    >
      <revealer
        transitionType={Gtk.RevealerTransitionType.SLIDE_UP}
        revealChild={bind(isOpen).as((open) => open)}
        className="revealer"
      >
        asd
      </revealer>
    </window>
  );
};

export default Volume;

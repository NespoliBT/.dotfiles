import { Astal, Gtk, Gdk, astalify } from "astal/gtk3";
import { timeout, Variable, bind } from "astal";

const Volume = (monitor = 0) => {
  const { TOP, LEFT, RIGHT, BOTTOM } = Astal.WindowAnchor;

  const isOpen = Variable(true);

  return (
    <window
      className="Notification"
      gdkmonitor={monitor}
      exclusivity={Astal.Exclusivity.NONE}
      anchor={BOTTOM | LEFT | RIGHT}
    >
      <revealer
        transitionType={Gtk.RevealerTransitionType.SLIDE_UP}
        revealChild={isOpen.get()}
        className="revealer"
      >
        asd
      </revealer>
    </window>
  );
};

export default Volume;

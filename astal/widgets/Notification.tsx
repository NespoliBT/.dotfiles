import { Astal, Gtk, Gdk, astalify } from "astal/gtk3";
import { timeout, Variable, bind } from "astal";
import Notifd from "gi://AstalNotifd";

const Notification = (monitor = 0) => {
  const { TOP, LEFT, RIGHT, BOTTOM } = Astal.WindowAnchor;
  const notifd = Notifd.get_default();

  const isHover = Variable(false);
  const isOpen = Variable(false);
  const lastNotification = Variable(null);

  notifd.connect("notified", (_, id) => {
    const n = notifd.get_notification(id);

    lastNotification.set(n);
    isHover.set(true);
    setTimeout(() => {
      isHover.set(false);
    }, 5000);
  });

  return (
    <window
      className="Notification"
      gdkmonitor={monitor}
      exclusivity={Astal.Exclusivity.NONE}
      anchor={TOP | LEFT}
    >
      <eventbox
        onHover={() => isHover.set(true)}
        onHoverLost={() => isHover.set(false)}
      >
        <revealer
          transitionType={Gtk.RevealerTransitionType.SLIDE_UP}
          revealChild={isHover(
            () =>
              (isHover.get() || isOpen.get()) && lastNotification.get() !== null
          )}
          className="revealer"
        >
          <box className="notification" vertical={Gtk.Orientation.VERTICAL}>
            {bind(lastNotification).as((n) => {
              if (n) {
                return (
                  <box
                    className="notificationEl"
                    vertical={Gtk.Orientation.VERTICAL}
                    halign={Gtk.Align.START}
                  >
                    <label
                      className="title"
                      halign={Gtk.Align.START}
                      wrap
                      widthRequest={300}
                    >
                      {n.summary}
                    </label>
                    <label
                      className="body"
                      halign={Gtk.Align.START}
                      wrap
                      widthRequest={300}
                    >
                      {n.body}
                    </label>
                  </box>
                );
              }
              return null;
            })}
          </box>
        </revealer>
      </eventbox>
    </window>
  );
};

export default Notification;

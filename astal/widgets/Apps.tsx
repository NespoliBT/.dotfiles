import { Astal, Gtk, Gdk, astalify } from "astal/gtk3";
import { timeout, Variable, bind } from "astal";
import Title from "./Title";

const AppsWindow = () => {
  const { TOP, LEFT, RIGHT, BOTTOM } = Astal.WindowAnchor;
  const layer = Variable(1);
  const open = Variable(false);

  APP_LIST.subscribe((apps) => {
    if (apps.length > 0) {
      layer.set(2);
    } else {
      setTimeout(() => {
        if (APP_LIST.get().length == 0) {
          layer.set(1);
        }
      }, 1000);
    }
  });

  return (
    <window
      className="Apps"
      exclusivity={Astal.Exclusivity.NONE}
      anchor={BOTTOM}
      marginBottom={250}
      layer={bind(layer)}
    >
      <eventbox
        onHover={() => {
          open.set(true);
        }}
        onHoverLost={() => {
          open.set(false);
          APP_LIST.set([]);
        }}
      >
        <revealer
          transitionType={Gtk.RevealerTransitionType.SLIDE_UP}
          revealChild={bind(APP_LIST).as((apps) => {
            return open.get() || apps.length > 0;
          })}
          className="revealer"
        >
          <box
            className="appsContainer"
            valign={Gtk.Align.CENTER}
            vertical={Gtk.Orientation.VERTICAL}
          >
            <Title color={7} size={40}>
              Scegli tu
            </Title>
            <scrollable
              className="scrollable"
              valign={Gtk.Align.START}
              halign={Gtk.Align.CENTER}
              widthRequest={500}
              heightRequest={400}
            >
              <box
                className="apps"
                vertical={Gtk.Orientation.VERTICAL}
                valign={Gtk.Align.START}
              >
                {bind(SELECTED_APP).as(() => {
                  return APP_LIST.get().map((app) => (
                    <button
                      className={`app ${
                        SELECTED_APP.get() == app.entry ? "selected" : ""
                      }`}
                      hexpand
                      onClick={() => {
                        APP_LIST.set([]);
                        open.set(false);
                        setTimeout(() => {
                          layer.set(1);
                        }, 1000);
                        app.launch();
                      }}
                    >
                      <box>
                        <icon className="icon" icon={app.iconName} />
                        <label className="name">{app.name}</label>
                      </box>
                    </button>
                  ));
                })}
              </box>
            </scrollable>
          </box>
        </revealer>
      </eventbox>
    </window>
  );
};

export default AppsWindow;

import Apps from "gi://AstalApps";
import { timeout, Variable, bind } from "astal";
import { Astal, Gtk, Gdk, astalify } from "astal/gtk3";

const Search = () => {
  const apps = new Apps.Apps({
    nameMultiplier: 2,
    entryMultiplier: 0,
    executableMultiplier: 2,
  });

  const handleType = (self: any) => {
    const text = self.text;

    if (self.text.length != 0) {
      const appList = apps.fuzzy_query(text).slice(0, 5);
      APP_LIST.set(appList);
      SELECTED_APP.set(appList[0]);
    }

    if (self.text.length == 0) {
      APP_LIST.set([]);
      SELECTED_APP.set("asdasdsad");
    }
  };
  const handleActivate = (self: any) => {
    const text = self.text;
    const app = SELECTED_APP.get();

    if (text.length > 0) {
      if (app) {
        app.launch();
        self.text = "";
        APP_LIST.set([]);
        SELECTED_APP.set("none");
        OPEN_APP_LAUNCHER.set(false);
      }
    }
  };

  return (
    <box className="search" hexpand>
      <entry
        onChanged={handleType}
        onActivate={handleActivate}
        hexpand
        halign={Gtk.Align.CENTER}
        widthRequest={500}
        setup={(self) => {
          OPEN_APP_LAUNCHER.subscribe((open) => {
            if (open) {
              self.grab_focus();
            } else {
              self.text = "";
              APP_LIST.set([]);
              SELECTED_APP.set("none");
            }
          });
        }}
      />
    </box>
  );
};

export default Search;

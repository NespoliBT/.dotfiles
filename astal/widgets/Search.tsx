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
      SELECTED_APP.set(appList[0].entry);
    }

    if (self.text.length == 0) {
      APP_LIST.set([]);
      SELECTED_APP.set("asdasdsad");
    }
  };
  const handleActivate = (self: any) => {
    const text = self.text;

    if (text.length > 0) {
      const app = apps[SELECTED_APP.get()];

      if (app) {
        exec(app.command);
        self.text = "";
        APP_LIST.set([]);
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
      />
    </box>
  );
};

export default Search;

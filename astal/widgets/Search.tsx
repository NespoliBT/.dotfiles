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

    if (text.length > 0) {
      APP_LIST.set(apps.fuzzy_query(text));
    } else {
      APP_LIST.set([]);
    }
  };
  const handleActivate = (self: any) => {
    const text = self.text;

    if (text.length > 0) {
      for (const app of apps.fuzzy_query(text)) {
        print(app.name);
        if (app.executable) {
          app.launch();
          APP_LIST.set([]);
        }
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

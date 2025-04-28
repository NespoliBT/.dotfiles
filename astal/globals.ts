import Gtk from "gi://Gtk";
import { Variable } from "astal";

declare global {
  const APP_LIST: any;
}

Object.assign(globalThis, {
  APP_LIST: Variable([]),
});

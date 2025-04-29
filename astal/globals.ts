import Gtk from "gi://Gtk";
import { Variable } from "astal";

declare global {
  const APP_LIST: any;
  const SELECTED_APP: string;
}

Object.assign(globalThis, {
  APP_LIST: Variable([]),
  SELECTED_APP: Variable("none"),
});

import Gtk from "gi://Gtk";
import { Variable } from "astal";

declare global {
  const APP_LIST: any;
  const SELECTED_APP: string;
  const OPEN_APP_LAUNCHER: boolean;
  const OPEN_SIDE_BAR: boolean;
}

Object.assign(globalThis, {
  APP_LIST: Variable([]),
  SELECTED_APP: Variable("none"),
  OPEN_APP_LAUNCHER: Variable(false),
  OPEN_SIDE_BAR: Variable(false),
});

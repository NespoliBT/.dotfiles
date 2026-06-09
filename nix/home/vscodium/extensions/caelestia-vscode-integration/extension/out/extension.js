"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.activate = void 0;
const fs_1 = require("fs");
const promises_1 = require("fs/promises");
const os_1 = require("os");
const path_1 = require("path");
const vscode_1 = require("vscode");
const theme_1 = __importDefault(require("./theme"));
const getSchemeDir = () => (0, path_1.join)(process.env.XDG_STATE_HOME ?? (0, path_1.join)((0, os_1.homedir)(), ".local", "state"), "caelestia");
const getSchemePath = () => (0, path_1.join)(getSchemeDir(), "scheme.json");
const update = async () => {
    const schemePath = getSchemePath();
    if (!(0, fs_1.existsSync)(schemePath)) {
        console.log("No current scheme.");
        return;
    }
    // Update theme colours with scheme
    const scheme = JSON.parse(await (0, promises_1.readFile)(schemePath, "utf-8"));
    const colours = Object.fromEntries(Object.entries(scheme.colours).map(([n, c]) => [n, `#${c}`]));
    await (0, promises_1.writeFile)((0, path_1.join)(__dirname, "..", "themes", "caelestia.json"), JSON.stringify((0, theme_1.default)(colours)));
    // Sync icon theme
    const workbench = vscode_1.workspace.getConfiguration("workbench");
    if (workbench.get("colorTheme") === "Caelestia" &&
        /catppuccin-(latte|frappe|macchiato|mocha)/.test(workbench.get("iconTheme") ?? "") &&
        vscode_1.extensions.getExtension("catppuccin.catppuccin-vsc-icons")) {
        workbench.update("iconTheme", `catppuccin-${scheme.mode === "light" ? "latte" : "mocha"}`, vscode_1.ConfigurationTarget.Global);
    }
    console.log("Updated scheme.");
};
const activate = (context) => {
    update();
    const watcher = vscode_1.workspace.createFileSystemWatcher(new vscode_1.RelativePattern(getSchemeDir(), "scheme.json"));
    context.subscriptions.push(watcher, watcher.onDidCreate(update), watcher.onDidChange(update));
    console.log(`Watching for changes to ${getSchemePath()}`);
};
exports.activate = activate;

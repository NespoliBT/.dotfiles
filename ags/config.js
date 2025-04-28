import App from "resource:///com/github/Aylur/ags/app.js";
import Notifications from 'resource:///com/github/Aylur/ags/service/notifications.js';
import { Bar } from "./widgets/bar.js"
import { Sidebar } from "./widgets/sidebar.js"
import { FullInfo } from "./widgets/fullInfo.js"
import { PopupInfo } from "./widgets/popupInfo.js"
import { ThemeChanger } from "./widgets/themeChanger.js";
import { AppLauncher } from "./widgets/apps.js";

const getThemes = () => {
    const themes = Utils.exec(`ls ${App.configDir}/themes`).split("\n");
    const themesMap = themes.map((theme) => {
        const path = `${App.configDir}/themes/${theme}`
        const colors =
            Utils.exec(`cat ${path}/variables.scss`)
                .split("\n").slice(0, 9).map(c => c.split(":")[1].replace(";", "").trim());

        return {
            name: theme,
            path,
            colors,
            scss: `${path}/variables.scss`,
            background: `${path}/background.jpg`,
            image: `${path}/img.jpg`,
            hyprColors: `${path}/hypr-colors.conf`,
        }
    })

    return themesMap
}

Utils.subprocess([
    'inotifywait',
    '--event', 'create,modify',
    '-m', App.configDir + '/scss',
], () => {
    console.log('=> scss reloaded');
    Utils.exec(`sassc ${App.configDir}/scss/main.scss ${App.configDir}/style.css`);
    App.resetCss();
    App.applyCss(`${App.configDir}/style.css`);
});


App.applyCss(`${App.configDir}/style.css`);
Utils.exec(`sassc ${App.configDir}/scss/main.scss ${App.configDir}/style.css`);

const themes = getThemes()

let windows = [
    Bar(),
    Sidebar(),
    FullInfo(),
    PopupInfo(),
    ThemeChanger(themes),
    AppLauncher(),
]

App.config({
    style: `${App.configDir}/style.css`,
    cacheNotificationActions: true,
    windows: windows,
})
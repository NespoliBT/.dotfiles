pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.UPower

Singleton {
    id: battery

    readonly property string tte: UPower.displayDevice.timeToEmpty
    readonly property string percentage: UPower.displayDevice.percentage
    readonly property string display: `${Math.floor(percentage * 100)}%`
    readonly property string currentRate: UPower.displayDevice.changeRate.toFixed(2)
}

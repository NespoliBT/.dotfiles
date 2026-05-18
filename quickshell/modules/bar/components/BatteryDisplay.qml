pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root

    required property var battery
    anchors.fill: parent
    anchors.right: parent.left
    color: "red"
    width: 100

    ColumnLayout {
        RowLayout {
            Text {
                text: `󰁹  ${root.battery.display}`
                color: "white"
                font.pixelSize: 20
                horizontalAlignment: Text.AlignLeft
            }
        }
        RowLayout {
            Layout.fillWidth: true

            Text {
                text: `${root.battery.isCharging ? "" : ""}`
                color: "#95a5a6"
                font.pixelSize: 20
                horizontalAlignment: Text.AlignRight
            }
            Text {
                font.pixelSize: 16
                text: root.battery.currentRate
            }
        }
    }
}

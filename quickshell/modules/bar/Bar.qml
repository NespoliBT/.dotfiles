pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import QtQuick.Layouts
import QtQuick
import "components"
import qs.services

Item {
  id: root

  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property var modelData
      screen: modelData
      anchors {
        left: true
        right: true
        bottom: true
      }

      Rectangle {
        id: bottomBar
        anchors.fill: parent
        color: "#2c3e50"
        
        RowLayout {
          anchors.fill: parent
          anchors.margins: 10
          spacing: 20

          Clock {
            width: 120
            Layout.alignment: Qt.AlignVCenter
          }

          Item { Layout.fillWidth: true }

          BatteryDisplay {
            battery: Battery
            Layout.alignment: Qt.AlignVCenter
          }
        }
      }
    }
  }
}
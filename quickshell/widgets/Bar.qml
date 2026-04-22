import Quickshell
import Quickshell.Io
import QtQuick
import "../components"

Scope {
  id: root

  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property var modelData
      screen: modelData

      anchors {
        bottom: true
        left: true
        right: true
      }

      implicitHeight: 30

      Time {}
    }
  }
}
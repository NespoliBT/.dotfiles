import Quickshell
import Quickshell.Io
import QtQuick

PanelWindow {
  // Inline theme colors for simplicity
  QtObject {
    id: colors
    readonly property color background: "#1e1e2e"
    readonly property color foreground: "#cdd6f4"
    readonly property color surface: "#313244"
    readonly property color accent: "#89b4fa"
  }

  anchors {
    top: true
    left: true
    right: true
  }

  implicitHeight: 50
  color: colors.background

  Row {
    anchors {
      left: parent.left
      top: parent.top
      bottom: parent.bottom
      leftMargin: 10
      topMargin: 5
      bottomMargin: 5
    }

    spacing: 10

    Clock {
      id: clock
      anchors.verticalCenter: parent.verticalCenter
    }
  }

  // Clock widget component
  component Clock: Rectangle {
    width: clockText.width + 20
    height: clockText.height + 10

    color: colors.background
    border.color: colors.accent
    border.width: 1
    radius: 4

    property string currentTime: ""

    Process {
      id: dateProc
      command: ["date", "+%H:%M:%S"]
      running: true

      stdout: StdioCollector {
        onStreamFinished: {
          currentTime = this.text.trim()
        }
      }
    }

    Timer {
      interval: 1000
      running: true
      repeat: true
      onTriggered: dateProc.running = true
    }

    Text {
      id: clockText
      anchors.centerIn: parent

      text: currentTime || "00:00:00"
      font.family: "Monospace"
      font.pixelSize: 14
      font.weight: Font.Bold
      color: colors.accent
    }
  }
}

import Quickshell
import Quickshell.Io
import QtQuick


Text {
  property string time
  anchors.right: parent.right
  anchors.rightMargin: 10
  anchors.verticalCenter: parent.verticalCenter
  text: time

  Process {
    id: dateProc
    command: ["date", ""]
    running: true

    stdout: StdioCollector {
      onStreamFinished: {
        time = this.text
      }
    }
  }

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: {
      dateProc.running = true
    }
  }
}

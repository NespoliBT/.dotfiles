import Quickshell.Io
import QtQuick

QtObject {
  id: dateService

  signal timeUpdated(string time)

  property string currentTime: ""

  readonly property Process process: Process {
    id: dateProc
    command: ["date", "+%H:%M:%S"]
    running: false

    stdout: StdioCollector {
      onStreamFinished: {
        dateService.currentTime = this.text.trim()
        dateService.timeUpdated(dateService.currentTime)
      }
    }
  }

  readonly property Timer updateTimer: Timer {
    id: updateTimer
    interval: 1000
    running: true
    repeat: true
    onTriggered: dateProc.running = true
  }

  function start() {
    updateTimer.running = true
    dateProc.running = true
  }

  function stop() {
    updateTimer.running = false
  }
}

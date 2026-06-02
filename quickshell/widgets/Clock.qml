import QtQuick
import "../theme/colors.qml" as Colors
import "../theme/fonts.qml" as Fonts
import "../services/DateService.qml" as DateServiceModule

Rectangle {
  id: clockWidget

  width: clockText.width + 20
  height: clockText.height + 10

  color: Colors.Colors.background
  border.color: Colors.Colors.accent
  border.width: 1
  radius: 4

  DateServiceModule.DateService {
    id: dateService
  }

  Text {
    id: clockText
    anchors.centerIn: parent

    text: dateService.currentTime || "00:00:00"
    font: Fonts.Fonts.monoBold
    color: Colors.Colors.accent

    Component.onCompleted: dateService.start()
  }
}

import QtQuick

QtObject {
  readonly property font mono: Qt.font({
    family: "Monospace"
    pixelSize: 12
  })

  readonly property font monoLarge: Qt.font({
    family: "Monospace"
    pixelSize: 14
  })

  readonly property font monoBold: Qt.font({
    family: "Monospace"
    pixelSize: 12
    weight: Font.Bold
  })

  readonly property font sansSerif: Qt.font({
    family: "Sans Serif"
    pixelSize: 12
  })
}

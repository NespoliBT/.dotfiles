pragma ComponentBehavior: Bound

import QtQuick
import qs.services

Rectangle {
    id: root

    Text {
        color: "#00ff00"
        anchors.fill: parent
        text: Time.format("hh\nmm")
    }
}

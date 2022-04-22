import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Window {
    width: 640
    height: 480
    visible: true
    color: "#ffffff"
    property string property0: "none.none"
    title: "holaa"

    Rectangle {
        id: rectangle
        x: 127
        y: 132
        width: 200
        height: 200
        color: "#0001f0"

        MouseArea {
            id: mouseArea
            anchors.fill: parent

            Connections {
                target: mouseArea
                onClicked: text1.text = "pulsado"
            }
        }
    }

    Rectangle {
        id: rectangle1
        x: 377
        y: 132
        width: 200
        height: 200
        color: "#42f024"

        Text {
            id: text1
            width: 77
            height: 56
            color: "#ffffff"
            text: qsTr("HOLA")
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 22
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            fontSizeMode: Text.FixedSize
            font.capitalization: Font.Capitalize
            minimumPointSize: 20
            minimumPixelSize: 20
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

}


/*##^##
Designer {
    D{i:0;formeditorZoom:0.75}D{i:3}D{i:2}D{i:1}D{i:5}D{i:4}
}
##^##*/

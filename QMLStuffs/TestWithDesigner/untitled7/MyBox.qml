import QtQuick 2.0

Item {
    id: element
    property color offColor: "red"
    property color onColor: "green"
    property color defaultColor: "grey"

    Rectangle {
        id: rectangle
        color: defaultColor
        anchors.fill: parent
        radius: width
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1}
}
##^##*/

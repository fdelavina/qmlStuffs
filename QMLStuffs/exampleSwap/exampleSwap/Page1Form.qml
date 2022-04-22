import QtQuick 2.15
import QtQuick.Controls 2.15

Page {
    id: page
    width: 600
    height: 400
    property string vehicle_name: ""
    property string source_path: ""
    property string joystick_object_name : ""
    property string label_name: ""
    header: Label
    {
        text: qsTr(label_name)
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10
    }

    Image
    {
        id: image
        x: 0
        width: 200
        height: 210
        anchors.verticalCenter: parent.verticalCenter
        source: source_path
        fillMode: Image.PreserveAspectFit
    }

    ControlContainer
    {
        x: 200
        anchors.verticalCenter: parent.verticalCenter
        objectName: vehicle_name + "_controlContainer"


    }

}

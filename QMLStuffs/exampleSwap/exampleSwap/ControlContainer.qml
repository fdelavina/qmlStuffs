import QtQuick 2.0
import QtQuick.Controls 2.15

Item
{
    id: itemContainer
    objectName: ""
    width: 300
    height: 300
    property string reference_lat: ""
    property string reference_lon: ""
    signal sendVeloX(string data)
    signal joystick_moved(double x, double y, double angle,  string vehicle)

    signal sendReferenceLatLon( double lat, double lon, string vehicle)


    Component.onCompleted: {the_joystick.joystick_moved.connect(joystick_moved)}
    onSendReferenceLatLon: {
        console.log("Sending to post: " + lat + lon )
    }


    Row
    {
        id: row
        x: 0
        y: 0
        width: parent.width
        height: parent.height
        Column
        {
            id: column
            x: 0
            width: 200
            height: parent.height
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 1
            Label
            {
                width: 100; height: 20; id: label
                text: qsTr("velocity Joystick")
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: 60
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 0
            }
            Row
            {
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -100
                anchors.horizontalCenterOffset: 0
                anchors.horizontalCenter: parent.horizontalCenter
                Label
                {
                    id: label1
                    text: qsTr("reference latitud,longitud: ")


                }
                TextInput
                {

                    width: 105
                    cursorVisible: true
                    validator:RegExpValidator { regExp : /[+-]?[0-9]+\.[0-9]+/ }
                    onTextChanged:
                    {
                        reference_lat = text
                    }

                }
                TextInput
                {

                    width: 105
                    cursorVisible: true
                    validator:RegExpValidator { regExp : /[+-]?[0-9]+\.[0-9]+/ }
                    onTextChanged:
                    {
                        reference_lon = text
                    }

                }
                Button
                {
                    onClicked:
                    {
                        sendReferenceLatLon(reference_lat, reference_lon, vehicle_name)
                    }
                }

            }



            VirtualJoystick
            {
                width: 100; height: 50;
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                objectName: joystick_object_name
                vehicle: vehicle_name
                id: the_joystick

            }


        }
        PanelControl
        {
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 0 - 100
            name_vehicle: vehicle_name

        }
    }



}



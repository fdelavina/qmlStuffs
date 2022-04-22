import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
Item {
    id: root
    width: 200
    height: 120
    property string name_vehicle: ""
    signal sendReferenceLatLon(double lat, double lon)


    GridLayout
    {
        width: 200
        height: parent.height
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        flow:GridLayout.TopToBottom
        columns: 2
        rows: 5
            Label {
                text: "latitud"
            }
            Label {
                text: "longitud"
            }
            Label {
                text: "velocidad x"
            }
            Label {
                text: "velocidad y"
            }
            Label {
                text: "heading"


            }


            TextInput
            {

                width: 105
                cursorVisible: true
                validator:RegExpValidator { regExp : /[+-]?[0-9]+\.[0-9]+/ }

                text: if(vehicle_name=="kaluga"){ mainWindow.latlon_kaluga.lat }
                else if(vehicle_name=="sead"){ mainWindow.latlon_sead.lat }
                else if(vehicle_name=="airfox"){ mainWindow.latlon_airfox.lat }

            }




            TextInput {
                width: 100
                cursorVisible: true
                validator:RegExpValidator { regExp : /[+-]?[0-9]+\.[0-9]+/ }
                text: if(vehicle_name=="kaluga"){ mainWindow.latlon_kaluga.lon }
                else if(vehicle_name=="sead"){ mainWindow.latlon_sead.lon }
                else if(vehicle_name=="airfox"){ mainWindow.latlon_airfox.lon }
            }
            TextInput {
                width: 100
                cursorVisible: true
                validator:RegExpValidator { regExp : /[+-]?[0-9]+\.[0-9]+/ }
                signal joystick_moved(double x, double y, double angle, string vehicle)
                Component.onCompleted: {the_joystick.joystick_moved.connect(joystick_moved)}

                onJoystick_moved:{
                    //console.log("x y te: " + x + " " + y)
                    text = x
                }

            }
            TextInput {
                width: 100
                cursorVisible: true
                validator:RegExpValidator { regExp : /[+-]?[0-9]+\.[0-9]+/}
                signal joystick_moved(double x, double y, double angle,string vehicle)
                Component.onCompleted: {the_joystick.joystick_moved.connect(joystick_moved)}
                onJoystick_moved:
                {
                    //console.log("x y te: " + x + " " + y)
                    text = y
                }
            }
            TextInput {
                width: 100
                cursorVisible: true
                validator:RegExpValidator { regExp : /[+-]?[0-9]+\.[0-9]+/ }
                signal joystick_moved(double x, double y, double angle,string vehicle)
                Component.onCompleted: {the_joystick.joystick_moved.connect(joystick_moved)}
                onJoystick_moved:
                {
                    //console.log("x y te: " + x + " " + y)
                    text = angle
                }
            }



    }






}

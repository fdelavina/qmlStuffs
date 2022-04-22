import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.15
Rectangle
{
    width: 640
    height: 480
    visible: true
    //title: qsTr("Tabs")


    ColumnLayout
    {

        Row
        {
            width: 50; height: 50
            Layout.alignment: Qt.AlignCenter
            Button
            {
                text: "Kaluga"
                onClicked: layout.currentIndex=0
            }
            Button
            {
                text: "Sead"
                onClicked: layout.currentIndex=1
            }
            Button
            {
                text: "Airfox"
                onClicked: layout.currentIndex=2
            }
        }
        Rectangle
        {

            width: 600; height: 350
            Layout.alignment: Qt.AlignCenter
            StackLayout
            {
                id: layout
                x: 0
                y: 0
                width: 640
                height: 438
               // anchors.fill: parent
                currentIndex: 1

                Page1Form
                {
                  source_path: "qrc:/images/photos/kaluga.png"
                  vehicle_name: "kaluga"
                  joystick_object_name: "the_joystick_kaluga"
                  label_name: "kaluga simulation"
                }

                Page1Form
                {
                    source_path: "qrc:/images/photos/kaluga.png"
                    vehicle_name: "sead"
                    joystick_object_name: "the_joystick_sead"
                    label_name: "sead simulation"
                }

                Page1Form
                {
                    source_path: "qrc:/images/photos/airfox.png"
                    vehicle_name: "airfox"
                    joystick_object_name: "the_joystick_airfox"
                    label_name: "airfox simulation"
                }

            }
        }


    }


}

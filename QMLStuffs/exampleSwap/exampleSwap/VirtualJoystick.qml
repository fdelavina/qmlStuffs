import QtQuick 2.15

Rectangle {

    id: the_joystick
    objectName: ""
    width: joystick.width
    height: joystick.height
    color: "transparent"
    property string vehicle : "default"

    signal joystick_moved(double x, double y, double angle,string vehicle);

    signal sendVeloX(string x)
    Component.onCompleted: {itemContainer.sendVeloX.connect(sendVeloX)}

    onSendVeloX:
    {
         //console.log("Sending to post virtualJo: " + x)
    }


    Image {
        id: joystick


        property real angle : 0
        property real distance : 0

        source: "images/photos/background.png"
        anchors.centerIn: parent

        ParallelAnimation {
            id: returnAnimation
            NumberAnimation { target: thumb.anchors; property: "horizontalCenterOffset";
                to: 0; duration: 200; easing.type: Easing.OutSine }
            NumberAnimation { target: thumb.anchors; property: "verticalCenterOffset";
                to: 0; duration: 200; easing.type: Easing.OutSine }
        }

        MouseArea {
            id: mouse
            property real mouseX2 :  mouseX
            property real mouseY2 :  mouseY
            property real fingerAngle : Math.atan2(mouseX2, mouseY2)
            property int mcx : mouseX2 - width * 0.5
            property int mcy : mouseY2 - height * 0.5
            property bool fingerInBounds : fingerDistance2 < distanceBound2
            property real fingerDistance2 : mcx * mcx + mcy * mcy
            property real distanceBound : width * 0.5 - thumb.width * 0.5
            property real distanceBound2 : distanceBound * distanceBound

            property double signal_x : (mouseX2 - joystick.width/2) / distanceBound
            property double signal_y : -(mouseY2 - joystick.height/2) / distanceBound



            anchors.fill: parent

            onPressed: {
                returnAnimation.stop();
            }

            onReleased: {
                //returnAnimation.restart()
                //joystick_moved(0, 0,angle, vehicle);
            }


            onPositionChanged: {
                if (fingerInBounds) {
                    thumb.anchors.horizontalCenterOffset = mcx
                    thumb.anchors.verticalCenterOffset = mcy
                } else {
                    var angle = Math.atan2(mcy, mcx)
                    thumb.anchors.horizontalCenterOffset = Math.cos(angle) * distanceBound
                    thumb.anchors.verticalCenterOffset = Math.sin(angle) * distanceBound
                }

                // Fire the signal to indicate the joystick has moved
                angle = Math.atan2(signal_y, signal_x)* 180 /3.14159

                if(fingerInBounds) {
                    joystick_moved(
                         Math.cos(angle*3.14159 /180) * Math.sqrt(fingerDistance2) / distanceBound,
                         Math.sin(angle*3.14159 /180) * Math.sqrt(fingerDistance2) / distanceBound,
                                angle,
                                vehicle
                    );
                } else {
                    joystick_moved(
                         Math.cos(angle*3.14159 /180) * 1,
                         Math.sin(angle*3.14159 /180) * 1,
                                angle,
                                vehicle
                    );
                }
            }
        }

        Image {
            id: thumb
            source: "images/photos/finger.png"
            width: 50
            height: 50
            anchors.centerIn: parent
        }
    }
}

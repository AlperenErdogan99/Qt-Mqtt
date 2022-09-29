import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Mqtt Application")

    Component.onCompleted: {
        mqttclient.start();
    }

    Text {
        id: helloWorldText
        text: qsTr("Hello World\n")
        anchors.centerIn: parent
        visible: true
        font.pointSize: 15
    }

    Button{
        id: connectToHost
        text: "Connect to Host"
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 150
        onClicked: {
            mqttclient.connectServer();
        }

        Button{
            id: ping
            text: "Ping"
            anchors.centerIn: parent
            anchors.verticalCenterOffset: 50
            onClicked: {
                mqttclient.ping();
            }
        }
    }
}

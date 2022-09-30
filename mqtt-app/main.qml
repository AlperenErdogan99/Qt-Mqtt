import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Window {
    minimumHeight: 480
    maximumHeight: 480
    minimumWidth: 700
    maximumWidth: 700
    visible: true
    title: qsTr("Mqtt Application")
    color: "#e4e8c1"

    Component.onCompleted: {
        mqttclient.initialize();
    }

    Text {
        id: helloWorldText
        text: qsTr("Mqtt Client Application\n")
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -200
        visible: true
        font.pointSize: 15
    }

    Rectangle{
        id: brokerAddressRect
        width: 100
        height: 40
        radius: 40
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: -220
        anchors.verticalCenterOffset: -130
        color: "#ef8771"

        Label{
            id: brokerAddressLabel
            text: "Broker address"
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -40
        }

        TextEdit{
            id: brokerAddressText
            text: "localhost"
            anchors.centerIn: parent
        }

    }

    Rectangle{
        id: portConfigRect
        width: 100
        height: 40
        radius: 40
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: -220
        anchors.verticalCenterOffset: -20
        color: "#ef8771"

        Label{
            id: portLabel
            text: "Port Number"
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -40
        }

        TextEdit{
            id: portText
            text: "1883"
            anchors.centerIn: parent
        }

    }

    // Create disconnect button here
    Button{
        id: disconnectFromHostBtn
        text: "Disconnect from host"
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: -220
        anchors.verticalCenterOffset: 100

        background: Rectangle {
            color: "#a8d5a6"
        }

        onClicked: {
            mqttclient.disconnectServer();
            connectToHostBackground.color = "#a8d5a6"
        }

    }

    Button{
        id: connectToHost
        text: "Connect to Host"
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: -220
        anchors.verticalCenterOffset: 50

        background: Rectangle {
            id: connectToHostBackground
            color: "#a8d5a6"
        }

        onClicked: {
            connectToHostBackground.color = "#46cfda"
            mqttclient.setPort(parseInt(portText.text));
            mqttclient.setHostAddress(brokerAddressText.text);
            mqttclient.connectServer();
        }
    }

    Rectangle{
        id: seperatorLine1
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: -130
        width: 8
        height: 370
        color: "#8ab9e8"
    }

    Rectangle{
        id: sendTopicRec
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: -50
        anchors.verticalCenterOffset: -130
        width: 100
        height: 40
        radius: 40
        color: "#ef8771"

        Label{
            id: sendTopicLab
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -40
            text: "Topic Name"
        }

        TextEdit{
            id: sendTopicText
            anchors.centerIn: parent
            text: "test"
        }
    }

    Rectangle{
        id: sendMessageRec
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: -50
        anchors.verticalCenterOffset: -20
        width: 100
        height: 40
        radius: 50
        color: "#ef8771"

        Label{
            id: sendMessageLab
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -40
            text: "Message"
        }

        TextEdit{
            id: sendMessageText
            anchors.centerIn: parent
            text: "testing"
        }
    }


    Button{
        id: sendMessageBtn
        text: "Send Message"
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: -50
        anchors.verticalCenterOffset: 50

        background: Rectangle {
            color: "#a8d5a6"
        }

        onClicked: {
            mqttclient.sendMessage(sendTopicText.text, sendMessageText.text);
        }
    }

    Rectangle{
        id: seperatorLine2
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: 30
        width: 8
        height: 370
        color: "#8ab9e8"
    }


}


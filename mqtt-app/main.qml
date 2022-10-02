import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import MqttClient 1.0

Window {
    minimumHeight: 480
    maximumHeight: 480
    minimumWidth: 700
    maximumWidth: 700
    visible: true
    title: qsTr("Mqtt Application")
    color: "#e4e8c1"

    MqttClient {
        id: mqttClient
        Component.onCompleted: mqttClient.initialize();

        onMessageReceived: {
            receivedMessageAreaText.text += message + "\n";
            receivedTopicAreaText.text += topic + "\n";
        }

        onDisconnectedServer: {
            conStateText.text = "Not Connected";
        }

        onConnectedServer: {
            conStateText.text = "Connected";
        }
    }

    Text {
        id: initLabelText
        text: qsTr("Simple Mqtt Application\n")
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -200
        visible: true
        font.pointSize: 15
        font.bold: true
    }

    Text {
        id: designedByText
        text: qsTr("Developed by Last Pr Warrior")
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 220
        anchors.horizontalCenterOffset: 270
        font.pointSize: 8
        font.italic: true

    }

    Rectangle {
        id: brokerAddressRect
        width: 100
        height: 40
        radius: 40
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: -220
        anchors.verticalCenterOffset: -130
        color: "#ef8771"

        Label {
            id: brokerAddressLabel
            text: "Broker address"
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -40
            font.bold: true
        }

        TextEdit{
            id: brokerAddressText
            text: "localhost"
            anchors.centerIn: parent
        }

    }

    Rectangle {
        id: portConfigRect
        width: 100
        height: 40
        radius: 40
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: -220
        anchors.verticalCenterOffset: -20
        color: "#ef8771"

        Label {
            id: portLabel
            text: "Port Number"
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -40
            font.bold: true
        }

        TextEdit {
            id: portText
            text: "1883"
            anchors.centerIn: parent
        }
    }

    Button {
        id: connectToHost
        text: "Connect to Host"
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: -220
        anchors.verticalCenterOffset: 50

        background: Rectangle {
            color: parent.down ? "#94e2d8" : (parent.hovered ? "#94e2a4" : "#b8e2ce")
        }

        onClicked: {
            mqttClient.setPort(parseInt(portText.text));
            mqttClient.setHostAddress(brokerAddressText.text);
            mqttClient.connectServer();
        }
    }

    Button {
        id: disconnectFromHostBtn
        text: "Disconnect from host"
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: -220
        anchors.verticalCenterOffset: 100

        background: Rectangle {
            color: parent.down ? "#94e2d8" : (parent.hovered ? "#94e2a4" : "#b8e2ce")
        }

        onClicked: {
            mqttClient.disconnectServer();
        }
    }

    Text {
        id: conStateText
        text: "Not Connected"
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: -220
        anchors.verticalCenterOffset: 150
    }


    Rectangle {
        id: seperatorLine1
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: -130
        width: 8
        height: 370
        color: "#8ab9e8"
    }

    Rectangle {
        id: sendTopicRec
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: -50
        anchors.verticalCenterOffset: -130
        width: 100
        height: 40
        radius: 40
        color: "#ef8771"

        Label {
            id: sendTopicLab
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -40
            text: "Topic Name"
            font.bold: true
        }

        TextEdit {
            id: sendTopicText
            anchors.centerIn: parent
            text: "test"
        }
    }

    Rectangle {
        id: publishMessageRec
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: -50
        anchors.verticalCenterOffset: -20
        width: 100
        height: 40
        radius: 50
        color: "#ef8771"

        Label {
            id: publishMessageLab
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -40
            text: "Message"
            font.bold: true
        }

        TextEdit{
            id: publishMessageText
            anchors.centerIn: parent
            text: "testing"
        }
    }


    Button {
        id: publishMessageBtn
        text: "Send Message"
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: -50
        anchors.verticalCenterOffset: 50

        background: Rectangle {
                color: parent.down ? "#94e2d8" :
                        (parent.hovered ? "#94e2a4" : "#b8e2ce")
        }

        onClicked: {
            mqttClient.publishMessage(sendTopicText.text, publishMessageText.text);
        }
    }

    Rectangle {
        id: seperatorLine2
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: 30
        width: 8
        height: 370
        color: "#8ab9e8"
    }

    Rectangle {
        id: subTopicRec
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: 105
        anchors.verticalCenterOffset: -130
        width: 100
        height: 40
        radius: 40
        color: "#ef8771"

        Label {
            id: subTopicLab
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -40
            text: "Sub Topic Name"
            font.bold: true
        }

        TextEdit {
            id: subTopicText
            anchors.centerIn: parent
            text: "test"
        }
    }

    Button {
        id: subTopicBtn
        text: "Subscribe Topic"
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: 230
        anchors.verticalCenterOffset: -130   

        background: Rectangle {
            color: parent.down ? "#94e2d8" : (parent.hovered ? "#94e2a4" : "#b8e2ce")
        }

        onClicked: {
            mqttClient.subscribe(subTopicText.text);
        }
    }

    Rectangle {
        id: receivedTopicRec
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 60
        anchors.horizontalCenterOffset: 105
        radius: 10
        color: "white"
        width: 75
        height: 250

        Label {
            id: receivedTopicAreaLabel
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -140
            font.bold: true
            text: "Topic"
        }

        Text {
            id: receivedTopicAreaText
            width: 100
            height: 300
            text: ""
        }

    }

    Rectangle {
        id: receivedMessageRect
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 60
        anchors.horizontalCenterOffset: 245
        radius: 10
        color: "white"
        width: 150
        height: 250

        Label {
            id: receivedMessageAreaLabel
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -140
            font.bold: true
            text: "Message"
        }

        Text {
            id: receivedMessageAreaText
            width: 100
            height: 300
            text: ""
        }
    }

    Rectangle {
        id: clearMessageAreaRec
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 60
        anchors.horizontalCenterOffset: 245

        Button {
            id: clearMessageAreaBtn
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -190
            anchors.horizontalCenterOffset: 70
            width: 50
            height: 30
            text: "clear"

            background: Rectangle  {
                color: parent.down ? "#94e2d8" : (parent.hovered ? "#94e2a4" : "#b8e2ce")
            }
        }
    }
}


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
            font.bold: true
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
            font.bold: true
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
            font.bold: true
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
            font.bold: true
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

    Rectangle{
        id: subTopicRec
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: 105
        anchors.verticalCenterOffset: -130
        width: 100
        height: 40
        radius: 40
        color: "#ef8771"

        Label{
            id: subTopicLab
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -40
            text: "Sub Topic Name"
            font.bold: true
        }

        TextEdit{
            id: subTopicText
            anchors.centerIn: parent
            text: "test"
        }
    }

    Button{
        id: subTopicBtn
        text: "Subscribe Topic"
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: 230
        anchors.verticalCenterOffset: -130

        background: Rectangle {
            color: "#a8d5a6"
        }

        onClicked: {
            mqttclient.subscribe(subTopicText.text);
        }
    }

    Rectangle{
        id: receivedTopicRec
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 60
        anchors.horizontalCenterOffset: 105
        radius: 10
        color: "white"
        width: 75
        height: 250

        Label{
            id: receivedTopicAreaLabel
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -140
            font.bold: true
            text: "Topic"
        }

        TextArea{
            id: receivedTopicArea
            width: 100
            height: 300
            text: ""
        }

    }

    Rectangle{
        id: receivedMessageRect
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 60
        anchors.horizontalCenterOffset: 245
        radius: 10
        color: "white"
        width: 150
        height: 250

        Label{
            id: receivedMessageAreaLabel
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -140
            font.bold: true
            text: "Message"
        }

        TextArea{
            id: receivedMessageArea
            width: 100
            height: 300
            text: ""
        }

    }

}


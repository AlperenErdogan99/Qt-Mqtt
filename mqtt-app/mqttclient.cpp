#include "mqttclient.h"

MqttClient::MqttClient(QObject *parent)
    : QObject{parent}
{

}

void MqttClient::connectServer(){
    qDebug() << "Connecting to the host";
    m_client->connectToHost();
}

void MqttClient::disconnectServer(){
    qDebug() << "Disconnecting from host";
    m_client->disconnectFromHost();
}

void MqttClient::initialize(){
    qDebug() << "Initializing Mqtt Client";
    if (m_client.isNull()){
        m_client.reset(new QMqttClient, &QObject::deleteLater);
        configureClient();
    } else{
        connect(m_client.data(), &QObject::destroyed, this, [&](){
            configureClient();
        });
        m_client.reset(new QMqttClient, &QObject::deleteLater);
    }

}

void MqttClient::configureClient(){
    qDebug() << "Configuring Client";
    m_client->setHostname("localhost");
    m_client->setPort(1883);

    connect(m_client.data(), &QMqttClient::messageReceived, this, [&](const QByteArray &message, const QMqttTopicName &topic) {
        qDebug() << "Message: " << message;
        qDebug() << "Topic: " << topic.name();
        emit messageReceived(topic.name(), message);
    });

    connect(m_client.data(), &QMqttClient::disconnected, this, &MqttClient::disconnectedServer);
    connect(m_client.data(), &QMqttClient::connected, this, &MqttClient::connectedServer);
}

void MqttClient::ping(){
    QMqttTopicName pingTopic;
    pingTopic.setName("pingTopic");
    m_client->publish(pingTopic, "ping");
}

void MqttClient::subscribe(QString topic){
    qDebug() << "Subscribing " << topic;
    QMqttTopicFilter subTopic = topic;
    m_client->subscribe(subTopic);
}


void MqttClient::setPort(int portNumber){
    qDebug() << "Setting port to " << portNumber;
    m_client->setPort(portNumber);
}

void MqttClient::setHostAddress(QString hostAddress){
    qDebug() << "Setting host name to " << hostAddress;
    m_client->setHostname(hostAddress);
}

int MqttClient::port(){
    return m_client->port();
}

QString MqttClient::hostAddress(){
    return m_client->hostname();
}

void MqttClient::publishMessage(QString topic, QString message){
    QMqttTopicName tTopic;
    tTopic.setName(topic);
    m_client->publish(tTopic, message.toUtf8());
}

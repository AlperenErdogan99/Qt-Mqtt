#include "mqttclient.h"

MqttClient::MqttClient(QObject *parent)
    : QObject{parent}
{

}

void MqttClient::connectServer(){
    qDebug() << "Connecting to the host";
    m_client->connectToHost();
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
}

void MqttClient::start(){
    initialize();
}

void MqttClient::ping(){
    QMqttTopicName pingTopic;
    pingTopic.setName("pingTopic");
    m_client->publish(pingTopic, "ping");
}

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
    connect(m_client.data(), SIGNAL(messageReceived(QByteArray,QMqttTopicName)), this, SLOT(onMessageReceived(QByteArray,QMqttTopicName)));

}

void MqttClient::ping(){
    QMqttTopicName pingTopic;
    pingTopic.setName("pingTopic");
    m_client->publish(pingTopic, "ping");
}

void MqttClient::subscribe(QString topic){
    QMqttTopicFilter subTopic = topic;
    m_client->subscribe(subTopic);

//    connect(m_client.data(), &QMqttClient::messageReceived, this, [&](const QByteArray &message, const QMqttTopicName &topic) {
//        const QString content = QDateTime::currentDateTime().toString()
//                    + QLatin1String(" Received Topic: ")
//                    + topic.name()
//                    + QLatin1String(" Message: ")
//                    + message
//                    + QLatin1Char('\n');
//        qDebug() << "Message: " << content;
//    });

//    connect(m_client.data(), SIGNAL(messageReceived(QByteArray,QMqttTopicName)), this, SLOT(onMessageReceived(QByteArray,QMqttTopicName)));
}


void MqttClient::setPort(int portNumber){
    m_client->setPort(portNumber);
}

void MqttClient::setHostAddress(QString hostAddress){
    m_client->setHostname(hostAddress);
}

int MqttClient::port(){
    return m_client->port();
}

QString MqttClient::hostAddress(){
    return m_client->hostname();
}

void MqttClient::onMessageReceived(const QByteArray &message, const QMqttTopicName &topic){
    qDebug() << "Message: " << message;
    qDebug() << "topic: " << topic.name();
}

void MqttClient::sendMessage(QString topic, QString message){
    QMqttTopicName tTopic;
    tTopic.setName(topic);
    m_client->publish(tTopic, message.toUtf8());
}

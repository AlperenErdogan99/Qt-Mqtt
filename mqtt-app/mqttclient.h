#ifndef MQTTCLIENT_H
#define MQTTCLIENT_H

#include <QObject>
#include <QMqttClient>
#include <QSharedPointer>
#include <QDebug>

class MqttClient : public QObject
{
    Q_OBJECT
public:
    explicit MqttClient(QObject *parent = nullptr);
//    QMqttSubscription m_sub;


signals:


public slots:

    void connectServer();
    void disconnectServer();
    void initialize();
    void configureClient();
    void ping();
    void subscribe(QString topic);

    // Getter methods
    void setPort(int portNumber);
    void setHostAddress(QString hostAddress);
    void sendMessage(QString topic, QString message);

    // Setter methods
    int port();
    QString hostAddress();

    // Mqtt connector slots
    void onMessageReceived(const QByteArray& message, const QMqttTopicName &topic);

private:
    int m_port;
    QString m_hostAddress;
    QMqttTopicName m_topic;
    QString msg;
    QSharedPointer<QMqttClient> m_client;

};

#endif // MQTTCLIENT_H

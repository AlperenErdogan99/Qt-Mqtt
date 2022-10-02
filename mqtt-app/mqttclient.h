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

public slots:

    void connectServer();
    void disconnectServer();
    void initialize();
    void configureClient();
    void ping();
    void subscribe(QString topic);

    void setPort(int portNumber);
    void setHostAddress(QString hostAddress);
    void publishMessage(QString topic, QString message);

    int port();
    QString hostAddress();

signals:
    void messageReceived(QString topic, QString message);
    void disconnectedServer();
    void connectedServer();

private:
    int m_port;
    QString m_hostAddress;
    QMqttTopicName m_topic;
    QString msg;
    QSharedPointer<QMqttClient> m_client;

};

#endif // MQTTCLIENT_H

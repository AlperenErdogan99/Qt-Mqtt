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

private:
    QSharedPointer<QMqttClient> m_client;
signals:


public slots:

    void connectServer();
    void disconnectServer();
    void initialize();
    void configureClient();
    void ping();

    // Getter methods
    void setPort(int portNumber);
    void setHostAddress(QString hostAddress);
    void sendMessage(QString topic, QString message);

    // Setter methods
    int port();
    QString hostAddress();

private:
    int m_port;
    QString m_hostAddress;
    QMqttTopicName m_topic;
    QString msg;

};

#endif // MQTTCLIENT_H

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
    void initialize();
    void configureClient();
    void start();
    void ping();
};

#endif // MQTTCLIENT_H

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

    /**
     * @brief connect to Mqtt broker
     */
    void connectServer();

    /**
     * @brief disconnect from Mqtt broker
     */
    void disconnectServer();

    /**
     * @brief initialize Mqtt object with safe method
     */
    void initialize();

    /**
     * @brief Add port and host address to object. Connect connected, disconnected
     * and received signals to slots for Qml export
     */
    void configureClient();

    /**
     * @brief publish ping message to mqtt broker
     */
    void ping();

    /**
     * @brief subscribe the topic
     * @param topic
     */
    void subscribe(QString topic);

    /**
     * @brief set port number to target member variable
     * @param portNumber
     */
    void setPort(int portNumber);

    /**
     * @brief set host address to target member variable
     * @param hostAddress
     */
    void setHostAddress(QString hostAddress);

    /**
     * @brief publish custom message to target topic into mqtt broker
     * @param topic
     * @param message
     */
    void publishMessage(QString topic, QString message);

    /**
     * @brief Get port number
     * @return port number
     */
    int port();

    /**
     * @brief Get host address
     * @return host address
     */
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

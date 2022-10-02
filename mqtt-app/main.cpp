#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "mqttclient.h"

int main(int argc, char *argv[])
{

#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    // exposing C++ object to Qml
    qmlRegisterType<MqttClient>("MqttClient",1,0,"MqttClient");
//    MqttClient *mqttclient = new MqttClient(&app);
//    engine.rootContext()->setContextProperty("mqttclient", mqttclient);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}

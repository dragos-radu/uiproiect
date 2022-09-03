#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml/QQmlEngine>
#include <qqml.h>
#include <QtQml>
#include "cmd.h"


int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;



    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.rootContext()->setContextProperty("CurDirPath", QString(QDir::currentPath()));

    qmlRegisterType<Process>( "Process", 1, 0, "Process" );
    engine.load(url);




    return app.exec();
}

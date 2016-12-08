#include "onesignalqml.h"

#if defined(Q_OS_IOS)
#include "ios/onesignalqmlios.h"
#endif

static OneSignalQml *_instance = 0;

OneSignalQml::OneSignalQml(QQuickItem *parent) : QQuickItem(parent)
{

}

OneSignalQml::~OneSignalQml()
{

}

void OneSignalQml::registerQmlContext()
{
    qmlRegisterSingletonType<OneSignalQml>("OneSignal", 1, 0, "OneSignal", OneSignalQml::instance);
}

OneSignalQml *OneSignalQml::instance()
{
    if (_instance == 0) {
        _instance = new OneSignalQml();
    }

    return _instance;
}

QObject *OneSignalQml::instance(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);

    return OneSignalQml::instance();
}

#if defined(Q_OS_IOS)
void OneSignalQml::init(QString appId, void *launchOptions, InFocusNotificationDisplay displayOption)
{
    OneSignalQmliOS::init(appId, launchOptions, displayOption);
}
#endif

void OneSignalQml::registerForPushNotifications()
{
#if defined(Q_OS_IOS)
    OneSignalQmliOS::registerForPushNotifications();
#else
    // TODO
    qDebug() << "TODO: OneSignalQml::registerForPushNotifications()";
#endif
}

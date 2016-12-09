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
    qDebug() << "TODO: OneSignalQml::registerForPushNotifications()";
#endif
}

void OneSignalQml::getTags()
{
#if defined(Q_OS_IOS)
    OneSignalQmliOS::getTags();
#else
    qDebug() << "TODO: OneSignalQml::getTags()";
#endif
}

void OneSignalQml::sendTag(QString key, QString value)
{
#if defined(Q_OS_IOS)
    OneSignalQmliOS::sendTag(key, value);
#else
    qDebug() << "TODO: OneSignalQml::sendTag(QString key, QString value)";
#endif
}

void OneSignalQml::sendTags(QVariantMap tags)
{
#if defined(Q_OS_IOS)
    OneSignalQmliOS::sendTags(tags);
#else
    qDebug() << "TODO: OneSignalQml::sendTags(QVariantMap tags)";
#endif
}

void OneSignalQml::deleteTag(QString key)
{
#if defined(Q_OS_IOS)
    OneSignalQmliOS::deleteTag(key);
#else
    qDebug() << "TODO: OneSignalQml::deleteTag(QString key)";
#endif
}

void OneSignalQml::deleteTags(QVariantList tags)
{
#if defined(Q_OS_IOS)
    OneSignalQmliOS::deleteTags(tags);
#else
    qDebug() << "TODO: OneSignalQml::deleteTags(QVariantList tags)";
#endif
}

void OneSignalQml::promptLocation()
{
#if defined(Q_OS_IOS)
    OneSignalQmliOS::promptLocation();
#else
    qDebug() << "TODO: OneSignalQml::promptLocation()";
#endif
}

void OneSignalQml::syncHashedEmail(QString email)
{
#if defined(Q_OS_IOS)
    OneSignalQmliOS::syncHashedEmail(email);
#else
    qDebug() << "TODO: OneSignalQml::syncHashedEmail(QString email)";
#endif
}
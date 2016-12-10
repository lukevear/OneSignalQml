#include "onesignalqml.h"

#if defined(Q_OS_IOS)
#include "ios/onesignalqmlios.h"
#elif defined(Q_OS_ANDROID)
#include "android/onesignalqmlandroid.h"
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
#elif defined (Q_OS_ANDROID)
void OneSignalQml::init(InFocusNotificationDisplay displayOption)
{
    OneSignalQmlAndroid::init(displayOption);
}
#endif

void OneSignalQml::registerForPushNotifications()
{
#if defined(Q_OS_IOS)
    OneSignalQmliOS::registerForPushNotifications();
#endif
}

void OneSignalQml::getTags()
{
#if defined(Q_OS_IOS)
    OneSignalQmliOS::getTags();
#elif defined(Q_OS_ANDROID)
    OneSignalQmlAndroid::getTags();
#else
    emit tagsRetrieved(QVariantMap());
#endif
}

void OneSignalQml::sendTag(QString key, QString value)
{
#if defined(Q_OS_IOS)
    OneSignalQmliOS::sendTag(key, value);
#elif defined(Q_OS_ANDROID)
    OneSignalQmlAndroid::sendTag(key, value);
#else
    Q_UNUSED(key);
    Q_UNUSED(value);
#endif
}

void OneSignalQml::sendTags(QVariantMap tags)
{
#if defined(Q_OS_IOS)
    OneSignalQmliOS::sendTags(tags);
#elif defined(Q_OS_ANDROID)
    OneSignalQmlAndroid::sendTags(tags);
#else
    Q_UNUSED(tags);
#endif
}

void OneSignalQml::deleteTag(QString key)
{
#if defined(Q_OS_IOS)
    OneSignalQmliOS::deleteTag(key);
#elif defined(Q_OS_ANDROID)
    OneSignalQmlAndroid::deleteTag(key);
#else
    Q_UNUSED(key);
#endif
}

void OneSignalQml::deleteTags(QVariantList tags)
{
#if defined(Q_OS_IOS)
    OneSignalQmliOS::deleteTags(tags);
#elif defined(Q_OS_ANDROID)
    OneSignalQmlAndroid::deleteTags(tags);
#else
    Q_UNUSED(tags);
#endif
}

void OneSignalQml::promptLocation()
{
#if defined(Q_OS_IOS)
    OneSignalQmliOS::promptLocation();
#endif
}

void OneSignalQml::syncHashedEmail(QString email)
{
#if defined(Q_OS_IOS)
    OneSignalQmliOS::syncHashedEmail(email);
#elif defined(Q_OS_ANDROID)
    OneSignalQmlAndroid::syncHashedEmail(email);
#else
    Q_UNUSED(email);
#endif
}

#include "onesignalqmlandroid.h"

#include <QtAndroid>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>

static QAndroidJniObject OneSignalQmlNotificationHandler = 0;

void OneSignalQmlAndroid::init(OneSignalQml::InFocusNotificationDisplay displayOption)
{
    // We need to ensure that OneSignal is infact available before continuing
    if (QAndroidJniObject::isClassAvailable("com/onesignal/OneSignal")) {

        // This gives us a OneSignal.builder, which allows us to chain the setup
        QAndroidJniObject builder = QAndroidJniObject::callStaticObjectMethod(
            "com/onesignal/OneSignal",
            "startInit",
            "(Landroid/content/Context;)Lcom/onesignal/OneSignal$Builder;",
            QtAndroid::androidActivity().object<jobject>()
        );

        // Translate our in-focus notification display option to OneSignal's
        QAndroidJniObject appDisplayOption;
        switch (displayOption) {
            case OneSignalQml::InFocusNotificationDisplay::Notification:
                appDisplayOption = QAndroidJniObject::getStaticObjectField(
                    "com/onesignal/OneSignal$OSInFocusDisplayOption",
                    "Notification",
                    "Lcom/onesignal/OneSignal$OSInFocusDisplayOption;"
                );
                break;
            case OneSignalQml::InFocusNotificationDisplay::InAppAlert:
                appDisplayOption = QAndroidJniObject::getStaticObjectField(
                    "com/onesignal/OneSignal$OSInFocusDisplayOption",
                    "InAppAlert",
                    "Lcom/onesignal/OneSignal$OSInFocusDisplayOption;"
                );
                break;
            case OneSignalQml::InFocusNotificationDisplay::None:

                appDisplayOption = QAndroidJniObject::getStaticObjectField(
                    "com/onesignal/OneSignal$OSInFocusDisplayOption",
                    "None",
                    "Lcom/onesignal/OneSignal$OSInFocusDisplayOption;"
                );
                break;
        }

        // Set the in-focus notification display option
        builder = builder.callObjectMethod(
            "inFocusDisplaying",
            "(Lcom/onesignal/OneSignal$OSInFocusDisplayOption;)Lcom/onesignal/OneSignal$Builder;",
            appDisplayOption.object<jobject>()
        );

        // Check if our custom notification handler is available
        if (QAndroidJniObject::isClassAvailable("com/lukevear/onesignalqml/OneSignalQmlNotificationHandler")) {
            OneSignalQmlNotificationHandler = QAndroidJniObject(
                "com/lukevear/onesignalqml/OneSignalQmlNotificationHandler"
            );

            // Register our native methods
            JNINativeMethod methods[] {
                {"notificationReceived", "(Ljava/lang/String;)V", reinterpret_cast<void *>(JNINotificationReceived)},
                {"notificationOpened", "(Ljava/lang/String;)V", reinterpret_cast<void *>(JNINotificationOpened)},
                {"tagsAvailable", "(Ljava/lang/String;)V", reinterpret_cast<void *>(JNITagsAvailable)}
            };

            QAndroidJniEnvironment env;
            jclass objectClass = env->GetObjectClass(OneSignalQmlNotificationHandler.object<jobject>());
            env->RegisterNatives(objectClass, methods, sizeof(methods) / sizeof(methods[0]));
            env->DeleteLocalRef(objectClass);

            // The handler for when notifications are recieved
            builder = builder.callObjectMethod(
                "setNotificationReceivedHandler",
                "(Lcom/onesignal/OneSignal$NotificationReceivedHandler;)Lcom/onesignal/OneSignal$Builder;",
                OneSignalQmlNotificationHandler.object<jobject>()
            );

            // The handler for when notifications are opened
            builder = builder.callObjectMethod(
                "setNotificationOpenedHandler",
                "(Lcom/onesignal/OneSignal$NotificationOpenedHandler;)Lcom/onesignal/OneSignal$Builder;",
                OneSignalQmlNotificationHandler.object<jobject>()
            );
        }

        // Off we go!
        builder.callMethod<void>(
            "init",
            "()V"
        );
    }
}

void OneSignalQmlAndroid::getTags()
{
    if (OneSignalQmlNotificationHandler != 0) {
        QAndroidJniObject::callStaticMethod<void>(
            "com/onesignal/OneSignal",
            "getTags",
            "(Lcom/onesignal/OneSignal$GetTagsHandler;)V",
            OneSignalQmlNotificationHandler.object<jobject>()
        );
    }
}

void OneSignalQmlAndroid::sendTag(QString key, QString value)
{
    QAndroidJniObject::callStaticMethod<void>(
        "com/onesignal/OneSignal",
        "sendTag",
        "(Ljava/lang/String;Ljava/lang/String;)V",
        QAndroidJniObject::fromString(key).object<jstring>(),
        QAndroidJniObject::fromString(value).object<jstring>()
    );
}

void OneSignalQmlAndroid::sendTags(QVariantMap tags)
{

    QAndroidJniObject::callStaticMethod<void>(
        "com/onesignal/OneSignal",
        "sendTags",
        "(Ljava/lang/String;)V",
        QAndroidJniObject::fromString(
            QJsonDocument(QJsonObject::fromVariantMap(tags)).toJson(QJsonDocument::Compact)
        ).object<jstring>()
    );
}

void OneSignalQmlAndroid::deleteTag(QString key)
{
    QAndroidJniObject::callStaticMethod<void>(
        "com/onesignal/OneSignal",
        "deleteTag",
        "(Ljava/lang/String;)V",
        QAndroidJniObject::fromString(key).object<jstring>()
    );
}

void OneSignalQmlAndroid::deleteTags(QVariantList tags)
{
    QAndroidJniObject::callStaticMethod<void>(
        "com/onesignal/OneSignal",
        "deleteTags",
        "(Ljava/lang/String;)V",
        QAndroidJniObject::fromString(
            QJsonDocument(QJsonArray::fromVariantList(tags)).toJson(QJsonDocument::Compact)
        ).object<jstring>()
    );
}

void OneSignalQmlAndroid::promptLocation()
{
    QAndroidJniObject::callStaticMethod<void>(
        "com/onesignal/OneSignal",
        "promptLocation",
        "()V"
    );
}

void OneSignalQmlAndroid::syncHashedEmail(QString email)
{
    QAndroidJniObject::callStaticMethod<void>(
        "com/onesignal/OneSignal",
        "syncHashedEmail",
        "(Ljava/lang/String;)V",
        QAndroidJniObject::fromString(email).object<jstring>()
    );
}

void OneSignalQmlAndroid::JNINotificationReceived(JNIEnv *env, jobject thiz, jstring notification)
{
    Q_UNUSED(env);
    Q_UNUSED(thiz);

    emit OneSignalQml::instance()->notificationReceived(
        QJsonDocument::fromJson(QAndroidJniObject(notification).toString().toUtf8()).object().toVariantMap()
    );
}

void OneSignalQmlAndroid::JNINotificationOpened(JNIEnv *env, jobject thiz, jstring result)
{
    Q_UNUSED(env);
    Q_UNUSED(thiz);

    emit OneSignalQml::instance()->notificationAction(
        QJsonDocument::fromJson(QAndroidJniObject(result).toString().toUtf8()).object().toVariantMap()
    );
}

void OneSignalQmlAndroid::JNITagsAvailable(JNIEnv *env, jobject thiz, jstring tags)
{
    Q_UNUSED(env);
    Q_UNUSED(thiz);

    emit OneSignalQml::instance()->tagsRetrieved(
        QJsonDocument::fromJson(QAndroidJniObject(tags).toString().toUtf8()).object().toVariantMap()
    );
}

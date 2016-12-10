#ifndef ONESIGNALANDROID_H
#define ONESIGNALANDROID_H

#include "onesignalqml.h"
#include <QAndroidJniEnvironment>
#include <QAndroidJniObject>

class OneSignalQmlAndroid
{

public:
    static void init(OneSignalQml::InFocusNotificationDisplay displayOption);
    static void getTags();
    static void sendTag(QString key, QString value);
    static void sendTags(QVariantMap tags);
    static void deleteTag(QString key);
    static void deleteTags(QVariantList tags);
	static void promptLocation();
    static void syncHashedEmail(QString email);

private:
    static void JNINotificationReceived(JNIEnv *env, jobject thiz, jstring notification);
    static void JNINotificationOpened(JNIEnv *env, jobject thiz, jstring result);
    static void JNITagsAvailable(JNIEnv *env, jobject thiz, jstring tags);
};

#endif // ONESIGNALANDROID_H

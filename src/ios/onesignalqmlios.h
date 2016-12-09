#ifndef ONESIGNALIOS_H
#define ONESIGNALIOS_H

#include "onesignalqml.h"

class OneSignalQmliOS
{

public:
    static void init(QString appId, void *launchOptions, OneSignalQml::InFocusNotificationDisplay displayOption);
    static void registerForPushNotifications();
    static void getTags();
    static void sendTag(QString key, QString value);
    static void sendTags(QVariantMap tags);
    static void deleteTag(QString key);
    static void deleteTags(QVariantList tags);
	static void promptLocation();
    static void syncHashedEmail(QString email);

private:
	static QVariantMap notificationToVariantMap(void *notification);
	static QVariantMap notificationPayloadToVariantMap(void *payload);
};

#endif // ONESIGNALIOS_H

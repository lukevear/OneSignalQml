#ifndef ONESIGNALIOS_H
#define ONESIGNALIOS_H

#include "onesignalqml.h"

class OneSignalQmliOS
{

public:
    static void init(QString appId, void *launchOptions, OneSignalQml::InFocusNotificationDisplay displayOption);
    static void registerForPushNotifications();
};

#endif // ONESIGNALIOS_H

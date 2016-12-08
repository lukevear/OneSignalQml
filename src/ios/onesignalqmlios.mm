#include "onesignalqmlios.h"

#import <OneSignal/OneSignal.h>
#import <UIKit/UIKit.h>

#include <QDebug>

void OneSignalQmliOS::init(QString appId, void *launchOptions, OneSignalQml::InFocusNotificationDisplay displayOption)
{
    // Bind to when ids are available
    [OneSignal IdsAvailable:^(NSString* userId, NSString* pushToken) {
        Q_UNUSED(userId);
        Q_UNUSED(pushToken);

        emit OneSignalQml::instance()->registered();
    }];

    // Determine which display option to use
    OSNotificationDisplayType appDisplayOption = OSNotificationDisplayTypeInAppAlert;
    switch (displayOption) {
        case OneSignalQml::InFocusNotificationDisplay::Notification:
            appDisplayOption = OSNotificationDisplayTypeNotification;
            break;
        case OneSignalQml::InFocusNotificationDisplay::InAppAlert:
            // Nothing to do as it's the default
            break;
        case OneSignalQml::InFocusNotificationDisplay::None:
            appDisplayOption = OSNotificationDisplayTypeNone;
            break;
    }

    // Init OneSignal
    [OneSignal initWithLaunchOptions:static_cast<NSDictionary *>(launchOptions)
        appId:appId.toNSString()
        handleNotificationReceived:^(OSNotification *notification) {
            qDebug() << "handleNotificationReceived";
            // TODO: Deliver the notification
        }
        handleNotificationAction:^(OSNotificationOpenedResult *result) {
            qDebug() << "handleNotificationAction";
            // TODO: Deliver the notification
        }
        settings:@{
            kOSSettingsKeyAutoPrompt : @NO,
            kOSSettingsKeyInFocusDisplayOption : @(appDisplayOption)
        }
    ];
}

void OneSignalQmliOS::registerForPushNotifications()
{
    [OneSignal registerForPushNotifications];
}

#include "onesignalqmlios.h"

#include "shavhelpermanager.h"
#import <OneSignal/OneSignal.h>
#import <UIKit/UIKit.h>

void OneSignalQmliOS::init(QString appId, void *launchOptions, OneSignalQml::InFocusNotificationDisplay displayOption)
{
    // Bind to when ids are available
    [OneSignal IdsAvailable:^(NSString* userId, NSString* pushToken) {
        emit OneSignalQml::instance()->idsAvailable(
            QString::fromNSString(userId),
            pushToken != nil ? QString::fromNSString(pushToken) : ""
        );
    }];

    // Determine which display option to use
    OSNotificationDisplayType appDisplayOption;
    switch (displayOption) {
        case OneSignalQml::InFocusNotificationDisplay::Notification:
            appDisplayOption = OSNotificationDisplayTypeNotification;
            break;
        case OneSignalQml::InFocusNotificationDisplay::InAppAlert:
            appDisplayOption = OSNotificationDisplayTypeInAppAlert;
            break;
        case OneSignalQml::InFocusNotificationDisplay::None:
            appDisplayOption = OSNotificationDisplayTypeNone;
            break;
    }

    // Init OneSignal
    [OneSignal initWithLaunchOptions:static_cast<NSDictionary *>(launchOptions)
        appId:appId.toNSString()
        handleNotificationReceived:^(OSNotification *notification) {
            emit OneSignalQml::instance()->notificationReceived(
                OneSignalQmliOS::notificationToVariantMap(notification)
            );
        }
        handleNotificationAction:^(OSNotificationOpenedResult *result) {
            // Determine the action
            QVariantMap action;
            action["actionId"] = result.action.actionID != NULL ? QString::fromNSString(result.action.actionID) : "";
            action["type"] = result.action.type == OSNotificationActionTypeOpened ? OneSignalQml::ActionType::Opened : OneSignalQml::ActionType::ActionTaken;

            // Build our result
            QVariantMap openedResult;
            openedResult["notification"] = OneSignalQmliOS::notificationToVariantMap(result.notification);
            openedResult["action"] = action;

            // Deliver the opened result
            emit OneSignalQml::instance()->notificationAction(openedResult);
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

void OneSignalQmliOS::getTags()
{
    [OneSignal getTags:^(NSDictionary* result) {
        emit OneSignalQml::instance()->tagsRetrieved(
            [ShavHelperManager NSDictionaryToVariantMap:result]
        );
    }];
}

void OneSignalQmliOS::sendTag(QString key, QString value)
{
    [OneSignal sendTag:key.toNSString() value:value.toNSString()];
}

void OneSignalQmliOS::sendTags(QVariantMap tags)
{
    [OneSignal sendTags:[ShavHelperManager variantToNSDictionary:tags]];
}

void OneSignalQmliOS::deleteTag(QString key)
{
    [OneSignal deleteTag:key.toNSString()];
}

void OneSignalQmliOS::deleteTags(QVariantList tags)
{
    [OneSignal deleteTags:[ShavHelperManager variantListToNSArray:tags]];
}

void OneSignalQmliOS::promptLocation()
{
    [OneSignal promptLocation];
}

void OneSignalQmliOS::syncHashedEmail(QString email)
{
    [OneSignal syncHashedEmail:email.toNSString()];
}

QVariantMap OneSignalQmliOS::notificationToVariantMap(void *notification)
{
    // Convert to an OSNotification
    OSNotification *_notification = static_cast<OSNotification *>(notification);

    // Start building the notification
    QVariantMap result = QVariantMap();
    
    // Convert the payload
    result["payload"] = OneSignalQmliOS::notificationPayloadToVariantMap(_notification.payload);

    // Determine the notification display type
    switch (_notification.displayType) {
        case OSNotificationDisplayTypeNotification:
            result["displayType"] = OneSignalQml::InFocusNotificationDisplay::Notification;
            break;
        case OSNotificationDisplayTypeInAppAlert:
            result["displayType"] = OneSignalQml::InFocusNotificationDisplay::InAppAlert;
            break;
        case OSNotificationDisplayTypeNone:
            result["displayType"] = OneSignalQml::InFocusNotificationDisplay::None;
            break;
    }

    // Misc info.
    result["shown"] = _notification.shown == YES;
    result["silentNotification"] = _notification.silentNotification == YES;

    // We have a notification
    return result;
}

QVariantMap OneSignalQmliOS::notificationPayloadToVariantMap(void *payload)
{
    // Convert to an OSNotificationPayload
    OSNotificationPayload *_payload = static_cast<OSNotificationPayload *>(payload);

    // Build the payload
    QVariantMap result = QVariantMap();

    result["notificationID"]   = QString::fromNSString(_payload.notificationID);
    result["contentAvailable"] = _payload.contentAvailable == YES;
    result["badge"]            = [_payload.badge intValue];
    result["sound"]            = QString::fromNSString(_payload.sound);
    result["title"]            = QString::fromNSString(_payload.title);
    result["body"]             = QString::fromNSString(_payload.body);
    result["subtitle"]         = QString::fromNSString(_payload.subtitle);
    result["launchURL"]        = QString::fromNSString(_payload.launchURL);
    result["additionalData"]   = [ShavHelperManager NSDictionaryToVariantMap:_payload.additionalData];
    result["attachments"]      = [ShavHelperManager NSDictionaryToVariantMap:_payload.attachments];
    result["actionButtons"]    = [ShavHelperManager NSDictionaryToVariantMap:_payload.actionButtons];
    result["rawPayload"]       = [ShavHelperManager NSDictionaryToVariantMap:_payload.rawPayload];

    // We have a payload
    return result;
}

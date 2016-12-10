#ifndef ONESIGNALQML_H
#define ONESIGNALQML_H

#include <QQuickItem>

class OneSignalQml : public QQuickItem
{
    Q_OBJECT
    Q_DISABLE_COPY(OneSignalQml)

public:
    // Used to access the singleton
    static void registerQmlContext();
    static OneSignalQml *instance();
    static QObject *instance(QQmlEngine *engine, QJSEngine *scriptEngine);

    enum InFocusNotificationDisplay {
        Notification,
        InAppAlert,
        None
    };

    enum ActionType {
        Opened,
        ActionTaken
    };

#if defined(Q_OS_IOS)
    static void init(QString appId, void *launchOptions, InFocusNotificationDisplay displayOption);
#elif defined(Q_OS_ANDROID)
    static void init(InFocusNotificationDisplay displayOption);
#endif

    // Registering Push
    Q_INVOKABLE void registerForPushNotifications();

    // Tags
    Q_INVOKABLE void getTags();
    Q_INVOKABLE void sendTag(QString key, QString value);
    Q_INVOKABLE void sendTags(QVariantMap tags);
    Q_INVOKABLE void deleteTag(QString key);
    Q_INVOKABLE void deleteTags(QVariantList tags);

    // Data
    Q_INVOKABLE void promptLocation();
    Q_INVOKABLE void syncHashedEmail(QString email);

private:
    explicit OneSignalQml(QQuickItem *parent = 0);
    ~OneSignalQml();

signals:
    // User IDs
    void idsAvailable(QString userId, QString pushToken);

    // Tags
    void tagsRetrieved(QVariantMap tags);

    // Receiving Notifications
    void notificationReceived(QVariantMap notification);
    void notificationAction(QVariantMap action);
};

#endif // ONESIGNALQML_H

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

#if defined(Q_OS_IOS)
    enum InFocusNotificationDisplay {
        Notification,
        InAppAlert,
        None
    };

    static void init(QString appId, void *launchOptions, InFocusNotificationDisplay displayOption);
#endif

    Q_INVOKABLE void registerForPushNotifications();

private:
    explicit OneSignalQml(QQuickItem *parent = 0);
    ~OneSignalQml();

signals:
    void registered();
};

#endif // ONESIGNALQML_H

package com.lukevear.onesignalqml;

import com.onesignal.OneSignal;
import com.onesignal.OSNotification;
import com.onesignal.OSNotificationOpenResult;
import org.json.JSONObject;

public class OneSignalQmlNotificationHandler implements OneSignal.NotificationReceivedHandler, OneSignal.NotificationOpenedHandler, OneSignal.GetTagsHandler {

    @Override
    public void notificationReceived(OSNotification notification) {
        OneSignalQmlNotificationHandler.notificationReceived(notification.toJSONObject().toString());
    }

    @Override
    public void notificationOpened(OSNotificationOpenResult result) {
        OneSignalQmlNotificationHandler.notificationOpened(result.toJSONObject().toString());
    }

    @Override
    public void tagsAvailable(JSONObject tags) {
        OneSignalQmlNotificationHandler.tagsAvailable(tags.toString());
    }

    public static native void notificationReceived(String notification);
    public static native void notificationOpened(String result);
    public static native void tagsAvailable(String tags);
}

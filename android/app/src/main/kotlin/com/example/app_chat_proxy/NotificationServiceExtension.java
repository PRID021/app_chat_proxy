package com.example.app_chat_proxy;

import com.onesignal.notifications.IActionButton;
import com.onesignal.notifications.IDisplayableMutableNotification;
import com.onesignal.notifications.INotificationReceivedEvent;
import com.onesignal.notifications.INotificationServiceExtension;

public class NotificationServiceExtension implements INotificationServiceExtension {

    @Override
    public void onNotificationReceived(INotificationReceivedEvent event) {
        IDisplayableMutableNotification notification = event.getNotification();

        if (notification.getActionButtons() != null) {
            for (IActionButton button : notification.getActionButtons()) {
                // you can modify your action buttons here
            }
        }

        // this is an example of how to modify the notification by changing the background color to blue
        notification.setExtender(builder -> builder.setColor(0xFF0000FF));
    }
}
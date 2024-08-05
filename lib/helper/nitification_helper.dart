import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  NotificationHelper._();
  static final NotificationHelper instance = NotificationHelper._();

  FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void initNotification() {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('ic_launcher');
  }
}

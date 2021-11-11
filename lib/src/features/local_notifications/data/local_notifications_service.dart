import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:prospector/src/features/local_notifications/domain/i_local_notifications_service.dart';

class LocalNotificationsService implements ILocalNotificationsService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  LocalNotificationsService({
    required this.flutterLocalNotificationsPlugin,
  });

  final String channelID = 'prospector_events';
  final String channelName = 'Prospector Events';

  @override
  Future<void> initializeLocalNotifications(
      void Function(String?) onSelectNotification) async {
    // TODO: implement initializeLocalNotifications
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings(
            onDidReceiveLocalNotification: (id, title, body, payload) =>
                onSelectNotification(payload));

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: iosInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    // TODO: select event tab by homeIndex, get event from paylod id, select calendar day, and navigate to event details
  }

  @override
  void scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime date,
    required String eventID,
  }) {
    // TODO: implement scheduleNotification
    final scheduledDate = tz.TZDateTime.from(date, tz.local);

    final NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        channelID,
        channelName,
        importance: Importance.max,
        priority: Priority.max,
      ),
    );

    flutterLocalNotificationsPlugin.zonedSchedule(
        id, title, body, scheduledDate, notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        payload: eventID);
  }

  @override
  void cancelAllNotifications() {
    // TODO: implement cancelAllNotifications
    flutterLocalNotificationsPlugin.cancelAll();
  }

  @override
  void cancelNotification({required int id}) {
    // TODO: implement cancelNotification
    flutterLocalNotificationsPlugin.cancel(id);
  }
}

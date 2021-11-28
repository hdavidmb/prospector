import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../domain/i_local_notifications_service.dart';

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
  }

  @override
  void scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime date,
    required String payload,
  }) {
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
        payload: payload);
  }

  @override
  void cancelAllNotifications() {
    flutterLocalNotificationsPlugin.cancelAll();
  }

  @override
  void cancelNotification({required int id}) {
    flutterLocalNotificationsPlugin.cancel(id);
  }
}

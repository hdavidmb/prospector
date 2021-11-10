import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:prospector/src/features/local_notifications/domain/i_local_notifications_service.dart';

class LocalNotificationsService implements ILocalNotificationsService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  LocalNotificationsService({
    required this.flutterLocalNotificationsPlugin,
  });

  @override
  Future<void> initializeLocalNotifications(BuildContext context) async {
    //TODO check for autorouter without context to avoid material dependency
    // TODO: implement initializeLocalNotifications
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

//TODO: create another method to ask for ios permissions
    const IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: iosInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (payload) {
      // TODO: select event tab by homeIndex, get event from paylod id, select calendar day, and navigate to event details
    });
  }

  @override
  void scheduleNotification(
      {required int id,
      required String title,
      required String body,
      required DateTime date}) {
    // TODO: implement scheduleNotification
  }

  @override
  void cancelAllNotifications() {
    // TODO: implement cancelAllNotifications
  }

  @override
  void cancelNotification({required int id}) {
    // TODO: implement cancelNotification
  }
}

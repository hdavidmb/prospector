import 'package:flutter/material.dart';

abstract class ILocalNotificationsService {
  Future<void> initializeLocalNotifications(BuildContext context);

  void scheduleNotification(
      {required int id,
      required String title,
      required String body,
      required DateTime date});

  void cancelNotification({required int id});

  void cancelAllNotifications();
}

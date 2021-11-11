import 'package:flutter/material.dart';

abstract class ILocalNotificationsService {
  Future<void> initializeLocalNotifications(
      void Function(String?) onSelectNotification);

  void scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime date,
    required String eventID,
  });

  void cancelNotification({required int id});

  void cancelAllNotifications();
}

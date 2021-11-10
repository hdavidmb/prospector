import 'package:flutter/material.dart';
import 'package:prospector/src/features/local_notifications/domain/i_local_notifications_service.dart';

class LocalNotificationsUseCases {
  final ILocalNotificationsService localNotificationsService;
  LocalNotificationsUseCases({
    required this.localNotificationsService,
  });

  Future<void> initializeLocalNotifications(BuildContext context) =>
      localNotificationsService.initializeLocalNotifications(context);

  void scheduleNotification(
          {required int id,
          required String title,
          required String body,
          required DateTime date}) =>
      localNotificationsService.scheduleNotification(
          id: id, title: title, body: body, date: date);

  void cancelNotification({required int id}) =>
      localNotificationsService.cancelNotification(id: id);

  void cancelAllNotifications() =>
      localNotificationsService.cancelAllNotifications();
}

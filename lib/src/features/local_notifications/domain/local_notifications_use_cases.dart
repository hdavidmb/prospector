import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'i_local_notifications_service.dart';

class LocalNotificationsUseCases {
  final ILocalNotificationsService localNotificationsService;
  final Reader read;
  LocalNotificationsUseCases({
    required this.localNotificationsService,
    required this.read,
  });

  Future<void> initializeLocalNotifications(
          void Function(String?) onSelectNotification) =>
      localNotificationsService
          .initializeLocalNotifications(onSelectNotification);

  void scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime date,
    required String payload,
  }) =>
      localNotificationsService.scheduleNotification(
        id: id,
        title: title,
        body: body,
        date: date,
        payload: payload,
      );

  void cancelNotification({required int id}) =>
      localNotificationsService.cancelNotification(id: id);

  void cancelAllNotifications() =>
      localNotificationsService.cancelAllNotifications();
}

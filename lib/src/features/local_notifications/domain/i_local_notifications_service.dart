abstract class ILocalNotificationsService {
  Future<void> initializeLocalNotifications(
      void Function(String?) onSelectNotification);

  void scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime date,
    required String payload,
  });

  void cancelNotification({required int id});

  void cancelAllNotifications();
}

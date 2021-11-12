import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../presentation/pages/user_panel/events/events_view/logic/events_view_providers.dart';
import '../../../presentation/pages/user_panel/home/logic/home_index_provider.dart';
import '../../../presentation/routes/app_router.gr.dart';
import '../../../presentation/routes/app_router_provider.dart';
import '../../events/application/events_providers.dart';
import '../../events/domain/entites/event_entity.dart';
import '../domain/local_notifications_use_cases.dart';
import 'local_notifications_providers.dart';

class LocalNotificationsNotifier {
  final LocalNotificationsUseCases localNotificationsUseCases;
  final Reader read;
  LocalNotificationsNotifier({
    required this.localNotificationsUseCases,
    required this.read,
  });

  bool _alreadyInitialized = false;

  void onSelectNotification(String? eventID) {
    if (eventID != null) {
      final router = read(appRouterProvider);
      router.popUntilRoot();
      read(homeIndexProvider).index = 2;
      final Event event = read(eventsNotifierProvider).events.firstWhere(
          (event) => event.id == eventID,
          orElse: () => Event.empty());
      read(eventsViewProvider).selectedDay = event.startDate;
      router.push(EventDetailsRoute(eventID: eventID));
    }
  }

  Future<void> initializeLocalNotifications() async {
    if (!_alreadyInitialized) {
      _alreadyInitialized = true;
      await localNotificationsUseCases
          .initializeLocalNotifications(onSelectNotification);
    }
  }

  Future<void> handleAppLaunchedFromNotification() async {
// Code for when app is launched from notification
    final details = await read(localNotificationsPluginProvider)
        .getNotificationAppLaunchDetails();
    if (details?.didNotificationLaunchApp ?? false) {
      onSelectNotification(details?.payload);
    }
  }

  void scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime date,
    required String payload,
  }) {
    if (date.isAfter(DateTime.now())) {
      localNotificationsUseCases.scheduleNotification(
        id: id,
        title: '🗓 $title',
        body: body,
        date: date,
        payload: payload,
      );
    }
  }

  void cancelNotification({required int id}) =>
      localNotificationsUseCases.cancelNotification(id: id);

  void cancelAllNotifications() =>
      localNotificationsUseCases.cancelAllNotifications();
}

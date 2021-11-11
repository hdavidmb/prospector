import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/events/application/events_providers.dart';
import 'package:prospector/src/features/events/domain/entites/event_entity.dart';
import 'package:prospector/src/features/local_notifications/application/local_notifications_providers.dart';

import 'package:prospector/src/features/local_notifications/domain/i_local_notifications_service.dart';
import 'package:prospector/src/presentation/pages/user_panel/events/events_view/logic/events_view_providers.dart';
import 'package:prospector/src/presentation/pages/user_panel/home/logic/home_index_provider.dart';
import 'package:prospector/src/presentation/routes/app_router.gr.dart';
import 'package:prospector/src/presentation/routes/app_router_provider.dart';

class LocalNotificationsUseCases {
  final ILocalNotificationsService localNotificationsService;
  final Reader read;
  LocalNotificationsUseCases({
    required this.localNotificationsService,
    required this.read,
  });

  bool _alreadyInitialized = false;
  // Timer? _timer; //TODO test and delete

  Future<void> initializeLocalNotifications() async {
    if (!_alreadyInitialized) {
      _alreadyInitialized = true;

      void onSelectNotification(String? eventID) {
        if (eventID != null) {
          // if (_timer != null && _timer!.isActive) _timer!.cancel();
          // _timer = Timer(
          //   const Duration(milliseconds: 50),
          //   () {
          //TODO: select event tab and envent day
          final router = read(appRouterProvider);
          router.popUntilRoot();
          read(homeIndexProvider).index = 2;
          final Event event = read(eventsNotifierProvider).events.firstWhere(
              (event) => event.id == eventID,
              orElse: () => Event.empty());
          read(eventsViewProvider).selectedDay = event.startDate;
          router.push(EventDetailsRoute(eventID: eventID));
          //   },
          // );
        }
      }

      await localNotificationsService
          .initializeLocalNotifications(onSelectNotification);
      // TODO: place code for when app is launched by notification

      // Code for when app is launced from notification
      final details = await read(localNotificationsPluginProvider)
          .getNotificationAppLaunchDetails();
      if (details?.didNotificationLaunchApp ?? false) {
        onSelectNotification(details?.payload);
      }
    }
  }

  void scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime date,
    required String eventID,
  }) =>
      localNotificationsService.scheduleNotification(
        id: id,
        title: title,
        body: body,
        date: date,
        eventID: eventID,
      );

  void cancelNotification({required int id}) =>
      localNotificationsService.cancelNotification(id: id);

  void cancelAllNotifications() =>
      localNotificationsService.cancelAllNotifications();
}

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/local_notifications_service.dart';
import '../domain/local_notifications_use_cases.dart';
import 'local_notifications_notifier.dart';

// Plugin instance
final localNotificationsPluginProvider =
    Provider<FlutterLocalNotificationsPlugin>((ref) {
  return FlutterLocalNotificationsPlugin();
});

// Service
final localNotificationsService = Provider<LocalNotificationsService>((ref) {
  final _flutterLocalNotificationsPlugin =
      ref.watch(localNotificationsPluginProvider);
  return LocalNotificationsService(
      flutterLocalNotificationsPlugin: _flutterLocalNotificationsPlugin);
});

// Use cases
final localNotificationsUseCases = Provider<LocalNotificationsUseCases>((ref) {
  final _localNotificationsService = ref.watch(localNotificationsService);
  return LocalNotificationsUseCases(
    localNotificationsService: _localNotificationsService,
    read: ref.read,
  );
});

final localNotificationsProvider = Provider<LocalNotificationsNotifier>((ref) {
  final LocalNotificationsUseCases _localNotificationsUseCases =
      ref.watch(localNotificationsUseCases);
  return LocalNotificationsNotifier(
      localNotificationsUseCases: _localNotificationsUseCases, read: ref.read);
});

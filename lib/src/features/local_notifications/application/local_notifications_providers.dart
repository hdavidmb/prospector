import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/local_notifications/data/local_notifications_service.dart';
import 'package:prospector/src/features/local_notifications/domain/local_notifications_use_cases.dart';

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
final localNotificationsProvider = Provider<LocalNotificationsUseCases>((ref) {
  final _localNotificationsService = ref.watch(localNotificationsService);
  return LocalNotificationsUseCases(
    localNotificationsService: _localNotificationsService,
    read: ref.read,
  );
});

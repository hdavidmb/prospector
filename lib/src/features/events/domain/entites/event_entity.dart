import 'package:freezed_annotation/freezed_annotation.dart';

import 'event_alert.dart';

part 'event_entity.freezed.dart';

@freezed
class Event with _$Event {
  const factory Event({
    required String id,
    required bool allDay,
    required DateTime created,
    required DateTime modified,
    required DateTime startDate,
    required DateTime endDate,
    required String title,
    required String type,
    required List<EventAlert> notifications,
    List<String>? guests,
    String? location,
    List<int>? notificationsIDs,
  }) = _Event;

  const Event._();

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> eventMap = {
      'id': id,
      'all_day': allDay,
      'created': created,
      'modified': modified,
      'start_date': startDate,
      'end_date': endDate,
      'title': title,
      'type': type,
    };
    if (guests != null && guests!.isNotEmpty) eventMap['guests'] = guests;
    if (location != null && location != '') eventMap['location'] = location;
    if (notifications.isNotEmpty && !notifications.contains(EventAlert.none)) {
      eventMap['notifications'] = notifications
          .map((alert) => startDate.subtract(alert.duration!))
          .toList();
    }

    if (notificationsIDs != null && notificationsIDs!.isNotEmpty) {
      eventMap['notificationsIDs'] = notificationsIDs;
    }
    return eventMap;
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    List<EventAlert> notifications = [EventAlert.none];
    final mapNotifications = map['notifications'] as List<DateTime>?;
    if (mapNotifications != null && mapNotifications.isNotEmpty) {
      notifications = mapNotifications
          .map(
            (mapNotification) => EventAlert.values.firstWhere(
              (alert) =>
                  alert.duration ==
                  (map['start_date'] as DateTime).difference(mapNotification),
            ),
          )
          .toList();
    }
    return Event(
      allDay: map['all_day'] as bool,
      created: map['created'] as DateTime,
      modified: map['modified'] as DateTime,
      startDate: map['start_date'] as DateTime,
      endDate: map['end_date'] as DateTime,
      title: map['title'] as String,
      type: map['type'] as String,
      id: map['id'] as String,
      guests: map['guests'] as List<String>?,
      location: map['location'] as String?,
      notifications: notifications,
      notificationsIDs: map['notificationsIDs'] as List<int>?,
    );
  }

  factory Event.empty() => Event(
        id: '',
        allDay: false,
        created: DateTime.now(),
        modified: DateTime.now(),
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        notifications: [EventAlert.none],
        title: '',
        type: 'event',
      );
}

import 'package:freezed_annotation/freezed_annotation.dart';

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
    List<String>? guests,
    String? location,
    List<DateTime>? notifications,
    List<String>? notificationsIDs,
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
    if (notifications != null && notifications!.isNotEmpty) {
      eventMap['notifications'] = notifications;
    }

    if (notificationsIDs != null && notificationsIDs!.isNotEmpty) {
      //TODO check what is this for
      eventMap['notificationsIDs'] = notificationsIDs;
    }
    return eventMap;
  }

  factory Event.fromMap(Map<String, dynamic> map) {
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
      notifications: map['notifications'] as List<DateTime>?,
      notificationsIDs: map['notificationsIDs'] as List<String>?,
    );
  }
}

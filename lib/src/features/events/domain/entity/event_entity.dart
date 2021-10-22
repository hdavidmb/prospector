import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'event_entity.freezed.dart';
part 'event_entity.g.dart';

@freezed
class Event with _$Event {
  @HiveType(typeId: 6)
  const factory Event({
    @HiveField(0) required String id,
    @HiveField(1) required String title,
    @HiveField(2) required DateTime created,
    @HiveField(3) required DateTime modified,
    @HiveField(4) required String type,
    @HiveField(5) required DateTime startDate,
    @HiveField(6) required DateTime endDate,
    @HiveField(7) required bool allDay,
    @HiveField(8) List<String>? guests,
    @HiveField(9) String? location,
    @HiveField(10) List<DateTime>? notifications,
    @HiveField(11) List<String>? notificationsIDs,
  }) = _Event;

  const Event._();

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> eventMap = {
      'all_day': allDay,
      'created': created,
      'end_date': endDate,
      'modified': modified,
      'start_date': startDate,
      'title': title,
      'type': type,
      'id': id,
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

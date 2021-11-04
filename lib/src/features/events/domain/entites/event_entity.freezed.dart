// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'event_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$EventTearOff {
  const _$EventTearOff();

  _Event call(
      {required String id,
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
      List<int>? notificationsIDs}) {
    return _Event(
      id: id,
      allDay: allDay,
      created: created,
      modified: modified,
      startDate: startDate,
      endDate: endDate,
      title: title,
      type: type,
      notifications: notifications,
      guests: guests,
      location: location,
      notificationsIDs: notificationsIDs,
    );
  }
}

/// @nodoc
const $Event = _$EventTearOff();

/// @nodoc
mixin _$Event {
  String get id => throw _privateConstructorUsedError;
  bool get allDay => throw _privateConstructorUsedError;
  DateTime get created => throw _privateConstructorUsedError;
  DateTime get modified => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  List<EventAlert> get notifications => throw _privateConstructorUsedError;
  List<String>? get guests => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  List<int>? get notificationsIDs => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EventCopyWith<Event> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventCopyWith<$Res> {
  factory $EventCopyWith(Event value, $Res Function(Event) then) =
      _$EventCopyWithImpl<$Res>;
  $Res call(
      {String id,
      bool allDay,
      DateTime created,
      DateTime modified,
      DateTime startDate,
      DateTime endDate,
      String title,
      String type,
      List<EventAlert> notifications,
      List<String>? guests,
      String? location,
      List<int>? notificationsIDs});
}

/// @nodoc
class _$EventCopyWithImpl<$Res> implements $EventCopyWith<$Res> {
  _$EventCopyWithImpl(this._value, this._then);

  final Event _value;
  // ignore: unused_field
  final $Res Function(Event) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? allDay = freezed,
    Object? created = freezed,
    Object? modified = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? title = freezed,
    Object? type = freezed,
    Object? notifications = freezed,
    Object? guests = freezed,
    Object? location = freezed,
    Object? notificationsIDs = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      allDay: allDay == freezed
          ? _value.allDay
          : allDay // ignore: cast_nullable_to_non_nullable
              as bool,
      created: created == freezed
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
      modified: modified == freezed
          ? _value.modified
          : modified // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startDate: startDate == freezed
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: endDate == freezed
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      notifications: notifications == freezed
          ? _value.notifications
          : notifications // ignore: cast_nullable_to_non_nullable
              as List<EventAlert>,
      guests: guests == freezed
          ? _value.guests
          : guests // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      location: location == freezed
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      notificationsIDs: notificationsIDs == freezed
          ? _value.notificationsIDs
          : notificationsIDs // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ));
  }
}

/// @nodoc
abstract class _$EventCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory _$EventCopyWith(_Event value, $Res Function(_Event) then) =
      __$EventCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      bool allDay,
      DateTime created,
      DateTime modified,
      DateTime startDate,
      DateTime endDate,
      String title,
      String type,
      List<EventAlert> notifications,
      List<String>? guests,
      String? location,
      List<int>? notificationsIDs});
}

/// @nodoc
class __$EventCopyWithImpl<$Res> extends _$EventCopyWithImpl<$Res>
    implements _$EventCopyWith<$Res> {
  __$EventCopyWithImpl(_Event _value, $Res Function(_Event) _then)
      : super(_value, (v) => _then(v as _Event));

  @override
  _Event get _value => super._value as _Event;

  @override
  $Res call({
    Object? id = freezed,
    Object? allDay = freezed,
    Object? created = freezed,
    Object? modified = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? title = freezed,
    Object? type = freezed,
    Object? notifications = freezed,
    Object? guests = freezed,
    Object? location = freezed,
    Object? notificationsIDs = freezed,
  }) {
    return _then(_Event(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      allDay: allDay == freezed
          ? _value.allDay
          : allDay // ignore: cast_nullable_to_non_nullable
              as bool,
      created: created == freezed
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
      modified: modified == freezed
          ? _value.modified
          : modified // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startDate: startDate == freezed
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: endDate == freezed
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      notifications: notifications == freezed
          ? _value.notifications
          : notifications // ignore: cast_nullable_to_non_nullable
              as List<EventAlert>,
      guests: guests == freezed
          ? _value.guests
          : guests // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      location: location == freezed
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      notificationsIDs: notificationsIDs == freezed
          ? _value.notificationsIDs
          : notificationsIDs // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ));
  }
}

/// @nodoc

class _$_Event extends _Event {
  const _$_Event(
      {required this.id,
      required this.allDay,
      required this.created,
      required this.modified,
      required this.startDate,
      required this.endDate,
      required this.title,
      required this.type,
      required this.notifications,
      this.guests,
      this.location,
      this.notificationsIDs})
      : super._();

  @override
  final String id;
  @override
  final bool allDay;
  @override
  final DateTime created;
  @override
  final DateTime modified;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final String title;
  @override
  final String type;
  @override
  final List<EventAlert> notifications;
  @override
  final List<String>? guests;
  @override
  final String? location;
  @override
  final List<int>? notificationsIDs;

  @override
  String toString() {
    return 'Event(id: $id, allDay: $allDay, created: $created, modified: $modified, startDate: $startDate, endDate: $endDate, title: $title, type: $type, notifications: $notifications, guests: $guests, location: $location, notificationsIDs: $notificationsIDs)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Event &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.allDay, allDay) ||
                const DeepCollectionEquality().equals(other.allDay, allDay)) &&
            (identical(other.created, created) ||
                const DeepCollectionEquality()
                    .equals(other.created, created)) &&
            (identical(other.modified, modified) ||
                const DeepCollectionEquality()
                    .equals(other.modified, modified)) &&
            (identical(other.startDate, startDate) ||
                const DeepCollectionEquality()
                    .equals(other.startDate, startDate)) &&
            (identical(other.endDate, endDate) ||
                const DeepCollectionEquality()
                    .equals(other.endDate, endDate)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.notifications, notifications) ||
                const DeepCollectionEquality()
                    .equals(other.notifications, notifications)) &&
            (identical(other.guests, guests) ||
                const DeepCollectionEquality().equals(other.guests, guests)) &&
            (identical(other.location, location) ||
                const DeepCollectionEquality()
                    .equals(other.location, location)) &&
            (identical(other.notificationsIDs, notificationsIDs) ||
                const DeepCollectionEquality()
                    .equals(other.notificationsIDs, notificationsIDs)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(allDay) ^
      const DeepCollectionEquality().hash(created) ^
      const DeepCollectionEquality().hash(modified) ^
      const DeepCollectionEquality().hash(startDate) ^
      const DeepCollectionEquality().hash(endDate) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(notifications) ^
      const DeepCollectionEquality().hash(guests) ^
      const DeepCollectionEquality().hash(location) ^
      const DeepCollectionEquality().hash(notificationsIDs);

  @JsonKey(ignore: true)
  @override
  _$EventCopyWith<_Event> get copyWith =>
      __$EventCopyWithImpl<_Event>(this, _$identity);
}

abstract class _Event extends Event {
  const factory _Event(
      {required String id,
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
      List<int>? notificationsIDs}) = _$_Event;
  const _Event._() : super._();

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  bool get allDay => throw _privateConstructorUsedError;
  @override
  DateTime get created => throw _privateConstructorUsedError;
  @override
  DateTime get modified => throw _privateConstructorUsedError;
  @override
  DateTime get startDate => throw _privateConstructorUsedError;
  @override
  DateTime get endDate => throw _privateConstructorUsedError;
  @override
  String get title => throw _privateConstructorUsedError;
  @override
  String get type => throw _privateConstructorUsedError;
  @override
  List<EventAlert> get notifications => throw _privateConstructorUsedError;
  @override
  List<String>? get guests => throw _privateConstructorUsedError;
  @override
  String? get location => throw _privateConstructorUsedError;
  @override
  List<int>? get notificationsIDs => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$EventCopyWith<_Event> get copyWith => throw _privateConstructorUsedError;
}

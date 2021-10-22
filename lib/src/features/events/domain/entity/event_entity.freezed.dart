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
      {@HiveField(0) required String id,
      @HiveField(1) required String title,
      @HiveField(2) required DateTime created,
      @HiveField(3) required DateTime modified,
      @HiveField(4) required String type,
      @HiveField(5) required DateTime startDate,
      @HiveField(6) required DateTime endDate,
      @HiveField(7) required bool allDay,
      @HiveField(8) List<dynamic>? guests,
      @HiveField(9) String? location,
      @HiveField(10) List<dynamic>? notifications,
      @HiveField(11) List<dynamic>? notificationsIDs}) {
    return _Event(
      id: id,
      title: title,
      created: created,
      modified: modified,
      type: type,
      startDate: startDate,
      endDate: endDate,
      allDay: allDay,
      guests: guests,
      location: location,
      notifications: notifications,
      notificationsIDs: notificationsIDs,
    );
  }
}

/// @nodoc
const $Event = _$EventTearOff();

/// @nodoc
mixin _$Event {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get title => throw _privateConstructorUsedError;
  @HiveField(2)
  DateTime get created => throw _privateConstructorUsedError;
  @HiveField(3)
  DateTime get modified => throw _privateConstructorUsedError;
  @HiveField(4)
  String get type => throw _privateConstructorUsedError;
  @HiveField(5)
  DateTime get startDate => throw _privateConstructorUsedError;
  @HiveField(6)
  DateTime get endDate => throw _privateConstructorUsedError;
  @HiveField(7)
  bool get allDay => throw _privateConstructorUsedError;
  @HiveField(8)
  List<dynamic>? get guests => throw _privateConstructorUsedError;
  @HiveField(9)
  String? get location => throw _privateConstructorUsedError;
  @HiveField(10)
  List<dynamic>? get notifications => throw _privateConstructorUsedError;
  @HiveField(11)
  List<dynamic>? get notificationsIDs => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EventCopyWith<Event> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventCopyWith<$Res> {
  factory $EventCopyWith(Event value, $Res Function(Event) then) =
      _$EventCopyWithImpl<$Res>;
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String title,
      @HiveField(2) DateTime created,
      @HiveField(3) DateTime modified,
      @HiveField(4) String type,
      @HiveField(5) DateTime startDate,
      @HiveField(6) DateTime endDate,
      @HiveField(7) bool allDay,
      @HiveField(8) List<dynamic>? guests,
      @HiveField(9) String? location,
      @HiveField(10) List<dynamic>? notifications,
      @HiveField(11) List<dynamic>? notificationsIDs});
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
    Object? title = freezed,
    Object? created = freezed,
    Object? modified = freezed,
    Object? type = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? allDay = freezed,
    Object? guests = freezed,
    Object? location = freezed,
    Object? notifications = freezed,
    Object? notificationsIDs = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      created: created == freezed
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
      modified: modified == freezed
          ? _value.modified
          : modified // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: startDate == freezed
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: endDate == freezed
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      allDay: allDay == freezed
          ? _value.allDay
          : allDay // ignore: cast_nullable_to_non_nullable
              as bool,
      guests: guests == freezed
          ? _value.guests
          : guests // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      location: location == freezed
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      notifications: notifications == freezed
          ? _value.notifications
          : notifications // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      notificationsIDs: notificationsIDs == freezed
          ? _value.notificationsIDs
          : notificationsIDs // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
    ));
  }
}

/// @nodoc
abstract class _$EventCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory _$EventCopyWith(_Event value, $Res Function(_Event) then) =
      __$EventCopyWithImpl<$Res>;
  @override
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String title,
      @HiveField(2) DateTime created,
      @HiveField(3) DateTime modified,
      @HiveField(4) String type,
      @HiveField(5) DateTime startDate,
      @HiveField(6) DateTime endDate,
      @HiveField(7) bool allDay,
      @HiveField(8) List<dynamic>? guests,
      @HiveField(9) String? location,
      @HiveField(10) List<dynamic>? notifications,
      @HiveField(11) List<dynamic>? notificationsIDs});
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
    Object? title = freezed,
    Object? created = freezed,
    Object? modified = freezed,
    Object? type = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? allDay = freezed,
    Object? guests = freezed,
    Object? location = freezed,
    Object? notifications = freezed,
    Object? notificationsIDs = freezed,
  }) {
    return _then(_Event(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      created: created == freezed
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
      modified: modified == freezed
          ? _value.modified
          : modified // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: startDate == freezed
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: endDate == freezed
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      allDay: allDay == freezed
          ? _value.allDay
          : allDay // ignore: cast_nullable_to_non_nullable
              as bool,
      guests: guests == freezed
          ? _value.guests
          : guests // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      location: location == freezed
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      notifications: notifications == freezed
          ? _value.notifications
          : notifications // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      notificationsIDs: notificationsIDs == freezed
          ? _value.notificationsIDs
          : notificationsIDs // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
    ));
  }
}

/// @nodoc

@HiveType(typeId: 6)
class _$_Event extends _Event {
  const _$_Event(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.title,
      @HiveField(2) required this.created,
      @HiveField(3) required this.modified,
      @HiveField(4) required this.type,
      @HiveField(5) required this.startDate,
      @HiveField(6) required this.endDate,
      @HiveField(7) required this.allDay,
      @HiveField(8) this.guests,
      @HiveField(9) this.location,
      @HiveField(10) this.notifications,
      @HiveField(11) this.notificationsIDs})
      : super._();

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String title;
  @override
  @HiveField(2)
  final DateTime created;
  @override
  @HiveField(3)
  final DateTime modified;
  @override
  @HiveField(4)
  final String type;
  @override
  @HiveField(5)
  final DateTime startDate;
  @override
  @HiveField(6)
  final DateTime endDate;
  @override
  @HiveField(7)
  final bool allDay;
  @override
  @HiveField(8)
  final List<dynamic>? guests;
  @override
  @HiveField(9)
  final String? location;
  @override
  @HiveField(10)
  final List<dynamic>? notifications;
  @override
  @HiveField(11)
  final List<dynamic>? notificationsIDs;

  @override
  String toString() {
    return 'Event(id: $id, title: $title, created: $created, modified: $modified, type: $type, startDate: $startDate, endDate: $endDate, allDay: $allDay, guests: $guests, location: $location, notifications: $notifications, notificationsIDs: $notificationsIDs)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Event &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.created, created) ||
                const DeepCollectionEquality()
                    .equals(other.created, created)) &&
            (identical(other.modified, modified) ||
                const DeepCollectionEquality()
                    .equals(other.modified, modified)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.startDate, startDate) ||
                const DeepCollectionEquality()
                    .equals(other.startDate, startDate)) &&
            (identical(other.endDate, endDate) ||
                const DeepCollectionEquality()
                    .equals(other.endDate, endDate)) &&
            (identical(other.allDay, allDay) ||
                const DeepCollectionEquality().equals(other.allDay, allDay)) &&
            (identical(other.guests, guests) ||
                const DeepCollectionEquality().equals(other.guests, guests)) &&
            (identical(other.location, location) ||
                const DeepCollectionEquality()
                    .equals(other.location, location)) &&
            (identical(other.notifications, notifications) ||
                const DeepCollectionEquality()
                    .equals(other.notifications, notifications)) &&
            (identical(other.notificationsIDs, notificationsIDs) ||
                const DeepCollectionEquality()
                    .equals(other.notificationsIDs, notificationsIDs)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(created) ^
      const DeepCollectionEquality().hash(modified) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(startDate) ^
      const DeepCollectionEquality().hash(endDate) ^
      const DeepCollectionEquality().hash(allDay) ^
      const DeepCollectionEquality().hash(guests) ^
      const DeepCollectionEquality().hash(location) ^
      const DeepCollectionEquality().hash(notifications) ^
      const DeepCollectionEquality().hash(notificationsIDs);

  @JsonKey(ignore: true)
  @override
  _$EventCopyWith<_Event> get copyWith =>
      __$EventCopyWithImpl<_Event>(this, _$identity);
}

abstract class _Event extends Event {
  const factory _Event(
      {@HiveField(0) required String id,
      @HiveField(1) required String title,
      @HiveField(2) required DateTime created,
      @HiveField(3) required DateTime modified,
      @HiveField(4) required String type,
      @HiveField(5) required DateTime startDate,
      @HiveField(6) required DateTime endDate,
      @HiveField(7) required bool allDay,
      @HiveField(8) List<dynamic>? guests,
      @HiveField(9) String? location,
      @HiveField(10) List<dynamic>? notifications,
      @HiveField(11) List<dynamic>? notificationsIDs}) = _$_Event;
  const _Event._() : super._();

  @override
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @override
  @HiveField(1)
  String get title => throw _privateConstructorUsedError;
  @override
  @HiveField(2)
  DateTime get created => throw _privateConstructorUsedError;
  @override
  @HiveField(3)
  DateTime get modified => throw _privateConstructorUsedError;
  @override
  @HiveField(4)
  String get type => throw _privateConstructorUsedError;
  @override
  @HiveField(5)
  DateTime get startDate => throw _privateConstructorUsedError;
  @override
  @HiveField(6)
  DateTime get endDate => throw _privateConstructorUsedError;
  @override
  @HiveField(7)
  bool get allDay => throw _privateConstructorUsedError;
  @override
  @HiveField(8)
  List<dynamic>? get guests => throw _privateConstructorUsedError;
  @override
  @HiveField(9)
  String? get location => throw _privateConstructorUsedError;
  @override
  @HiveField(10)
  List<dynamic>? get notifications => throw _privateConstructorUsedError;
  @override
  @HiveField(11)
  List<dynamic>? get notificationsIDs => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$EventCopyWith<_Event> get copyWith => throw _privateConstructorUsedError;
}

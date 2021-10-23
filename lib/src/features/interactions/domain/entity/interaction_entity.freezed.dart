// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'interaction_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$InteractionTearOff {
  const _$InteractionTearOff();

  _Interaction call(
      {required String id,
      required String description,
      required String contact,
      required String type,
      required DateTime created,
      String? event}) {
    return _Interaction(
      id: id,
      description: description,
      contact: contact,
      type: type,
      created: created,
      event: event,
    );
  }
}

/// @nodoc
const $Interaction = _$InteractionTearOff();

/// @nodoc
mixin _$Interaction {
  String get id => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get contact => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  DateTime get created => throw _privateConstructorUsedError;
  String? get event => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InteractionCopyWith<Interaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InteractionCopyWith<$Res> {
  factory $InteractionCopyWith(
          Interaction value, $Res Function(Interaction) then) =
      _$InteractionCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String description,
      String contact,
      String type,
      DateTime created,
      String? event});
}

/// @nodoc
class _$InteractionCopyWithImpl<$Res> implements $InteractionCopyWith<$Res> {
  _$InteractionCopyWithImpl(this._value, this._then);

  final Interaction _value;
  // ignore: unused_field
  final $Res Function(Interaction) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? description = freezed,
    Object? contact = freezed,
    Object? type = freezed,
    Object? created = freezed,
    Object? event = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      contact: contact == freezed
          ? _value.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      created: created == freezed
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
      event: event == freezed
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$InteractionCopyWith<$Res>
    implements $InteractionCopyWith<$Res> {
  factory _$InteractionCopyWith(
          _Interaction value, $Res Function(_Interaction) then) =
      __$InteractionCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String description,
      String contact,
      String type,
      DateTime created,
      String? event});
}

/// @nodoc
class __$InteractionCopyWithImpl<$Res> extends _$InteractionCopyWithImpl<$Res>
    implements _$InteractionCopyWith<$Res> {
  __$InteractionCopyWithImpl(
      _Interaction _value, $Res Function(_Interaction) _then)
      : super(_value, (v) => _then(v as _Interaction));

  @override
  _Interaction get _value => super._value as _Interaction;

  @override
  $Res call({
    Object? id = freezed,
    Object? description = freezed,
    Object? contact = freezed,
    Object? type = freezed,
    Object? created = freezed,
    Object? event = freezed,
  }) {
    return _then(_Interaction(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      contact: contact == freezed
          ? _value.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      created: created == freezed
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
      event: event == freezed
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_Interaction extends _Interaction {
  const _$_Interaction(
      {required this.id,
      required this.description,
      required this.contact,
      required this.type,
      required this.created,
      this.event})
      : super._();

  @override
  final String id;
  @override
  final String description;
  @override
  final String contact;
  @override
  final String type;
  @override
  final DateTime created;
  @override
  final String? event;

  @override
  String toString() {
    return 'Interaction(id: $id, description: $description, contact: $contact, type: $type, created: $created, event: $event)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Interaction &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.contact, contact) ||
                const DeepCollectionEquality()
                    .equals(other.contact, contact)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.created, created) ||
                const DeepCollectionEquality()
                    .equals(other.created, created)) &&
            (identical(other.event, event) ||
                const DeepCollectionEquality().equals(other.event, event)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(contact) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(created) ^
      const DeepCollectionEquality().hash(event);

  @JsonKey(ignore: true)
  @override
  _$InteractionCopyWith<_Interaction> get copyWith =>
      __$InteractionCopyWithImpl<_Interaction>(this, _$identity);
}

abstract class _Interaction extends Interaction {
  const factory _Interaction(
      {required String id,
      required String description,
      required String contact,
      required String type,
      required DateTime created,
      String? event}) = _$_Interaction;
  const _Interaction._() : super._();

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  String get description => throw _privateConstructorUsedError;
  @override
  String get contact => throw _privateConstructorUsedError;
  @override
  String get type => throw _privateConstructorUsedError;
  @override
  DateTime get created => throw _privateConstructorUsedError;
  @override
  String? get event => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$InteractionCopyWith<_Interaction> get copyWith =>
      throw _privateConstructorUsedError;
}

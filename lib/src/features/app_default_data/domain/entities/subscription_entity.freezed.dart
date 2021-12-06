// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'subscription_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$SubscriptionTearOff {
  const _$SubscriptionTearOff();

  _Subscription call(
      {@HiveField(0) required String key,
      @HiveField(1) required String id,
      @HiveField(2) required DateTime created}) {
    return _Subscription(
      key: key,
      id: id,
      created: created,
    );
  }
}

/// @nodoc
const $Subscription = _$SubscriptionTearOff();

/// @nodoc
mixin _$Subscription {
  @HiveField(0)
  String get key => throw _privateConstructorUsedError;
  @HiveField(1)
  String get id => throw _privateConstructorUsedError;
  @HiveField(2)
  DateTime get created => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SubscriptionCopyWith<Subscription> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionCopyWith<$Res> {
  factory $SubscriptionCopyWith(
          Subscription value, $Res Function(Subscription) then) =
      _$SubscriptionCopyWithImpl<$Res>;
  $Res call(
      {@HiveField(0) String key,
      @HiveField(1) String id,
      @HiveField(2) DateTime created});
}

/// @nodoc
class _$SubscriptionCopyWithImpl<$Res> implements $SubscriptionCopyWith<$Res> {
  _$SubscriptionCopyWithImpl(this._value, this._then);

  final Subscription _value;
  // ignore: unused_field
  final $Res Function(Subscription) _then;

  @override
  $Res call({
    Object? key = freezed,
    Object? id = freezed,
    Object? created = freezed,
  }) {
    return _then(_value.copyWith(
      key: key == freezed
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      created: created == freezed
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
abstract class _$SubscriptionCopyWith<$Res>
    implements $SubscriptionCopyWith<$Res> {
  factory _$SubscriptionCopyWith(
          _Subscription value, $Res Function(_Subscription) then) =
      __$SubscriptionCopyWithImpl<$Res>;
  @override
  $Res call(
      {@HiveField(0) String key,
      @HiveField(1) String id,
      @HiveField(2) DateTime created});
}

/// @nodoc
class __$SubscriptionCopyWithImpl<$Res> extends _$SubscriptionCopyWithImpl<$Res>
    implements _$SubscriptionCopyWith<$Res> {
  __$SubscriptionCopyWithImpl(
      _Subscription _value, $Res Function(_Subscription) _then)
      : super(_value, (v) => _then(v as _Subscription));

  @override
  _Subscription get _value => super._value as _Subscription;

  @override
  $Res call({
    Object? key = freezed,
    Object? id = freezed,
    Object? created = freezed,
  }) {
    return _then(_Subscription(
      key: key == freezed
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      created: created == freezed
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

@HiveType(typeId: 1)
class _$_Subscription extends _Subscription {
  const _$_Subscription(
      {@HiveField(0) required this.key,
      @HiveField(1) required this.id,
      @HiveField(2) required this.created})
      : super._();

  @override
  @HiveField(0)
  final String key;
  @override
  @HiveField(1)
  final String id;
  @override
  @HiveField(2)
  final DateTime created;

  @override
  String toString() {
    return 'Subscription(key: $key, id: $id, created: $created)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Subscription &&
            (identical(other.key, key) ||
                const DeepCollectionEquality().equals(other.key, key)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.created, created) ||
                const DeepCollectionEquality().equals(other.created, created)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(key) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(created);

  @JsonKey(ignore: true)
  @override
  _$SubscriptionCopyWith<_Subscription> get copyWith =>
      __$SubscriptionCopyWithImpl<_Subscription>(this, _$identity);
}

abstract class _Subscription extends Subscription {
  const factory _Subscription(
      {@HiveField(0) required String key,
      @HiveField(1) required String id,
      @HiveField(2) required DateTime created}) = _$_Subscription;
  const _Subscription._() : super._();

  @override
  @HiveField(0)
  String get key => throw _privateConstructorUsedError;
  @override
  @HiveField(1)
  String get id => throw _privateConstructorUsedError;
  @override
  @HiveField(2)
  DateTime get created => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$SubscriptionCopyWith<_Subscription> get copyWith =>
      throw _privateConstructorUsedError;
}

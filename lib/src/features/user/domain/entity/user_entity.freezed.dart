// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'user_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$UserEntityTearOff {
  const _$UserEntityTearOff();

  _UserEntity call(
      {@HiveField(0) required String uid,
      @HiveField(1) required String name,
      @HiveField(2) required String subscription,
      @HiveField(3) required DateTime expiryDate,
      @HiveField(4) required DateTime created,
      @HiveField(5) required DateTime modified,
      @HiveField(6) String? email,
      @HiveField(7) String? photoURL,
      @HiveField(8) String? subscriptionSKU,
      @HiveField(9) String? countryCode,
      @HiveField(10) String? dialCode}) {
    return _UserEntity(
      uid: uid,
      name: name,
      subscription: subscription,
      expiryDate: expiryDate,
      created: created,
      modified: modified,
      email: email,
      photoURL: photoURL,
      subscriptionSKU: subscriptionSKU,
      countryCode: countryCode,
      dialCode: dialCode,
    );
  }
}

/// @nodoc
const $UserEntity = _$UserEntityTearOff();

/// @nodoc
mixin _$UserEntity {
  @HiveField(0)
  String get uid => throw _privateConstructorUsedError;
  @HiveField(1)
  String get name => throw _privateConstructorUsedError;
  @HiveField(2)
  String get subscription => throw _privateConstructorUsedError;
  @HiveField(3)
  DateTime get expiryDate => throw _privateConstructorUsedError;
  @HiveField(4)
  DateTime get created => throw _privateConstructorUsedError;
  @HiveField(5)
  DateTime get modified => throw _privateConstructorUsedError;
  @HiveField(6)
  String? get email => throw _privateConstructorUsedError;
  @HiveField(7)
  String? get photoURL => throw _privateConstructorUsedError;
  @HiveField(8)
  String? get subscriptionSKU => throw _privateConstructorUsedError;
  @HiveField(9)
  String? get countryCode => throw _privateConstructorUsedError;
  @HiveField(10)
  String? get dialCode => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserEntityCopyWith<UserEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserEntityCopyWith<$Res> {
  factory $UserEntityCopyWith(
          UserEntity value, $Res Function(UserEntity) then) =
      _$UserEntityCopyWithImpl<$Res>;
  $Res call(
      {@HiveField(0) String uid,
      @HiveField(1) String name,
      @HiveField(2) String subscription,
      @HiveField(3) DateTime expiryDate,
      @HiveField(4) DateTime created,
      @HiveField(5) DateTime modified,
      @HiveField(6) String? email,
      @HiveField(7) String? photoURL,
      @HiveField(8) String? subscriptionSKU,
      @HiveField(9) String? countryCode,
      @HiveField(10) String? dialCode});
}

/// @nodoc
class _$UserEntityCopyWithImpl<$Res> implements $UserEntityCopyWith<$Res> {
  _$UserEntityCopyWithImpl(this._value, this._then);

  final UserEntity _value;
  // ignore: unused_field
  final $Res Function(UserEntity) _then;

  @override
  $Res call({
    Object? uid = freezed,
    Object? name = freezed,
    Object? subscription = freezed,
    Object? expiryDate = freezed,
    Object? created = freezed,
    Object? modified = freezed,
    Object? email = freezed,
    Object? photoURL = freezed,
    Object? subscriptionSKU = freezed,
    Object? countryCode = freezed,
    Object? dialCode = freezed,
  }) {
    return _then(_value.copyWith(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      subscription: subscription == freezed
          ? _value.subscription
          : subscription // ignore: cast_nullable_to_non_nullable
              as String,
      expiryDate: expiryDate == freezed
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      created: created == freezed
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
      modified: modified == freezed
          ? _value.modified
          : modified // ignore: cast_nullable_to_non_nullable
              as DateTime,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      photoURL: photoURL == freezed
          ? _value.photoURL
          : photoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      subscriptionSKU: subscriptionSKU == freezed
          ? _value.subscriptionSKU
          : subscriptionSKU // ignore: cast_nullable_to_non_nullable
              as String?,
      countryCode: countryCode == freezed
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String?,
      dialCode: dialCode == freezed
          ? _value.dialCode
          : dialCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$UserEntityCopyWith<$Res> implements $UserEntityCopyWith<$Res> {
  factory _$UserEntityCopyWith(
          _UserEntity value, $Res Function(_UserEntity) then) =
      __$UserEntityCopyWithImpl<$Res>;
  @override
  $Res call(
      {@HiveField(0) String uid,
      @HiveField(1) String name,
      @HiveField(2) String subscription,
      @HiveField(3) DateTime expiryDate,
      @HiveField(4) DateTime created,
      @HiveField(5) DateTime modified,
      @HiveField(6) String? email,
      @HiveField(7) String? photoURL,
      @HiveField(8) String? subscriptionSKU,
      @HiveField(9) String? countryCode,
      @HiveField(10) String? dialCode});
}

/// @nodoc
class __$UserEntityCopyWithImpl<$Res> extends _$UserEntityCopyWithImpl<$Res>
    implements _$UserEntityCopyWith<$Res> {
  __$UserEntityCopyWithImpl(
      _UserEntity _value, $Res Function(_UserEntity) _then)
      : super(_value, (v) => _then(v as _UserEntity));

  @override
  _UserEntity get _value => super._value as _UserEntity;

  @override
  $Res call({
    Object? uid = freezed,
    Object? name = freezed,
    Object? subscription = freezed,
    Object? expiryDate = freezed,
    Object? created = freezed,
    Object? modified = freezed,
    Object? email = freezed,
    Object? photoURL = freezed,
    Object? subscriptionSKU = freezed,
    Object? countryCode = freezed,
    Object? dialCode = freezed,
  }) {
    return _then(_UserEntity(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      subscription: subscription == freezed
          ? _value.subscription
          : subscription // ignore: cast_nullable_to_non_nullable
              as String,
      expiryDate: expiryDate == freezed
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      created: created == freezed
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
      modified: modified == freezed
          ? _value.modified
          : modified // ignore: cast_nullable_to_non_nullable
              as DateTime,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      photoURL: photoURL == freezed
          ? _value.photoURL
          : photoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      subscriptionSKU: subscriptionSKU == freezed
          ? _value.subscriptionSKU
          : subscriptionSKU // ignore: cast_nullable_to_non_nullable
              as String?,
      countryCode: countryCode == freezed
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String?,
      dialCode: dialCode == freezed
          ? _value.dialCode
          : dialCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@HiveType(typeId: 2)
class _$_UserEntity extends _UserEntity {
  const _$_UserEntity(
      {@HiveField(0) required this.uid,
      @HiveField(1) required this.name,
      @HiveField(2) required this.subscription,
      @HiveField(3) required this.expiryDate,
      @HiveField(4) required this.created,
      @HiveField(5) required this.modified,
      @HiveField(6) this.email,
      @HiveField(7) this.photoURL,
      @HiveField(8) this.subscriptionSKU,
      @HiveField(9) this.countryCode,
      @HiveField(10) this.dialCode})
      : super._();

  @override
  @HiveField(0)
  final String uid;
  @override
  @HiveField(1)
  final String name;
  @override
  @HiveField(2)
  final String subscription;
  @override
  @HiveField(3)
  final DateTime expiryDate;
  @override
  @HiveField(4)
  final DateTime created;
  @override
  @HiveField(5)
  final DateTime modified;
  @override
  @HiveField(6)
  final String? email;
  @override
  @HiveField(7)
  final String? photoURL;
  @override
  @HiveField(8)
  final String? subscriptionSKU;
  @override
  @HiveField(9)
  final String? countryCode;
  @override
  @HiveField(10)
  final String? dialCode;

  @override
  String toString() {
    return 'UserEntity(uid: $uid, name: $name, subscription: $subscription, expiryDate: $expiryDate, created: $created, modified: $modified, email: $email, photoURL: $photoURL, subscriptionSKU: $subscriptionSKU, countryCode: $countryCode, dialCode: $dialCode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _UserEntity &&
            (identical(other.uid, uid) ||
                const DeepCollectionEquality().equals(other.uid, uid)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.subscription, subscription) ||
                const DeepCollectionEquality()
                    .equals(other.subscription, subscription)) &&
            (identical(other.expiryDate, expiryDate) ||
                const DeepCollectionEquality()
                    .equals(other.expiryDate, expiryDate)) &&
            (identical(other.created, created) ||
                const DeepCollectionEquality()
                    .equals(other.created, created)) &&
            (identical(other.modified, modified) ||
                const DeepCollectionEquality()
                    .equals(other.modified, modified)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.photoURL, photoURL) ||
                const DeepCollectionEquality()
                    .equals(other.photoURL, photoURL)) &&
            (identical(other.subscriptionSKU, subscriptionSKU) ||
                const DeepCollectionEquality()
                    .equals(other.subscriptionSKU, subscriptionSKU)) &&
            (identical(other.countryCode, countryCode) ||
                const DeepCollectionEquality()
                    .equals(other.countryCode, countryCode)) &&
            (identical(other.dialCode, dialCode) ||
                const DeepCollectionEquality()
                    .equals(other.dialCode, dialCode)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(uid) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(subscription) ^
      const DeepCollectionEquality().hash(expiryDate) ^
      const DeepCollectionEquality().hash(created) ^
      const DeepCollectionEquality().hash(modified) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(photoURL) ^
      const DeepCollectionEquality().hash(subscriptionSKU) ^
      const DeepCollectionEquality().hash(countryCode) ^
      const DeepCollectionEquality().hash(dialCode);

  @JsonKey(ignore: true)
  @override
  _$UserEntityCopyWith<_UserEntity> get copyWith =>
      __$UserEntityCopyWithImpl<_UserEntity>(this, _$identity);
}

abstract class _UserEntity extends UserEntity {
  const factory _UserEntity(
      {@HiveField(0) required String uid,
      @HiveField(1) required String name,
      @HiveField(2) required String subscription,
      @HiveField(3) required DateTime expiryDate,
      @HiveField(4) required DateTime created,
      @HiveField(5) required DateTime modified,
      @HiveField(6) String? email,
      @HiveField(7) String? photoURL,
      @HiveField(8) String? subscriptionSKU,
      @HiveField(9) String? countryCode,
      @HiveField(10) String? dialCode}) = _$_UserEntity;
  const _UserEntity._() : super._();

  @override
  @HiveField(0)
  String get uid => throw _privateConstructorUsedError;
  @override
  @HiveField(1)
  String get name => throw _privateConstructorUsedError;
  @override
  @HiveField(2)
  String get subscription => throw _privateConstructorUsedError;
  @override
  @HiveField(3)
  DateTime get expiryDate => throw _privateConstructorUsedError;
  @override
  @HiveField(4)
  DateTime get created => throw _privateConstructorUsedError;
  @override
  @HiveField(5)
  DateTime get modified => throw _privateConstructorUsedError;
  @override
  @HiveField(6)
  String? get email => throw _privateConstructorUsedError;
  @override
  @HiveField(7)
  String? get photoURL => throw _privateConstructorUsedError;
  @override
  @HiveField(8)
  String? get subscriptionSKU => throw _privateConstructorUsedError;
  @override
  @HiveField(9)
  String? get countryCode => throw _privateConstructorUsedError;
  @override
  @HiveField(10)
  String? get dialCode => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$UserEntityCopyWith<_UserEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

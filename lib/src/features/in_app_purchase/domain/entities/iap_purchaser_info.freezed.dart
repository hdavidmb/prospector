// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'iap_purchaser_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$IAPPurchaserInfoTearOff {
  const _$IAPPurchaserInfoTearOff();

  _IAPPurchaserInfo call(
      {String? packageSKU,
      required bool isActive,
      required DateTime expiryDate}) {
    return _IAPPurchaserInfo(
      packageSKU: packageSKU,
      isActive: isActive,
      expiryDate: expiryDate,
    );
  }
}

/// @nodoc
const $IAPPurchaserInfo = _$IAPPurchaserInfoTearOff();

/// @nodoc
mixin _$IAPPurchaserInfo {
  String? get packageSKU => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime get expiryDate => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $IAPPurchaserInfoCopyWith<IAPPurchaserInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IAPPurchaserInfoCopyWith<$Res> {
  factory $IAPPurchaserInfoCopyWith(
          IAPPurchaserInfo value, $Res Function(IAPPurchaserInfo) then) =
      _$IAPPurchaserInfoCopyWithImpl<$Res>;
  $Res call({String? packageSKU, bool isActive, DateTime expiryDate});
}

/// @nodoc
class _$IAPPurchaserInfoCopyWithImpl<$Res>
    implements $IAPPurchaserInfoCopyWith<$Res> {
  _$IAPPurchaserInfoCopyWithImpl(this._value, this._then);

  final IAPPurchaserInfo _value;
  // ignore: unused_field
  final $Res Function(IAPPurchaserInfo) _then;

  @override
  $Res call({
    Object? packageSKU = freezed,
    Object? isActive = freezed,
    Object? expiryDate = freezed,
  }) {
    return _then(_value.copyWith(
      packageSKU: packageSKU == freezed
          ? _value.packageSKU
          : packageSKU // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: isActive == freezed
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      expiryDate: expiryDate == freezed
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
abstract class _$IAPPurchaserInfoCopyWith<$Res>
    implements $IAPPurchaserInfoCopyWith<$Res> {
  factory _$IAPPurchaserInfoCopyWith(
          _IAPPurchaserInfo value, $Res Function(_IAPPurchaserInfo) then) =
      __$IAPPurchaserInfoCopyWithImpl<$Res>;
  @override
  $Res call({String? packageSKU, bool isActive, DateTime expiryDate});
}

/// @nodoc
class __$IAPPurchaserInfoCopyWithImpl<$Res>
    extends _$IAPPurchaserInfoCopyWithImpl<$Res>
    implements _$IAPPurchaserInfoCopyWith<$Res> {
  __$IAPPurchaserInfoCopyWithImpl(
      _IAPPurchaserInfo _value, $Res Function(_IAPPurchaserInfo) _then)
      : super(_value, (v) => _then(v as _IAPPurchaserInfo));

  @override
  _IAPPurchaserInfo get _value => super._value as _IAPPurchaserInfo;

  @override
  $Res call({
    Object? packageSKU = freezed,
    Object? isActive = freezed,
    Object? expiryDate = freezed,
  }) {
    return _then(_IAPPurchaserInfo(
      packageSKU: packageSKU == freezed
          ? _value.packageSKU
          : packageSKU // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: isActive == freezed
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      expiryDate: expiryDate == freezed
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$_IAPPurchaserInfo extends _IAPPurchaserInfo {
  const _$_IAPPurchaserInfo(
      {this.packageSKU, required this.isActive, required this.expiryDate})
      : super._();

  @override
  final String? packageSKU;
  @override
  final bool isActive;
  @override
  final DateTime expiryDate;

  @override
  String toString() {
    return 'IAPPurchaserInfo(packageSKU: $packageSKU, isActive: $isActive, expiryDate: $expiryDate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _IAPPurchaserInfo &&
            (identical(other.packageSKU, packageSKU) ||
                const DeepCollectionEquality()
                    .equals(other.packageSKU, packageSKU)) &&
            (identical(other.isActive, isActive) ||
                const DeepCollectionEquality()
                    .equals(other.isActive, isActive)) &&
            (identical(other.expiryDate, expiryDate) ||
                const DeepCollectionEquality()
                    .equals(other.expiryDate, expiryDate)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(packageSKU) ^
      const DeepCollectionEquality().hash(isActive) ^
      const DeepCollectionEquality().hash(expiryDate);

  @JsonKey(ignore: true)
  @override
  _$IAPPurchaserInfoCopyWith<_IAPPurchaserInfo> get copyWith =>
      __$IAPPurchaserInfoCopyWithImpl<_IAPPurchaserInfo>(this, _$identity);
}

abstract class _IAPPurchaserInfo extends IAPPurchaserInfo {
  const factory _IAPPurchaserInfo(
      {String? packageSKU,
      required bool isActive,
      required DateTime expiryDate}) = _$_IAPPurchaserInfo;
  const _IAPPurchaserInfo._() : super._();

  @override
  String? get packageSKU => throw _privateConstructorUsedError;
  @override
  bool get isActive => throw _privateConstructorUsedError;
  @override
  DateTime get expiryDate => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$IAPPurchaserInfoCopyWith<_IAPPurchaserInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

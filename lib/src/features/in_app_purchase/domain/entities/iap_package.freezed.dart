// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'iap_package.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$IAPPackageTearOff {
  const _$IAPPackageTearOff();

  _IAPPackage call(
      {required IAPPackageType type,
      required double price,
      required String priceString,
      required String currencyCode,
      required String sku,
      required Package package}) {
    return _IAPPackage(
      type: type,
      price: price,
      priceString: priceString,
      currencyCode: currencyCode,
      sku: sku,
      package: package,
    );
  }
}

/// @nodoc
const $IAPPackage = _$IAPPackageTearOff();

/// @nodoc
mixin _$IAPPackage {
  IAPPackageType get type => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  String get priceString => throw _privateConstructorUsedError;
  String get currencyCode => throw _privateConstructorUsedError;
  String get sku => throw _privateConstructorUsedError;
  Package get package => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $IAPPackageCopyWith<IAPPackage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IAPPackageCopyWith<$Res> {
  factory $IAPPackageCopyWith(
          IAPPackage value, $Res Function(IAPPackage) then) =
      _$IAPPackageCopyWithImpl<$Res>;
  $Res call(
      {IAPPackageType type,
      double price,
      String priceString,
      String currencyCode,
      String sku,
      Package package});
}

/// @nodoc
class _$IAPPackageCopyWithImpl<$Res> implements $IAPPackageCopyWith<$Res> {
  _$IAPPackageCopyWithImpl(this._value, this._then);

  final IAPPackage _value;
  // ignore: unused_field
  final $Res Function(IAPPackage) _then;

  @override
  $Res call({
    Object? type = freezed,
    Object? price = freezed,
    Object? priceString = freezed,
    Object? currencyCode = freezed,
    Object? sku = freezed,
    Object? package = freezed,
  }) {
    return _then(_value.copyWith(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as IAPPackageType,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      priceString: priceString == freezed
          ? _value.priceString
          : priceString // ignore: cast_nullable_to_non_nullable
              as String,
      currencyCode: currencyCode == freezed
          ? _value.currencyCode
          : currencyCode // ignore: cast_nullable_to_non_nullable
              as String,
      sku: sku == freezed
          ? _value.sku
          : sku // ignore: cast_nullable_to_non_nullable
              as String,
      package: package == freezed
          ? _value.package
          : package // ignore: cast_nullable_to_non_nullable
              as Package,
    ));
  }
}

/// @nodoc
abstract class _$IAPPackageCopyWith<$Res> implements $IAPPackageCopyWith<$Res> {
  factory _$IAPPackageCopyWith(
          _IAPPackage value, $Res Function(_IAPPackage) then) =
      __$IAPPackageCopyWithImpl<$Res>;
  @override
  $Res call(
      {IAPPackageType type,
      double price,
      String priceString,
      String currencyCode,
      String sku,
      Package package});
}

/// @nodoc
class __$IAPPackageCopyWithImpl<$Res> extends _$IAPPackageCopyWithImpl<$Res>
    implements _$IAPPackageCopyWith<$Res> {
  __$IAPPackageCopyWithImpl(
      _IAPPackage _value, $Res Function(_IAPPackage) _then)
      : super(_value, (v) => _then(v as _IAPPackage));

  @override
  _IAPPackage get _value => super._value as _IAPPackage;

  @override
  $Res call({
    Object? type = freezed,
    Object? price = freezed,
    Object? priceString = freezed,
    Object? currencyCode = freezed,
    Object? sku = freezed,
    Object? package = freezed,
  }) {
    return _then(_IAPPackage(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as IAPPackageType,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      priceString: priceString == freezed
          ? _value.priceString
          : priceString // ignore: cast_nullable_to_non_nullable
              as String,
      currencyCode: currencyCode == freezed
          ? _value.currencyCode
          : currencyCode // ignore: cast_nullable_to_non_nullable
              as String,
      sku: sku == freezed
          ? _value.sku
          : sku // ignore: cast_nullable_to_non_nullable
              as String,
      package: package == freezed
          ? _value.package
          : package // ignore: cast_nullable_to_non_nullable
              as Package,
    ));
  }
}

/// @nodoc

class _$_IAPPackage extends _IAPPackage {
  const _$_IAPPackage(
      {required this.type,
      required this.price,
      required this.priceString,
      required this.currencyCode,
      required this.sku,
      required this.package})
      : super._();

  @override
  final IAPPackageType type;
  @override
  final double price;
  @override
  final String priceString;
  @override
  final String currencyCode;
  @override
  final String sku;
  @override
  final Package package;

  @override
  String toString() {
    return 'IAPPackage(type: $type, price: $price, priceString: $priceString, currencyCode: $currencyCode, sku: $sku, package: $package)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _IAPPackage &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.priceString, priceString) ||
                const DeepCollectionEquality()
                    .equals(other.priceString, priceString)) &&
            (identical(other.currencyCode, currencyCode) ||
                const DeepCollectionEquality()
                    .equals(other.currencyCode, currencyCode)) &&
            (identical(other.sku, sku) ||
                const DeepCollectionEquality().equals(other.sku, sku)) &&
            (identical(other.package, package) ||
                const DeepCollectionEquality().equals(other.package, package)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(priceString) ^
      const DeepCollectionEquality().hash(currencyCode) ^
      const DeepCollectionEquality().hash(sku) ^
      const DeepCollectionEquality().hash(package);

  @JsonKey(ignore: true)
  @override
  _$IAPPackageCopyWith<_IAPPackage> get copyWith =>
      __$IAPPackageCopyWithImpl<_IAPPackage>(this, _$identity);
}

abstract class _IAPPackage extends IAPPackage {
  const factory _IAPPackage(
      {required IAPPackageType type,
      required double price,
      required String priceString,
      required String currencyCode,
      required String sku,
      required Package package}) = _$_IAPPackage;
  const _IAPPackage._() : super._();

  @override
  IAPPackageType get type => throw _privateConstructorUsedError;
  @override
  double get price => throw _privateConstructorUsedError;
  @override
  String get priceString => throw _privateConstructorUsedError;
  @override
  String get currencyCode => throw _privateConstructorUsedError;
  @override
  String get sku => throw _privateConstructorUsedError;
  @override
  Package get package => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$IAPPackageCopyWith<_IAPPackage> get copyWith =>
      throw _privateConstructorUsedError;
}

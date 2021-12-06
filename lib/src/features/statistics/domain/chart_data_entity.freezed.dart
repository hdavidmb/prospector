// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'chart_data_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ChartDataTearOff {
  const _$ChartDataTearOff();

  _ChartData call(
      {required dynamic label, required int value, required Color color}) {
    return _ChartData(
      label: label,
      value: value,
      color: color,
    );
  }
}

/// @nodoc
const $ChartData = _$ChartDataTearOff();

/// @nodoc
mixin _$ChartData {
  dynamic get label => throw _privateConstructorUsedError;
  int get value => throw _privateConstructorUsedError;
  Color get color => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChartDataCopyWith<ChartData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChartDataCopyWith<$Res> {
  factory $ChartDataCopyWith(ChartData value, $Res Function(ChartData) then) =
      _$ChartDataCopyWithImpl<$Res>;
  $Res call({dynamic label, int value, Color color});
}

/// @nodoc
class _$ChartDataCopyWithImpl<$Res> implements $ChartDataCopyWith<$Res> {
  _$ChartDataCopyWithImpl(this._value, this._then);

  final ChartData _value;
  // ignore: unused_field
  final $Res Function(ChartData) _then;

  @override
  $Res call({
    Object? label = freezed,
    Object? value = freezed,
    Object? color = freezed,
  }) {
    return _then(_value.copyWith(
      label: label == freezed
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as dynamic,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
    ));
  }
}

/// @nodoc
abstract class _$ChartDataCopyWith<$Res> implements $ChartDataCopyWith<$Res> {
  factory _$ChartDataCopyWith(
          _ChartData value, $Res Function(_ChartData) then) =
      __$ChartDataCopyWithImpl<$Res>;
  @override
  $Res call({dynamic label, int value, Color color});
}

/// @nodoc
class __$ChartDataCopyWithImpl<$Res> extends _$ChartDataCopyWithImpl<$Res>
    implements _$ChartDataCopyWith<$Res> {
  __$ChartDataCopyWithImpl(_ChartData _value, $Res Function(_ChartData) _then)
      : super(_value, (v) => _then(v as _ChartData));

  @override
  _ChartData get _value => super._value as _ChartData;

  @override
  $Res call({
    Object? label = freezed,
    Object? value = freezed,
    Object? color = freezed,
  }) {
    return _then(_ChartData(
      label: label == freezed
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as dynamic,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
    ));
  }
}

/// @nodoc

class _$_ChartData extends _ChartData {
  const _$_ChartData(
      {required this.label, required this.value, required this.color})
      : super._();

  @override
  final dynamic label;
  @override
  final int value;
  @override
  final Color color;

  @override
  String toString() {
    return 'ChartData(label: $label, value: $value, color: $color)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ChartData &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)) &&
            (identical(other.color, color) ||
                const DeepCollectionEquality().equals(other.color, color)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(value) ^
      const DeepCollectionEquality().hash(color);

  @JsonKey(ignore: true)
  @override
  _$ChartDataCopyWith<_ChartData> get copyWith =>
      __$ChartDataCopyWithImpl<_ChartData>(this, _$identity);
}

abstract class _ChartData extends ChartData {
  const factory _ChartData(
      {required dynamic label,
      required int value,
      required Color color}) = _$_ChartData;
  const _ChartData._() : super._();

  @override
  dynamic get label => throw _privateConstructorUsedError;
  @override
  int get value => throw _privateConstructorUsedError;
  @override
  Color get color => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ChartDataCopyWith<_ChartData> get copyWith =>
      throw _privateConstructorUsedError;
}

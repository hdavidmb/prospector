// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'app_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$AppStateTearOff {
  const _$AppStateTearOff();

  Initial initial() {
    return const Initial();
  }

  UnathenticatedReady unauthenticatedReady() {
    return const UnathenticatedReady();
  }

  AthenticatedReady authenticatedReady() {
    return const AthenticatedReady();
  }
}

/// @nodoc
const $AppState = _$AppStateTearOff();

/// @nodoc
mixin _$AppState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() unauthenticatedReady,
    required TResult Function() authenticatedReady,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? unauthenticatedReady,
    TResult Function()? authenticatedReady,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(UnathenticatedReady value) unauthenticatedReady,
    required TResult Function(AthenticatedReady value) authenticatedReady,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(UnathenticatedReady value)? unauthenticatedReady,
    TResult Function(AthenticatedReady value)? authenticatedReady,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppStateCopyWith<$Res> {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) then) =
      _$AppStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$AppStateCopyWithImpl<$Res> implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._value, this._then);

  final AppState _value;
  // ignore: unused_field
  final $Res Function(AppState) _then;
}

/// @nodoc
abstract class $InitialCopyWith<$Res> {
  factory $InitialCopyWith(Initial value, $Res Function(Initial) then) =
      _$InitialCopyWithImpl<$Res>;
}

/// @nodoc
class _$InitialCopyWithImpl<$Res> extends _$AppStateCopyWithImpl<$Res>
    implements $InitialCopyWith<$Res> {
  _$InitialCopyWithImpl(Initial _value, $Res Function(Initial) _then)
      : super(_value, (v) => _then(v as Initial));

  @override
  Initial get _value => super._value as Initial;
}

/// @nodoc
class _$Initial implements Initial {
  const _$Initial();

  @override
  String toString() {
    return 'AppState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() unauthenticatedReady,
    required TResult Function() authenticatedReady,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? unauthenticatedReady,
    TResult Function()? authenticatedReady,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(UnathenticatedReady value) unauthenticatedReady,
    required TResult Function(AthenticatedReady value) authenticatedReady,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(UnathenticatedReady value)? unauthenticatedReady,
    TResult Function(AthenticatedReady value)? authenticatedReady,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class Initial implements AppState {
  const factory Initial() = _$Initial;
}

/// @nodoc
abstract class $UnathenticatedReadyCopyWith<$Res> {
  factory $UnathenticatedReadyCopyWith(
          UnathenticatedReady value, $Res Function(UnathenticatedReady) then) =
      _$UnathenticatedReadyCopyWithImpl<$Res>;
}

/// @nodoc
class _$UnathenticatedReadyCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res>
    implements $UnathenticatedReadyCopyWith<$Res> {
  _$UnathenticatedReadyCopyWithImpl(
      UnathenticatedReady _value, $Res Function(UnathenticatedReady) _then)
      : super(_value, (v) => _then(v as UnathenticatedReady));

  @override
  UnathenticatedReady get _value => super._value as UnathenticatedReady;
}

/// @nodoc
class _$UnathenticatedReady implements UnathenticatedReady {
  const _$UnathenticatedReady();

  @override
  String toString() {
    return 'AppState.unauthenticatedReady()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is UnathenticatedReady);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() unauthenticatedReady,
    required TResult Function() authenticatedReady,
  }) {
    return unauthenticatedReady();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? unauthenticatedReady,
    TResult Function()? authenticatedReady,
    required TResult orElse(),
  }) {
    if (unauthenticatedReady != null) {
      return unauthenticatedReady();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(UnathenticatedReady value) unauthenticatedReady,
    required TResult Function(AthenticatedReady value) authenticatedReady,
  }) {
    return unauthenticatedReady(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(UnathenticatedReady value)? unauthenticatedReady,
    TResult Function(AthenticatedReady value)? authenticatedReady,
    required TResult orElse(),
  }) {
    if (unauthenticatedReady != null) {
      return unauthenticatedReady(this);
    }
    return orElse();
  }
}

abstract class UnathenticatedReady implements AppState {
  const factory UnathenticatedReady() = _$UnathenticatedReady;
}

/// @nodoc
abstract class $AthenticatedReadyCopyWith<$Res> {
  factory $AthenticatedReadyCopyWith(
          AthenticatedReady value, $Res Function(AthenticatedReady) then) =
      _$AthenticatedReadyCopyWithImpl<$Res>;
}

/// @nodoc
class _$AthenticatedReadyCopyWithImpl<$Res> extends _$AppStateCopyWithImpl<$Res>
    implements $AthenticatedReadyCopyWith<$Res> {
  _$AthenticatedReadyCopyWithImpl(
      AthenticatedReady _value, $Res Function(AthenticatedReady) _then)
      : super(_value, (v) => _then(v as AthenticatedReady));

  @override
  AthenticatedReady get _value => super._value as AthenticatedReady;
}

/// @nodoc
class _$AthenticatedReady implements AthenticatedReady {
  const _$AthenticatedReady();

  @override
  String toString() {
    return 'AppState.authenticatedReady()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is AthenticatedReady);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() unauthenticatedReady,
    required TResult Function() authenticatedReady,
  }) {
    return authenticatedReady();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? unauthenticatedReady,
    TResult Function()? authenticatedReady,
    required TResult orElse(),
  }) {
    if (authenticatedReady != null) {
      return authenticatedReady();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(UnathenticatedReady value) unauthenticatedReady,
    required TResult Function(AthenticatedReady value) authenticatedReady,
  }) {
    return authenticatedReady(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(UnathenticatedReady value)? unauthenticatedReady,
    TResult Function(AthenticatedReady value)? authenticatedReady,
    required TResult orElse(),
  }) {
    if (authenticatedReady != null) {
      return authenticatedReady(this);
    }
    return orElse();
  }
}

abstract class AthenticatedReady implements AppState {
  const factory AthenticatedReady() = _$AthenticatedReady;
}

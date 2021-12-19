// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user_profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$UserProfileStateTearOff {
  const _$UserProfileStateTearOff();

  Initial initial() {
    return const Initial();
  }

  Submitting submitting() {
    return const Submitting();
  }

  Error error(UserInfoFailure failure) {
    return Error(
      failure,
    );
  }

  ReloginError reloginError(AuthFailure failure) {
    return ReloginError(
      failure,
    );
  }
}

/// @nodoc
const $UserProfileState = _$UserProfileStateTearOff();

/// @nodoc
mixin _$UserProfileState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() submitting,
    required TResult Function(UserInfoFailure failure) error,
    required TResult Function(AuthFailure failure) reloginError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? submitting,
    TResult Function(UserInfoFailure failure)? error,
    TResult Function(AuthFailure failure)? reloginError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? submitting,
    TResult Function(UserInfoFailure failure)? error,
    TResult Function(AuthFailure failure)? reloginError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Submitting value) submitting,
    required TResult Function(Error value) error,
    required TResult Function(ReloginError value) reloginError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Submitting value)? submitting,
    TResult Function(Error value)? error,
    TResult Function(ReloginError value)? reloginError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Submitting value)? submitting,
    TResult Function(Error value)? error,
    TResult Function(ReloginError value)? reloginError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileStateCopyWith<$Res> {
  factory $UserProfileStateCopyWith(
          UserProfileState value, $Res Function(UserProfileState) then) =
      _$UserProfileStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$UserProfileStateCopyWithImpl<$Res>
    implements $UserProfileStateCopyWith<$Res> {
  _$UserProfileStateCopyWithImpl(this._value, this._then);

  final UserProfileState _value;
  // ignore: unused_field
  final $Res Function(UserProfileState) _then;
}

/// @nodoc
abstract class $InitialCopyWith<$Res> {
  factory $InitialCopyWith(Initial value, $Res Function(Initial) then) =
      _$InitialCopyWithImpl<$Res>;
}

/// @nodoc
class _$InitialCopyWithImpl<$Res> extends _$UserProfileStateCopyWithImpl<$Res>
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
    return 'UserProfileState.initial()';
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
    required TResult Function() submitting,
    required TResult Function(UserInfoFailure failure) error,
    required TResult Function(AuthFailure failure) reloginError,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? submitting,
    TResult Function(UserInfoFailure failure)? error,
    TResult Function(AuthFailure failure)? reloginError,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? submitting,
    TResult Function(UserInfoFailure failure)? error,
    TResult Function(AuthFailure failure)? reloginError,
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
    required TResult Function(Submitting value) submitting,
    required TResult Function(Error value) error,
    required TResult Function(ReloginError value) reloginError,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Submitting value)? submitting,
    TResult Function(Error value)? error,
    TResult Function(ReloginError value)? reloginError,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Submitting value)? submitting,
    TResult Function(Error value)? error,
    TResult Function(ReloginError value)? reloginError,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class Initial implements UserProfileState {
  const factory Initial() = _$Initial;
}

/// @nodoc
abstract class $SubmittingCopyWith<$Res> {
  factory $SubmittingCopyWith(
          Submitting value, $Res Function(Submitting) then) =
      _$SubmittingCopyWithImpl<$Res>;
}

/// @nodoc
class _$SubmittingCopyWithImpl<$Res>
    extends _$UserProfileStateCopyWithImpl<$Res>
    implements $SubmittingCopyWith<$Res> {
  _$SubmittingCopyWithImpl(Submitting _value, $Res Function(Submitting) _then)
      : super(_value, (v) => _then(v as Submitting));

  @override
  Submitting get _value => super._value as Submitting;
}

/// @nodoc

class _$Submitting implements Submitting {
  const _$Submitting();

  @override
  String toString() {
    return 'UserProfileState.submitting()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Submitting);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() submitting,
    required TResult Function(UserInfoFailure failure) error,
    required TResult Function(AuthFailure failure) reloginError,
  }) {
    return submitting();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? submitting,
    TResult Function(UserInfoFailure failure)? error,
    TResult Function(AuthFailure failure)? reloginError,
  }) {
    return submitting?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? submitting,
    TResult Function(UserInfoFailure failure)? error,
    TResult Function(AuthFailure failure)? reloginError,
    required TResult orElse(),
  }) {
    if (submitting != null) {
      return submitting();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Submitting value) submitting,
    required TResult Function(Error value) error,
    required TResult Function(ReloginError value) reloginError,
  }) {
    return submitting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Submitting value)? submitting,
    TResult Function(Error value)? error,
    TResult Function(ReloginError value)? reloginError,
  }) {
    return submitting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Submitting value)? submitting,
    TResult Function(Error value)? error,
    TResult Function(ReloginError value)? reloginError,
    required TResult orElse(),
  }) {
    if (submitting != null) {
      return submitting(this);
    }
    return orElse();
  }
}

abstract class Submitting implements UserProfileState {
  const factory Submitting() = _$Submitting;
}

/// @nodoc
abstract class $ErrorCopyWith<$Res> {
  factory $ErrorCopyWith(Error value, $Res Function(Error) then) =
      _$ErrorCopyWithImpl<$Res>;
  $Res call({UserInfoFailure failure});

  $UserInfoFailureCopyWith<$Res> get failure;
}

/// @nodoc
class _$ErrorCopyWithImpl<$Res> extends _$UserProfileStateCopyWithImpl<$Res>
    implements $ErrorCopyWith<$Res> {
  _$ErrorCopyWithImpl(Error _value, $Res Function(Error) _then)
      : super(_value, (v) => _then(v as Error));

  @override
  Error get _value => super._value as Error;

  @override
  $Res call({
    Object? failure = freezed,
  }) {
    return _then(Error(
      failure == freezed
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as UserInfoFailure,
    ));
  }

  @override
  $UserInfoFailureCopyWith<$Res> get failure {
    return $UserInfoFailureCopyWith<$Res>(_value.failure, (value) {
      return _then(_value.copyWith(failure: value));
    });
  }
}

/// @nodoc

class _$Error implements Error {
  const _$Error(this.failure);

  @override
  final UserInfoFailure failure;

  @override
  String toString() {
    return 'UserProfileState.error(failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Error &&
            (identical(other.failure, failure) ||
                const DeepCollectionEquality().equals(other.failure, failure)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(failure);

  @JsonKey(ignore: true)
  @override
  $ErrorCopyWith<Error> get copyWith =>
      _$ErrorCopyWithImpl<Error>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() submitting,
    required TResult Function(UserInfoFailure failure) error,
    required TResult Function(AuthFailure failure) reloginError,
  }) {
    return error(failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? submitting,
    TResult Function(UserInfoFailure failure)? error,
    TResult Function(AuthFailure failure)? reloginError,
  }) {
    return error?.call(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? submitting,
    TResult Function(UserInfoFailure failure)? error,
    TResult Function(AuthFailure failure)? reloginError,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Submitting value) submitting,
    required TResult Function(Error value) error,
    required TResult Function(ReloginError value) reloginError,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Submitting value)? submitting,
    TResult Function(Error value)? error,
    TResult Function(ReloginError value)? reloginError,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Submitting value)? submitting,
    TResult Function(Error value)? error,
    TResult Function(ReloginError value)? reloginError,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class Error implements UserProfileState {
  const factory Error(UserInfoFailure failure) = _$Error;

  UserInfoFailure get failure => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ErrorCopyWith<Error> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReloginErrorCopyWith<$Res> {
  factory $ReloginErrorCopyWith(
          ReloginError value, $Res Function(ReloginError) then) =
      _$ReloginErrorCopyWithImpl<$Res>;
  $Res call({AuthFailure failure});

  $AuthFailureCopyWith<$Res> get failure;
}

/// @nodoc
class _$ReloginErrorCopyWithImpl<$Res>
    extends _$UserProfileStateCopyWithImpl<$Res>
    implements $ReloginErrorCopyWith<$Res> {
  _$ReloginErrorCopyWithImpl(
      ReloginError _value, $Res Function(ReloginError) _then)
      : super(_value, (v) => _then(v as ReloginError));

  @override
  ReloginError get _value => super._value as ReloginError;

  @override
  $Res call({
    Object? failure = freezed,
  }) {
    return _then(ReloginError(
      failure == freezed
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as AuthFailure,
    ));
  }

  @override
  $AuthFailureCopyWith<$Res> get failure {
    return $AuthFailureCopyWith<$Res>(_value.failure, (value) {
      return _then(_value.copyWith(failure: value));
    });
  }
}

/// @nodoc

class _$ReloginError implements ReloginError {
  const _$ReloginError(this.failure);

  @override
  final AuthFailure failure;

  @override
  String toString() {
    return 'UserProfileState.reloginError(failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ReloginError &&
            (identical(other.failure, failure) ||
                const DeepCollectionEquality().equals(other.failure, failure)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(failure);

  @JsonKey(ignore: true)
  @override
  $ReloginErrorCopyWith<ReloginError> get copyWith =>
      _$ReloginErrorCopyWithImpl<ReloginError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() submitting,
    required TResult Function(UserInfoFailure failure) error,
    required TResult Function(AuthFailure failure) reloginError,
  }) {
    return reloginError(failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? submitting,
    TResult Function(UserInfoFailure failure)? error,
    TResult Function(AuthFailure failure)? reloginError,
  }) {
    return reloginError?.call(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? submitting,
    TResult Function(UserInfoFailure failure)? error,
    TResult Function(AuthFailure failure)? reloginError,
    required TResult orElse(),
  }) {
    if (reloginError != null) {
      return reloginError(failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Submitting value) submitting,
    required TResult Function(Error value) error,
    required TResult Function(ReloginError value) reloginError,
  }) {
    return reloginError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Submitting value)? submitting,
    TResult Function(Error value)? error,
    TResult Function(ReloginError value)? reloginError,
  }) {
    return reloginError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Submitting value)? submitting,
    TResult Function(Error value)? error,
    TResult Function(ReloginError value)? reloginError,
    required TResult orElse(),
  }) {
    if (reloginError != null) {
      return reloginError(this);
    }
    return orElse();
  }
}

abstract class ReloginError implements UserProfileState {
  const factory ReloginError(AuthFailure failure) = _$ReloginError;

  AuthFailure get failure => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReloginErrorCopyWith<ReloginError> get copyWith =>
      throw _privateConstructorUsedError;
}

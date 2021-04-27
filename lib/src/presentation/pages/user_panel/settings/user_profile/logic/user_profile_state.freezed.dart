// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

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

  ErrorAuth errorAuth(AuthFailure failure) {
    return ErrorAuth(
      failure,
    );
  }

  ErrorDatabase errorDatabase(DatabaseFailure failure) {
    return ErrorDatabase(
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
    required TResult Function(AuthFailure failure) errorAuth,
    required TResult Function(DatabaseFailure failure) errorDatabase,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? submitting,
    TResult Function(AuthFailure failure)? errorAuth,
    TResult Function(DatabaseFailure failure)? errorDatabase,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Submitting value) submitting,
    required TResult Function(ErrorAuth value) errorAuth,
    required TResult Function(ErrorDatabase value) errorDatabase,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Submitting value)? submitting,
    TResult Function(ErrorAuth value)? errorAuth,
    TResult Function(ErrorDatabase value)? errorDatabase,
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
    required TResult Function(AuthFailure failure) errorAuth,
    required TResult Function(DatabaseFailure failure) errorDatabase,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? submitting,
    TResult Function(AuthFailure failure)? errorAuth,
    TResult Function(DatabaseFailure failure)? errorDatabase,
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
    required TResult Function(ErrorAuth value) errorAuth,
    required TResult Function(ErrorDatabase value) errorDatabase,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Submitting value)? submitting,
    TResult Function(ErrorAuth value)? errorAuth,
    TResult Function(ErrorDatabase value)? errorDatabase,
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
    required TResult Function(AuthFailure failure) errorAuth,
    required TResult Function(DatabaseFailure failure) errorDatabase,
  }) {
    return submitting();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? submitting,
    TResult Function(AuthFailure failure)? errorAuth,
    TResult Function(DatabaseFailure failure)? errorDatabase,
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
    required TResult Function(ErrorAuth value) errorAuth,
    required TResult Function(ErrorDatabase value) errorDatabase,
  }) {
    return submitting(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Submitting value)? submitting,
    TResult Function(ErrorAuth value)? errorAuth,
    TResult Function(ErrorDatabase value)? errorDatabase,
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
abstract class $ErrorAuthCopyWith<$Res> {
  factory $ErrorAuthCopyWith(ErrorAuth value, $Res Function(ErrorAuth) then) =
      _$ErrorAuthCopyWithImpl<$Res>;
  $Res call({AuthFailure failure});

  $AuthFailureCopyWith<$Res> get failure;
}

/// @nodoc
class _$ErrorAuthCopyWithImpl<$Res> extends _$UserProfileStateCopyWithImpl<$Res>
    implements $ErrorAuthCopyWith<$Res> {
  _$ErrorAuthCopyWithImpl(ErrorAuth _value, $Res Function(ErrorAuth) _then)
      : super(_value, (v) => _then(v as ErrorAuth));

  @override
  ErrorAuth get _value => super._value as ErrorAuth;

  @override
  $Res call({
    Object? failure = freezed,
  }) {
    return _then(ErrorAuth(
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
class _$ErrorAuth implements ErrorAuth {
  const _$ErrorAuth(this.failure);

  @override
  final AuthFailure failure;

  @override
  String toString() {
    return 'UserProfileState.errorAuth(failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ErrorAuth &&
            (identical(other.failure, failure) ||
                const DeepCollectionEquality().equals(other.failure, failure)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(failure);

  @JsonKey(ignore: true)
  @override
  $ErrorAuthCopyWith<ErrorAuth> get copyWith =>
      _$ErrorAuthCopyWithImpl<ErrorAuth>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() submitting,
    required TResult Function(AuthFailure failure) errorAuth,
    required TResult Function(DatabaseFailure failure) errorDatabase,
  }) {
    return errorAuth(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? submitting,
    TResult Function(AuthFailure failure)? errorAuth,
    TResult Function(DatabaseFailure failure)? errorDatabase,
    required TResult orElse(),
  }) {
    if (errorAuth != null) {
      return errorAuth(failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Submitting value) submitting,
    required TResult Function(ErrorAuth value) errorAuth,
    required TResult Function(ErrorDatabase value) errorDatabase,
  }) {
    return errorAuth(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Submitting value)? submitting,
    TResult Function(ErrorAuth value)? errorAuth,
    TResult Function(ErrorDatabase value)? errorDatabase,
    required TResult orElse(),
  }) {
    if (errorAuth != null) {
      return errorAuth(this);
    }
    return orElse();
  }
}

abstract class ErrorAuth implements UserProfileState {
  const factory ErrorAuth(AuthFailure failure) = _$ErrorAuth;

  AuthFailure get failure => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ErrorAuthCopyWith<ErrorAuth> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ErrorDatabaseCopyWith<$Res> {
  factory $ErrorDatabaseCopyWith(
          ErrorDatabase value, $Res Function(ErrorDatabase) then) =
      _$ErrorDatabaseCopyWithImpl<$Res>;
  $Res call({DatabaseFailure failure});

  $DatabaseFailureCopyWith<$Res> get failure;
}

/// @nodoc
class _$ErrorDatabaseCopyWithImpl<$Res>
    extends _$UserProfileStateCopyWithImpl<$Res>
    implements $ErrorDatabaseCopyWith<$Res> {
  _$ErrorDatabaseCopyWithImpl(
      ErrorDatabase _value, $Res Function(ErrorDatabase) _then)
      : super(_value, (v) => _then(v as ErrorDatabase));

  @override
  ErrorDatabase get _value => super._value as ErrorDatabase;

  @override
  $Res call({
    Object? failure = freezed,
  }) {
    return _then(ErrorDatabase(
      failure == freezed
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as DatabaseFailure,
    ));
  }

  @override
  $DatabaseFailureCopyWith<$Res> get failure {
    return $DatabaseFailureCopyWith<$Res>(_value.failure, (value) {
      return _then(_value.copyWith(failure: value));
    });
  }
}

/// @nodoc
class _$ErrorDatabase implements ErrorDatabase {
  const _$ErrorDatabase(this.failure);

  @override
  final DatabaseFailure failure;

  @override
  String toString() {
    return 'UserProfileState.errorDatabase(failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ErrorDatabase &&
            (identical(other.failure, failure) ||
                const DeepCollectionEquality().equals(other.failure, failure)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(failure);

  @JsonKey(ignore: true)
  @override
  $ErrorDatabaseCopyWith<ErrorDatabase> get copyWith =>
      _$ErrorDatabaseCopyWithImpl<ErrorDatabase>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() submitting,
    required TResult Function(AuthFailure failure) errorAuth,
    required TResult Function(DatabaseFailure failure) errorDatabase,
  }) {
    return errorDatabase(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? submitting,
    TResult Function(AuthFailure failure)? errorAuth,
    TResult Function(DatabaseFailure failure)? errorDatabase,
    required TResult orElse(),
  }) {
    if (errorDatabase != null) {
      return errorDatabase(failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Submitting value) submitting,
    required TResult Function(ErrorAuth value) errorAuth,
    required TResult Function(ErrorDatabase value) errorDatabase,
  }) {
    return errorDatabase(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Submitting value)? submitting,
    TResult Function(ErrorAuth value)? errorAuth,
    TResult Function(ErrorDatabase value)? errorDatabase,
    required TResult orElse(),
  }) {
    if (errorDatabase != null) {
      return errorDatabase(this);
    }
    return orElse();
  }
}

abstract class ErrorDatabase implements UserProfileState {
  const factory ErrorDatabase(DatabaseFailure failure) = _$ErrorDatabase;

  DatabaseFailure get failure => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ErrorDatabaseCopyWith<ErrorDatabase> get copyWith =>
      throw _privateConstructorUsedError;
}

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'change_email_form_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ChangeEmailFormStateTearOff {
  const _$ChangeEmailFormStateTearOff();

  _ChangeEmailFormState call(
      {required String newEmail,
      required String confirmNewEmail,
      required bool showErrorMessages,
      required bool isSubmitting,
      required Option<UserInfoFailure> failureOption}) {
    return _ChangeEmailFormState(
      newEmail: newEmail,
      confirmNewEmail: confirmNewEmail,
      showErrorMessages: showErrorMessages,
      isSubmitting: isSubmitting,
      failureOption: failureOption,
    );
  }
}

/// @nodoc
const $ChangeEmailFormState = _$ChangeEmailFormStateTearOff();

/// @nodoc
mixin _$ChangeEmailFormState {
  String get newEmail => throw _privateConstructorUsedError;
  String get confirmNewEmail => throw _privateConstructorUsedError;
  bool get showErrorMessages => throw _privateConstructorUsedError;
  bool get isSubmitting => throw _privateConstructorUsedError;
  Option<UserInfoFailure> get failureOption =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChangeEmailFormStateCopyWith<ChangeEmailFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChangeEmailFormStateCopyWith<$Res> {
  factory $ChangeEmailFormStateCopyWith(ChangeEmailFormState value,
          $Res Function(ChangeEmailFormState) then) =
      _$ChangeEmailFormStateCopyWithImpl<$Res>;
  $Res call(
      {String newEmail,
      String confirmNewEmail,
      bool showErrorMessages,
      bool isSubmitting,
      Option<UserInfoFailure> failureOption});
}

/// @nodoc
class _$ChangeEmailFormStateCopyWithImpl<$Res>
    implements $ChangeEmailFormStateCopyWith<$Res> {
  _$ChangeEmailFormStateCopyWithImpl(this._value, this._then);

  final ChangeEmailFormState _value;
  // ignore: unused_field
  final $Res Function(ChangeEmailFormState) _then;

  @override
  $Res call({
    Object? newEmail = freezed,
    Object? confirmNewEmail = freezed,
    Object? showErrorMessages = freezed,
    Object? isSubmitting = freezed,
    Object? failureOption = freezed,
  }) {
    return _then(_value.copyWith(
      newEmail: newEmail == freezed
          ? _value.newEmail
          : newEmail // ignore: cast_nullable_to_non_nullable
              as String,
      confirmNewEmail: confirmNewEmail == freezed
          ? _value.confirmNewEmail
          : confirmNewEmail // ignore: cast_nullable_to_non_nullable
              as String,
      showErrorMessages: showErrorMessages == freezed
          ? _value.showErrorMessages
          : showErrorMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      isSubmitting: isSubmitting == freezed
          ? _value.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      failureOption: failureOption == freezed
          ? _value.failureOption
          : failureOption // ignore: cast_nullable_to_non_nullable
              as Option<UserInfoFailure>,
    ));
  }
}

/// @nodoc
abstract class _$ChangeEmailFormStateCopyWith<$Res>
    implements $ChangeEmailFormStateCopyWith<$Res> {
  factory _$ChangeEmailFormStateCopyWith(_ChangeEmailFormState value,
          $Res Function(_ChangeEmailFormState) then) =
      __$ChangeEmailFormStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {String newEmail,
      String confirmNewEmail,
      bool showErrorMessages,
      bool isSubmitting,
      Option<UserInfoFailure> failureOption});
}

/// @nodoc
class __$ChangeEmailFormStateCopyWithImpl<$Res>
    extends _$ChangeEmailFormStateCopyWithImpl<$Res>
    implements _$ChangeEmailFormStateCopyWith<$Res> {
  __$ChangeEmailFormStateCopyWithImpl(
      _ChangeEmailFormState _value, $Res Function(_ChangeEmailFormState) _then)
      : super(_value, (v) => _then(v as _ChangeEmailFormState));

  @override
  _ChangeEmailFormState get _value => super._value as _ChangeEmailFormState;

  @override
  $Res call({
    Object? newEmail = freezed,
    Object? confirmNewEmail = freezed,
    Object? showErrorMessages = freezed,
    Object? isSubmitting = freezed,
    Object? failureOption = freezed,
  }) {
    return _then(_ChangeEmailFormState(
      newEmail: newEmail == freezed
          ? _value.newEmail
          : newEmail // ignore: cast_nullable_to_non_nullable
              as String,
      confirmNewEmail: confirmNewEmail == freezed
          ? _value.confirmNewEmail
          : confirmNewEmail // ignore: cast_nullable_to_non_nullable
              as String,
      showErrorMessages: showErrorMessages == freezed
          ? _value.showErrorMessages
          : showErrorMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      isSubmitting: isSubmitting == freezed
          ? _value.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      failureOption: failureOption == freezed
          ? _value.failureOption
          : failureOption // ignore: cast_nullable_to_non_nullable
              as Option<UserInfoFailure>,
    ));
  }
}

/// @nodoc

class _$_ChangeEmailFormState implements _ChangeEmailFormState {
  const _$_ChangeEmailFormState(
      {required this.newEmail,
      required this.confirmNewEmail,
      required this.showErrorMessages,
      required this.isSubmitting,
      required this.failureOption});

  @override
  final String newEmail;
  @override
  final String confirmNewEmail;
  @override
  final bool showErrorMessages;
  @override
  final bool isSubmitting;
  @override
  final Option<UserInfoFailure> failureOption;

  @override
  String toString() {
    return 'ChangeEmailFormState(newEmail: $newEmail, confirmNewEmail: $confirmNewEmail, showErrorMessages: $showErrorMessages, isSubmitting: $isSubmitting, failureOption: $failureOption)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ChangeEmailFormState &&
            (identical(other.newEmail, newEmail) ||
                const DeepCollectionEquality()
                    .equals(other.newEmail, newEmail)) &&
            (identical(other.confirmNewEmail, confirmNewEmail) ||
                const DeepCollectionEquality()
                    .equals(other.confirmNewEmail, confirmNewEmail)) &&
            (identical(other.showErrorMessages, showErrorMessages) ||
                const DeepCollectionEquality()
                    .equals(other.showErrorMessages, showErrorMessages)) &&
            (identical(other.isSubmitting, isSubmitting) ||
                const DeepCollectionEquality()
                    .equals(other.isSubmitting, isSubmitting)) &&
            (identical(other.failureOption, failureOption) ||
                const DeepCollectionEquality()
                    .equals(other.failureOption, failureOption)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(newEmail) ^
      const DeepCollectionEquality().hash(confirmNewEmail) ^
      const DeepCollectionEquality().hash(showErrorMessages) ^
      const DeepCollectionEquality().hash(isSubmitting) ^
      const DeepCollectionEquality().hash(failureOption);

  @JsonKey(ignore: true)
  @override
  _$ChangeEmailFormStateCopyWith<_ChangeEmailFormState> get copyWith =>
      __$ChangeEmailFormStateCopyWithImpl<_ChangeEmailFormState>(
          this, _$identity);
}

abstract class _ChangeEmailFormState implements ChangeEmailFormState {
  const factory _ChangeEmailFormState(
          {required String newEmail,
          required String confirmNewEmail,
          required bool showErrorMessages,
          required bool isSubmitting,
          required Option<UserInfoFailure> failureOption}) =
      _$_ChangeEmailFormState;

  @override
  String get newEmail => throw _privateConstructorUsedError;
  @override
  String get confirmNewEmail => throw _privateConstructorUsedError;
  @override
  bool get showErrorMessages => throw _privateConstructorUsedError;
  @override
  bool get isSubmitting => throw _privateConstructorUsedError;
  @override
  Option<UserInfoFailure> get failureOption =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ChangeEmailFormStateCopyWith<_ChangeEmailFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

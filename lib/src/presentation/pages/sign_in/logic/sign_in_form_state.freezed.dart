// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'sign_in_form_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$SignInFormStateTearOff {
  const _$SignInFormStateTearOff();

// ignore: unused_element
  _SignInFormState call(
      {@required String email,
      @required String password,
      @required String resetPasswordEmail,
      @required bool showErrorMessages,
      @required bool showResetPasswordEmailError,
      @required bool isSubmitting,
      @required Option<AuthFailure> authFailureOption}) {
    return _SignInFormState(
      email: email,
      password: password,
      resetPasswordEmail: resetPasswordEmail,
      showErrorMessages: showErrorMessages,
      showResetPasswordEmailError: showResetPasswordEmailError,
      isSubmitting: isSubmitting,
      authFailureOption: authFailureOption,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $SignInFormState = _$SignInFormStateTearOff();

/// @nodoc
mixin _$SignInFormState {
  String get email;
  String get password;
  String get resetPasswordEmail;
  bool get showErrorMessages;
  bool get showResetPasswordEmailError;
  bool get isSubmitting;
  Option<AuthFailure> get authFailureOption;

  @JsonKey(ignore: true)
  $SignInFormStateCopyWith<SignInFormState> get copyWith;
}

/// @nodoc
abstract class $SignInFormStateCopyWith<$Res> {
  factory $SignInFormStateCopyWith(
          SignInFormState value, $Res Function(SignInFormState) then) =
      _$SignInFormStateCopyWithImpl<$Res>;
  $Res call(
      {String email,
      String password,
      String resetPasswordEmail,
      bool showErrorMessages,
      bool showResetPasswordEmailError,
      bool isSubmitting,
      Option<AuthFailure> authFailureOption});
}

/// @nodoc
class _$SignInFormStateCopyWithImpl<$Res>
    implements $SignInFormStateCopyWith<$Res> {
  _$SignInFormStateCopyWithImpl(this._value, this._then);

  final SignInFormState _value;
  // ignore: unused_field
  final $Res Function(SignInFormState) _then;

  @override
  $Res call({
    Object email = freezed,
    Object password = freezed,
    Object resetPasswordEmail = freezed,
    Object showErrorMessages = freezed,
    Object showResetPasswordEmailError = freezed,
    Object isSubmitting = freezed,
    Object authFailureOption = freezed,
  }) {
    return _then(_value.copyWith(
      email: email == freezed ? _value.email : email as String,
      password: password == freezed ? _value.password : password as String,
      resetPasswordEmail: resetPasswordEmail == freezed
          ? _value.resetPasswordEmail
          : resetPasswordEmail as String,
      showErrorMessages: showErrorMessages == freezed
          ? _value.showErrorMessages
          : showErrorMessages as bool,
      showResetPasswordEmailError: showResetPasswordEmailError == freezed
          ? _value.showResetPasswordEmailError
          : showResetPasswordEmailError as bool,
      isSubmitting:
          isSubmitting == freezed ? _value.isSubmitting : isSubmitting as bool,
      authFailureOption: authFailureOption == freezed
          ? _value.authFailureOption
          : authFailureOption as Option<AuthFailure>,
    ));
  }
}

/// @nodoc
abstract class _$SignInFormStateCopyWith<$Res>
    implements $SignInFormStateCopyWith<$Res> {
  factory _$SignInFormStateCopyWith(
          _SignInFormState value, $Res Function(_SignInFormState) then) =
      __$SignInFormStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {String email,
      String password,
      String resetPasswordEmail,
      bool showErrorMessages,
      bool showResetPasswordEmailError,
      bool isSubmitting,
      Option<AuthFailure> authFailureOption});
}

/// @nodoc
class __$SignInFormStateCopyWithImpl<$Res>
    extends _$SignInFormStateCopyWithImpl<$Res>
    implements _$SignInFormStateCopyWith<$Res> {
  __$SignInFormStateCopyWithImpl(
      _SignInFormState _value, $Res Function(_SignInFormState) _then)
      : super(_value, (v) => _then(v as _SignInFormState));

  @override
  _SignInFormState get _value => super._value as _SignInFormState;

  @override
  $Res call({
    Object email = freezed,
    Object password = freezed,
    Object resetPasswordEmail = freezed,
    Object showErrorMessages = freezed,
    Object showResetPasswordEmailError = freezed,
    Object isSubmitting = freezed,
    Object authFailureOption = freezed,
  }) {
    return _then(_SignInFormState(
      email: email == freezed ? _value.email : email as String,
      password: password == freezed ? _value.password : password as String,
      resetPasswordEmail: resetPasswordEmail == freezed
          ? _value.resetPasswordEmail
          : resetPasswordEmail as String,
      showErrorMessages: showErrorMessages == freezed
          ? _value.showErrorMessages
          : showErrorMessages as bool,
      showResetPasswordEmailError: showResetPasswordEmailError == freezed
          ? _value.showResetPasswordEmailError
          : showResetPasswordEmailError as bool,
      isSubmitting:
          isSubmitting == freezed ? _value.isSubmitting : isSubmitting as bool,
      authFailureOption: authFailureOption == freezed
          ? _value.authFailureOption
          : authFailureOption as Option<AuthFailure>,
    ));
  }
}

/// @nodoc
class _$_SignInFormState implements _SignInFormState {
  const _$_SignInFormState(
      {@required this.email,
      @required this.password,
      @required this.resetPasswordEmail,
      @required this.showErrorMessages,
      @required this.showResetPasswordEmailError,
      @required this.isSubmitting,
      @required this.authFailureOption})
      : assert(email != null),
        assert(password != null),
        assert(resetPasswordEmail != null),
        assert(showErrorMessages != null),
        assert(showResetPasswordEmailError != null),
        assert(isSubmitting != null),
        assert(authFailureOption != null);

  @override
  final String email;
  @override
  final String password;
  @override
  final String resetPasswordEmail;
  @override
  final bool showErrorMessages;
  @override
  final bool showResetPasswordEmailError;
  @override
  final bool isSubmitting;
  @override
  final Option<AuthFailure> authFailureOption;

  @override
  String toString() {
    return 'SignInFormState(email: $email, password: $password, resetPasswordEmail: $resetPasswordEmail, showErrorMessages: $showErrorMessages, showResetPasswordEmailError: $showResetPasswordEmailError, isSubmitting: $isSubmitting, authFailureOption: $authFailureOption)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SignInFormState &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality()
                    .equals(other.password, password)) &&
            (identical(other.resetPasswordEmail, resetPasswordEmail) ||
                const DeepCollectionEquality()
                    .equals(other.resetPasswordEmail, resetPasswordEmail)) &&
            (identical(other.showErrorMessages, showErrorMessages) ||
                const DeepCollectionEquality()
                    .equals(other.showErrorMessages, showErrorMessages)) &&
            (identical(other.showResetPasswordEmailError,
                    showResetPasswordEmailError) ||
                const DeepCollectionEquality().equals(
                    other.showResetPasswordEmailError,
                    showResetPasswordEmailError)) &&
            (identical(other.isSubmitting, isSubmitting) ||
                const DeepCollectionEquality()
                    .equals(other.isSubmitting, isSubmitting)) &&
            (identical(other.authFailureOption, authFailureOption) ||
                const DeepCollectionEquality()
                    .equals(other.authFailureOption, authFailureOption)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(password) ^
      const DeepCollectionEquality().hash(resetPasswordEmail) ^
      const DeepCollectionEquality().hash(showErrorMessages) ^
      const DeepCollectionEquality().hash(showResetPasswordEmailError) ^
      const DeepCollectionEquality().hash(isSubmitting) ^
      const DeepCollectionEquality().hash(authFailureOption);

  @JsonKey(ignore: true)
  @override
  _$SignInFormStateCopyWith<_SignInFormState> get copyWith =>
      __$SignInFormStateCopyWithImpl<_SignInFormState>(this, _$identity);
}

abstract class _SignInFormState implements SignInFormState {
  const factory _SignInFormState(
      {@required String email,
      @required String password,
      @required String resetPasswordEmail,
      @required bool showErrorMessages,
      @required bool showResetPasswordEmailError,
      @required bool isSubmitting,
      @required Option<AuthFailure> authFailureOption}) = _$_SignInFormState;

  @override
  String get email;
  @override
  String get password;
  @override
  String get resetPasswordEmail;
  @override
  bool get showErrorMessages;
  @override
  bool get showResetPasswordEmailError;
  @override
  bool get isSubmitting;
  @override
  Option<AuthFailure> get authFailureOption;
  @override
  @JsonKey(ignore: true)
  _$SignInFormStateCopyWith<_SignInFormState> get copyWith;
}

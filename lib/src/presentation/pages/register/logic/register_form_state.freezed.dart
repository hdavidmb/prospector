// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'register_form_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$RegisterFormStateTearOff {
  const _$RegisterFormStateTearOff();

// ignore: unused_element
  _RegisterFormState call(
      {@required String name,
      @required String email,
      @required String password,
      @required String confirmPassword,
      @required bool showErrorMessages,
      @required bool isSubmitting,
      @required Option<AuthFailure> authFailureOption}) {
    return _RegisterFormState(
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      showErrorMessages: showErrorMessages,
      isSubmitting: isSubmitting,
      authFailureOption: authFailureOption,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $RegisterFormState = _$RegisterFormStateTearOff();

/// @nodoc
mixin _$RegisterFormState {
  String get name;
  String get email;
  String get password;
  String get confirmPassword;
  bool get showErrorMessages;
  bool get isSubmitting;
  Option<AuthFailure> get authFailureOption;

  @JsonKey(ignore: true)
  $RegisterFormStateCopyWith<RegisterFormState> get copyWith;
}

/// @nodoc
abstract class $RegisterFormStateCopyWith<$Res> {
  factory $RegisterFormStateCopyWith(
          RegisterFormState value, $Res Function(RegisterFormState) then) =
      _$RegisterFormStateCopyWithImpl<$Res>;
  $Res call(
      {String name,
      String email,
      String password,
      String confirmPassword,
      bool showErrorMessages,
      bool isSubmitting,
      Option<AuthFailure> authFailureOption});
}

/// @nodoc
class _$RegisterFormStateCopyWithImpl<$Res>
    implements $RegisterFormStateCopyWith<$Res> {
  _$RegisterFormStateCopyWithImpl(this._value, this._then);

  final RegisterFormState _value;
  // ignore: unused_field
  final $Res Function(RegisterFormState) _then;

  @override
  $Res call({
    Object name = freezed,
    Object email = freezed,
    Object password = freezed,
    Object confirmPassword = freezed,
    Object showErrorMessages = freezed,
    Object isSubmitting = freezed,
    Object authFailureOption = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed ? _value.name : name as String,
      email: email == freezed ? _value.email : email as String,
      password: password == freezed ? _value.password : password as String,
      confirmPassword: confirmPassword == freezed
          ? _value.confirmPassword
          : confirmPassword as String,
      showErrorMessages: showErrorMessages == freezed
          ? _value.showErrorMessages
          : showErrorMessages as bool,
      isSubmitting:
          isSubmitting == freezed ? _value.isSubmitting : isSubmitting as bool,
      authFailureOption: authFailureOption == freezed
          ? _value.authFailureOption
          : authFailureOption as Option<AuthFailure>,
    ));
  }
}

/// @nodoc
abstract class _$RegisterFormStateCopyWith<$Res>
    implements $RegisterFormStateCopyWith<$Res> {
  factory _$RegisterFormStateCopyWith(
          _RegisterFormState value, $Res Function(_RegisterFormState) then) =
      __$RegisterFormStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      String email,
      String password,
      String confirmPassword,
      bool showErrorMessages,
      bool isSubmitting,
      Option<AuthFailure> authFailureOption});
}

/// @nodoc
class __$RegisterFormStateCopyWithImpl<$Res>
    extends _$RegisterFormStateCopyWithImpl<$Res>
    implements _$RegisterFormStateCopyWith<$Res> {
  __$RegisterFormStateCopyWithImpl(
      _RegisterFormState _value, $Res Function(_RegisterFormState) _then)
      : super(_value, (v) => _then(v as _RegisterFormState));

  @override
  _RegisterFormState get _value => super._value as _RegisterFormState;

  @override
  $Res call({
    Object name = freezed,
    Object email = freezed,
    Object password = freezed,
    Object confirmPassword = freezed,
    Object showErrorMessages = freezed,
    Object isSubmitting = freezed,
    Object authFailureOption = freezed,
  }) {
    return _then(_RegisterFormState(
      name: name == freezed ? _value.name : name as String,
      email: email == freezed ? _value.email : email as String,
      password: password == freezed ? _value.password : password as String,
      confirmPassword: confirmPassword == freezed
          ? _value.confirmPassword
          : confirmPassword as String,
      showErrorMessages: showErrorMessages == freezed
          ? _value.showErrorMessages
          : showErrorMessages as bool,
      isSubmitting:
          isSubmitting == freezed ? _value.isSubmitting : isSubmitting as bool,
      authFailureOption: authFailureOption == freezed
          ? _value.authFailureOption
          : authFailureOption as Option<AuthFailure>,
    ));
  }
}

/// @nodoc
class _$_RegisterFormState implements _RegisterFormState {
  const _$_RegisterFormState(
      {@required this.name,
      @required this.email,
      @required this.password,
      @required this.confirmPassword,
      @required this.showErrorMessages,
      @required this.isSubmitting,
      @required this.authFailureOption})
      : assert(name != null),
        assert(email != null),
        assert(password != null),
        assert(confirmPassword != null),
        assert(showErrorMessages != null),
        assert(isSubmitting != null),
        assert(authFailureOption != null);

  @override
  final String name;
  @override
  final String email;
  @override
  final String password;
  @override
  final String confirmPassword;
  @override
  final bool showErrorMessages;
  @override
  final bool isSubmitting;
  @override
  final Option<AuthFailure> authFailureOption;

  @override
  String toString() {
    return 'RegisterFormState(name: $name, email: $email, password: $password, confirmPassword: $confirmPassword, showErrorMessages: $showErrorMessages, isSubmitting: $isSubmitting, authFailureOption: $authFailureOption)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _RegisterFormState &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality()
                    .equals(other.password, password)) &&
            (identical(other.confirmPassword, confirmPassword) ||
                const DeepCollectionEquality()
                    .equals(other.confirmPassword, confirmPassword)) &&
            (identical(other.showErrorMessages, showErrorMessages) ||
                const DeepCollectionEquality()
                    .equals(other.showErrorMessages, showErrorMessages)) &&
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
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(password) ^
      const DeepCollectionEquality().hash(confirmPassword) ^
      const DeepCollectionEquality().hash(showErrorMessages) ^
      const DeepCollectionEquality().hash(isSubmitting) ^
      const DeepCollectionEquality().hash(authFailureOption);

  @JsonKey(ignore: true)
  @override
  _$RegisterFormStateCopyWith<_RegisterFormState> get copyWith =>
      __$RegisterFormStateCopyWithImpl<_RegisterFormState>(this, _$identity);
}

abstract class _RegisterFormState implements RegisterFormState {
  const factory _RegisterFormState(
      {@required String name,
      @required String email,
      @required String password,
      @required String confirmPassword,
      @required bool showErrorMessages,
      @required bool isSubmitting,
      @required Option<AuthFailure> authFailureOption}) = _$_RegisterFormState;

  @override
  String get name;
  @override
  String get email;
  @override
  String get password;
  @override
  String get confirmPassword;
  @override
  bool get showErrorMessages;
  @override
  bool get isSubmitting;
  @override
  Option<AuthFailure> get authFailureOption;
  @override
  @JsonKey(ignore: true)
  _$RegisterFormStateCopyWith<_RegisterFormState> get copyWith;
}

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'event_form_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$EventFormStateTearOff {
  const _$EventFormStateTearOff();

  _EventFormState call(
      {required String title,
      required String location,
      required bool isReminder,
      required bool isSubmitting,
      required bool showErrorMessages,
      required bool deleted,
      required Option<Either<DatabaseFailure, Unit>> failureOrSuccesOption}) {
    return _EventFormState(
      title: title,
      location: location,
      isReminder: isReminder,
      isSubmitting: isSubmitting,
      showErrorMessages: showErrorMessages,
      deleted: deleted,
      failureOrSuccesOption: failureOrSuccesOption,
    );
  }
}

/// @nodoc
const $EventFormState = _$EventFormStateTearOff();

/// @nodoc
mixin _$EventFormState {
  String get title => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  bool get isReminder => throw _privateConstructorUsedError;
  bool get isSubmitting => throw _privateConstructorUsedError;
  bool get showErrorMessages => throw _privateConstructorUsedError;
  bool get deleted => throw _privateConstructorUsedError;
  Option<Either<DatabaseFailure, Unit>> get failureOrSuccesOption =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EventFormStateCopyWith<EventFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventFormStateCopyWith<$Res> {
  factory $EventFormStateCopyWith(
          EventFormState value, $Res Function(EventFormState) then) =
      _$EventFormStateCopyWithImpl<$Res>;
  $Res call(
      {String title,
      String location,
      bool isReminder,
      bool isSubmitting,
      bool showErrorMessages,
      bool deleted,
      Option<Either<DatabaseFailure, Unit>> failureOrSuccesOption});
}

/// @nodoc
class _$EventFormStateCopyWithImpl<$Res>
    implements $EventFormStateCopyWith<$Res> {
  _$EventFormStateCopyWithImpl(this._value, this._then);

  final EventFormState _value;
  // ignore: unused_field
  final $Res Function(EventFormState) _then;

  @override
  $Res call({
    Object? title = freezed,
    Object? location = freezed,
    Object? isReminder = freezed,
    Object? isSubmitting = freezed,
    Object? showErrorMessages = freezed,
    Object? deleted = freezed,
    Object? failureOrSuccesOption = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      location: location == freezed
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      isReminder: isReminder == freezed
          ? _value.isReminder
          : isReminder // ignore: cast_nullable_to_non_nullable
              as bool,
      isSubmitting: isSubmitting == freezed
          ? _value.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      showErrorMessages: showErrorMessages == freezed
          ? _value.showErrorMessages
          : showErrorMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      deleted: deleted == freezed
          ? _value.deleted
          : deleted // ignore: cast_nullable_to_non_nullable
              as bool,
      failureOrSuccesOption: failureOrSuccesOption == freezed
          ? _value.failureOrSuccesOption
          : failureOrSuccesOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<DatabaseFailure, Unit>>,
    ));
  }
}

/// @nodoc
abstract class _$EventFormStateCopyWith<$Res>
    implements $EventFormStateCopyWith<$Res> {
  factory _$EventFormStateCopyWith(
          _EventFormState value, $Res Function(_EventFormState) then) =
      __$EventFormStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {String title,
      String location,
      bool isReminder,
      bool isSubmitting,
      bool showErrorMessages,
      bool deleted,
      Option<Either<DatabaseFailure, Unit>> failureOrSuccesOption});
}

/// @nodoc
class __$EventFormStateCopyWithImpl<$Res>
    extends _$EventFormStateCopyWithImpl<$Res>
    implements _$EventFormStateCopyWith<$Res> {
  __$EventFormStateCopyWithImpl(
      _EventFormState _value, $Res Function(_EventFormState) _then)
      : super(_value, (v) => _then(v as _EventFormState));

  @override
  _EventFormState get _value => super._value as _EventFormState;

  @override
  $Res call({
    Object? title = freezed,
    Object? location = freezed,
    Object? isReminder = freezed,
    Object? isSubmitting = freezed,
    Object? showErrorMessages = freezed,
    Object? deleted = freezed,
    Object? failureOrSuccesOption = freezed,
  }) {
    return _then(_EventFormState(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      location: location == freezed
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      isReminder: isReminder == freezed
          ? _value.isReminder
          : isReminder // ignore: cast_nullable_to_non_nullable
              as bool,
      isSubmitting: isSubmitting == freezed
          ? _value.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      showErrorMessages: showErrorMessages == freezed
          ? _value.showErrorMessages
          : showErrorMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      deleted: deleted == freezed
          ? _value.deleted
          : deleted // ignore: cast_nullable_to_non_nullable
              as bool,
      failureOrSuccesOption: failureOrSuccesOption == freezed
          ? _value.failureOrSuccesOption
          : failureOrSuccesOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<DatabaseFailure, Unit>>,
    ));
  }
}

/// @nodoc

class _$_EventFormState extends _EventFormState {
  const _$_EventFormState(
      {required this.title,
      required this.location,
      required this.isReminder,
      required this.isSubmitting,
      required this.showErrorMessages,
      required this.deleted,
      required this.failureOrSuccesOption})
      : super._();

  @override
  final String title;
  @override
  final String location;
  @override
  final bool isReminder;
  @override
  final bool isSubmitting;
  @override
  final bool showErrorMessages;
  @override
  final bool deleted;
  @override
  final Option<Either<DatabaseFailure, Unit>> failureOrSuccesOption;

  @override
  String toString() {
    return 'EventFormState(title: $title, location: $location, isReminder: $isReminder, isSubmitting: $isSubmitting, showErrorMessages: $showErrorMessages, deleted: $deleted, failureOrSuccesOption: $failureOrSuccesOption)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _EventFormState &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.location, location) ||
                const DeepCollectionEquality()
                    .equals(other.location, location)) &&
            (identical(other.isReminder, isReminder) ||
                const DeepCollectionEquality()
                    .equals(other.isReminder, isReminder)) &&
            (identical(other.isSubmitting, isSubmitting) ||
                const DeepCollectionEquality()
                    .equals(other.isSubmitting, isSubmitting)) &&
            (identical(other.showErrorMessages, showErrorMessages) ||
                const DeepCollectionEquality()
                    .equals(other.showErrorMessages, showErrorMessages)) &&
            (identical(other.deleted, deleted) ||
                const DeepCollectionEquality()
                    .equals(other.deleted, deleted)) &&
            (identical(other.failureOrSuccesOption, failureOrSuccesOption) ||
                const DeepCollectionEquality().equals(
                    other.failureOrSuccesOption, failureOrSuccesOption)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(location) ^
      const DeepCollectionEquality().hash(isReminder) ^
      const DeepCollectionEquality().hash(isSubmitting) ^
      const DeepCollectionEquality().hash(showErrorMessages) ^
      const DeepCollectionEquality().hash(deleted) ^
      const DeepCollectionEquality().hash(failureOrSuccesOption);

  @JsonKey(ignore: true)
  @override
  _$EventFormStateCopyWith<_EventFormState> get copyWith =>
      __$EventFormStateCopyWithImpl<_EventFormState>(this, _$identity);
}

abstract class _EventFormState extends EventFormState {
  const factory _EventFormState(
      {required String title,
      required String location,
      required bool isReminder,
      required bool isSubmitting,
      required bool showErrorMessages,
      required bool deleted,
      required Option<Either<DatabaseFailure, Unit>>
          failureOrSuccesOption}) = _$_EventFormState;
  const _EventFormState._() : super._();

  @override
  String get title => throw _privateConstructorUsedError;
  @override
  String get location => throw _privateConstructorUsedError;
  @override
  bool get isReminder => throw _privateConstructorUsedError;
  @override
  bool get isSubmitting => throw _privateConstructorUsedError;
  @override
  bool get showErrorMessages => throw _privateConstructorUsedError;
  @override
  bool get deleted => throw _privateConstructorUsedError;
  @override
  Option<Either<DatabaseFailure, Unit>> get failureOrSuccesOption =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$EventFormStateCopyWith<_EventFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

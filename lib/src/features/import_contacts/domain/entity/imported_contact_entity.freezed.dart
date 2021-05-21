// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'imported_contact_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ImportedContactTearOff {
  const _$ImportedContactTearOff();

  _ImportedContact call(
      {required String importedID,
      required String name,
      List<String>? phones,
      Uint8List? photo}) {
    return _ImportedContact(
      importedID: importedID,
      name: name,
      phones: phones,
      photo: photo,
    );
  }
}

/// @nodoc
const $ImportedContact = _$ImportedContactTearOff();

/// @nodoc
mixin _$ImportedContact {
  String get importedID => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<String>? get phones => throw _privateConstructorUsedError;
  Uint8List? get photo => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ImportedContactCopyWith<ImportedContact> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImportedContactCopyWith<$Res> {
  factory $ImportedContactCopyWith(
          ImportedContact value, $Res Function(ImportedContact) then) =
      _$ImportedContactCopyWithImpl<$Res>;
  $Res call(
      {String importedID, String name, List<String>? phones, Uint8List? photo});
}

/// @nodoc
class _$ImportedContactCopyWithImpl<$Res>
    implements $ImportedContactCopyWith<$Res> {
  _$ImportedContactCopyWithImpl(this._value, this._then);

  final ImportedContact _value;
  // ignore: unused_field
  final $Res Function(ImportedContact) _then;

  @override
  $Res call({
    Object? importedID = freezed,
    Object? name = freezed,
    Object? phones = freezed,
    Object? photo = freezed,
  }) {
    return _then(_value.copyWith(
      importedID: importedID == freezed
          ? _value.importedID
          : importedID // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phones: phones == freezed
          ? _value.phones
          : phones // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      photo: photo == freezed
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
    ));
  }
}

/// @nodoc
abstract class _$ImportedContactCopyWith<$Res>
    implements $ImportedContactCopyWith<$Res> {
  factory _$ImportedContactCopyWith(
          _ImportedContact value, $Res Function(_ImportedContact) then) =
      __$ImportedContactCopyWithImpl<$Res>;
  @override
  $Res call(
      {String importedID, String name, List<String>? phones, Uint8List? photo});
}

/// @nodoc
class __$ImportedContactCopyWithImpl<$Res>
    extends _$ImportedContactCopyWithImpl<$Res>
    implements _$ImportedContactCopyWith<$Res> {
  __$ImportedContactCopyWithImpl(
      _ImportedContact _value, $Res Function(_ImportedContact) _then)
      : super(_value, (v) => _then(v as _ImportedContact));

  @override
  _ImportedContact get _value => super._value as _ImportedContact;

  @override
  $Res call({
    Object? importedID = freezed,
    Object? name = freezed,
    Object? phones = freezed,
    Object? photo = freezed,
  }) {
    return _then(_ImportedContact(
      importedID: importedID == freezed
          ? _value.importedID
          : importedID // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phones: phones == freezed
          ? _value.phones
          : phones // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      photo: photo == freezed
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
    ));
  }
}

/// @nodoc

class _$_ImportedContact implements _ImportedContact {
  const _$_ImportedContact(
      {required this.importedID, required this.name, this.phones, this.photo});

  @override
  final String importedID;
  @override
  final String name;
  @override
  final List<String>? phones;
  @override
  final Uint8List? photo;

  @override
  String toString() {
    return 'ImportedContact(importedID: $importedID, name: $name, phones: $phones, photo: $photo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ImportedContact &&
            (identical(other.importedID, importedID) ||
                const DeepCollectionEquality()
                    .equals(other.importedID, importedID)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.phones, phones) ||
                const DeepCollectionEquality().equals(other.phones, phones)) &&
            (identical(other.photo, photo) ||
                const DeepCollectionEquality().equals(other.photo, photo)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(importedID) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(phones) ^
      const DeepCollectionEquality().hash(photo);

  @JsonKey(ignore: true)
  @override
  _$ImportedContactCopyWith<_ImportedContact> get copyWith =>
      __$ImportedContactCopyWithImpl<_ImportedContact>(this, _$identity);
}

abstract class _ImportedContact implements ImportedContact {
  const factory _ImportedContact(
      {required String importedID,
      required String name,
      List<String>? phones,
      Uint8List? photo}) = _$_ImportedContact;

  @override
  String get importedID => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  List<String>? get phones => throw _privateConstructorUsedError;
  @override
  Uint8List? get photo => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ImportedContactCopyWith<_ImportedContact> get copyWith =>
      throw _privateConstructorUsedError;
}

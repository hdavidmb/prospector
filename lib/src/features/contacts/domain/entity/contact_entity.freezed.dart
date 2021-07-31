// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'contact_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ContactTearOff {
  const _$ContactTearOff();

  _Contact call(
      {@HiveField(0) required String id,
      @HiveField(1) required String name,
      @HiveField(2) required String status,
      @HiveField(3) required DateTime created,
      @HiveField(4) required DateTime modified,
      @HiveField(5) String? gender,
      @HiveField(6) String? location,
      @HiveField(7) String? phone,
      @HiveField(8) String? whatsapp,
      @HiveField(9) List<String>? phones,
      @HiveField(10) String? photo,
      @HiveField(11) List<String>? tags,
      @HiveField(12) String? importedId}) {
    return _Contact(
      id: id,
      name: name,
      status: status,
      created: created,
      modified: modified,
      gender: gender,
      location: location,
      phone: phone,
      whatsapp: whatsapp,
      phones: phones,
      photo: photo,
      tags: tags,
      importedId: importedId,
    );
  }
}

/// @nodoc
const $Contact = _$ContactTearOff();

/// @nodoc
mixin _$Contact {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get name => throw _privateConstructorUsedError;
  @HiveField(2)
  String get status => throw _privateConstructorUsedError;
  @HiveField(3)
  DateTime get created => throw _privateConstructorUsedError;
  @HiveField(4)
  DateTime get modified => throw _privateConstructorUsedError;
  @HiveField(5)
  String? get gender => throw _privateConstructorUsedError;
  @HiveField(6)
  String? get location => throw _privateConstructorUsedError;
  @HiveField(7)
  String? get phone => throw _privateConstructorUsedError;
  @HiveField(8)
  String? get whatsapp => throw _privateConstructorUsedError;
  @HiveField(9)
  List<String>? get phones => throw _privateConstructorUsedError;
  @HiveField(10)
  String? get photo => throw _privateConstructorUsedError;
  @HiveField(11)
  List<String>? get tags => throw _privateConstructorUsedError;
  @HiveField(12)
  String? get importedId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ContactCopyWith<Contact> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactCopyWith<$Res> {
  factory $ContactCopyWith(Contact value, $Res Function(Contact) then) =
      _$ContactCopyWithImpl<$Res>;
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) String status,
      @HiveField(3) DateTime created,
      @HiveField(4) DateTime modified,
      @HiveField(5) String? gender,
      @HiveField(6) String? location,
      @HiveField(7) String? phone,
      @HiveField(8) String? whatsapp,
      @HiveField(9) List<String>? phones,
      @HiveField(10) String? photo,
      @HiveField(11) List<String>? tags,
      @HiveField(12) String? importedId});
}

/// @nodoc
class _$ContactCopyWithImpl<$Res> implements $ContactCopyWith<$Res> {
  _$ContactCopyWithImpl(this._value, this._then);

  final Contact _value;
  // ignore: unused_field
  final $Res Function(Contact) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? status = freezed,
    Object? created = freezed,
    Object? modified = freezed,
    Object? gender = freezed,
    Object? location = freezed,
    Object? phone = freezed,
    Object? whatsapp = freezed,
    Object? phones = freezed,
    Object? photo = freezed,
    Object? tags = freezed,
    Object? importedId = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      created: created == freezed
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
      modified: modified == freezed
          ? _value.modified
          : modified // ignore: cast_nullable_to_non_nullable
              as DateTime,
      gender: gender == freezed
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      location: location == freezed
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: phone == freezed
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      whatsapp: whatsapp == freezed
          ? _value.whatsapp
          : whatsapp // ignore: cast_nullable_to_non_nullable
              as String?,
      phones: phones == freezed
          ? _value.phones
          : phones // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      photo: photo == freezed
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: tags == freezed
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      importedId: importedId == freezed
          ? _value.importedId
          : importedId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$ContactCopyWith<$Res> implements $ContactCopyWith<$Res> {
  factory _$ContactCopyWith(_Contact value, $Res Function(_Contact) then) =
      __$ContactCopyWithImpl<$Res>;
  @override
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) String status,
      @HiveField(3) DateTime created,
      @HiveField(4) DateTime modified,
      @HiveField(5) String? gender,
      @HiveField(6) String? location,
      @HiveField(7) String? phone,
      @HiveField(8) String? whatsapp,
      @HiveField(9) List<String>? phones,
      @HiveField(10) String? photo,
      @HiveField(11) List<String>? tags,
      @HiveField(12) String? importedId});
}

/// @nodoc
class __$ContactCopyWithImpl<$Res> extends _$ContactCopyWithImpl<$Res>
    implements _$ContactCopyWith<$Res> {
  __$ContactCopyWithImpl(_Contact _value, $Res Function(_Contact) _then)
      : super(_value, (v) => _then(v as _Contact));

  @override
  _Contact get _value => super._value as _Contact;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? status = freezed,
    Object? created = freezed,
    Object? modified = freezed,
    Object? gender = freezed,
    Object? location = freezed,
    Object? phone = freezed,
    Object? whatsapp = freezed,
    Object? phones = freezed,
    Object? photo = freezed,
    Object? tags = freezed,
    Object? importedId = freezed,
  }) {
    return _then(_Contact(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      created: created == freezed
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
      modified: modified == freezed
          ? _value.modified
          : modified // ignore: cast_nullable_to_non_nullable
              as DateTime,
      gender: gender == freezed
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      location: location == freezed
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: phone == freezed
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      whatsapp: whatsapp == freezed
          ? _value.whatsapp
          : whatsapp // ignore: cast_nullable_to_non_nullable
              as String?,
      phones: phones == freezed
          ? _value.phones
          : phones // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      photo: photo == freezed
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: tags == freezed
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      importedId: importedId == freezed
          ? _value.importedId
          : importedId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@HiveType(typeId: 3)
class _$_Contact extends _Contact {
  const _$_Contact(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.name,
      @HiveField(2) required this.status,
      @HiveField(3) required this.created,
      @HiveField(4) required this.modified,
      @HiveField(5) this.gender,
      @HiveField(6) this.location,
      @HiveField(7) this.phone,
      @HiveField(8) this.whatsapp,
      @HiveField(9) this.phones,
      @HiveField(10) this.photo,
      @HiveField(11) this.tags,
      @HiveField(12) this.importedId})
      : super._();

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String name;
  @override
  @HiveField(2)
  final String status;
  @override
  @HiveField(3)
  final DateTime created;
  @override
  @HiveField(4)
  final DateTime modified;
  @override
  @HiveField(5)
  final String? gender;
  @override
  @HiveField(6)
  final String? location;
  @override
  @HiveField(7)
  final String? phone;
  @override
  @HiveField(8)
  final String? whatsapp;
  @override
  @HiveField(9)
  final List<String>? phones;
  @override
  @HiveField(10)
  final String? photo;
  @override
  @HiveField(11)
  final List<String>? tags;
  @override
  @HiveField(12)
  final String? importedId;

  @override
  String toString() {
    return 'Contact(id: $id, name: $name, status: $status, created: $created, modified: $modified, gender: $gender, location: $location, phone: $phone, whatsapp: $whatsapp, phones: $phones, photo: $photo, tags: $tags, importedId: $importedId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Contact &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.created, created) ||
                const DeepCollectionEquality()
                    .equals(other.created, created)) &&
            (identical(other.modified, modified) ||
                const DeepCollectionEquality()
                    .equals(other.modified, modified)) &&
            (identical(other.gender, gender) ||
                const DeepCollectionEquality().equals(other.gender, gender)) &&
            (identical(other.location, location) ||
                const DeepCollectionEquality()
                    .equals(other.location, location)) &&
            (identical(other.phone, phone) ||
                const DeepCollectionEquality().equals(other.phone, phone)) &&
            (identical(other.whatsapp, whatsapp) ||
                const DeepCollectionEquality()
                    .equals(other.whatsapp, whatsapp)) &&
            (identical(other.phones, phones) ||
                const DeepCollectionEquality().equals(other.phones, phones)) &&
            (identical(other.photo, photo) ||
                const DeepCollectionEquality().equals(other.photo, photo)) &&
            (identical(other.tags, tags) ||
                const DeepCollectionEquality().equals(other.tags, tags)) &&
            (identical(other.importedId, importedId) ||
                const DeepCollectionEquality()
                    .equals(other.importedId, importedId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(created) ^
      const DeepCollectionEquality().hash(modified) ^
      const DeepCollectionEquality().hash(gender) ^
      const DeepCollectionEquality().hash(location) ^
      const DeepCollectionEquality().hash(phone) ^
      const DeepCollectionEquality().hash(whatsapp) ^
      const DeepCollectionEquality().hash(phones) ^
      const DeepCollectionEquality().hash(photo) ^
      const DeepCollectionEquality().hash(tags) ^
      const DeepCollectionEquality().hash(importedId);

  @JsonKey(ignore: true)
  @override
  _$ContactCopyWith<_Contact> get copyWith =>
      __$ContactCopyWithImpl<_Contact>(this, _$identity);
}

abstract class _Contact extends Contact {
  const factory _Contact(
      {@HiveField(0) required String id,
      @HiveField(1) required String name,
      @HiveField(2) required String status,
      @HiveField(3) required DateTime created,
      @HiveField(4) required DateTime modified,
      @HiveField(5) String? gender,
      @HiveField(6) String? location,
      @HiveField(7) String? phone,
      @HiveField(8) String? whatsapp,
      @HiveField(9) List<String>? phones,
      @HiveField(10) String? photo,
      @HiveField(11) List<String>? tags,
      @HiveField(12) String? importedId}) = _$_Contact;
  const _Contact._() : super._();

  @override
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @override
  @HiveField(1)
  String get name => throw _privateConstructorUsedError;
  @override
  @HiveField(2)
  String get status => throw _privateConstructorUsedError;
  @override
  @HiveField(3)
  DateTime get created => throw _privateConstructorUsedError;
  @override
  @HiveField(4)
  DateTime get modified => throw _privateConstructorUsedError;
  @override
  @HiveField(5)
  String? get gender => throw _privateConstructorUsedError;
  @override
  @HiveField(6)
  String? get location => throw _privateConstructorUsedError;
  @override
  @HiveField(7)
  String? get phone => throw _privateConstructorUsedError;
  @override
  @HiveField(8)
  String? get whatsapp => throw _privateConstructorUsedError;
  @override
  @HiveField(9)
  List<String>? get phones => throw _privateConstructorUsedError;
  @override
  @HiveField(10)
  String? get photo => throw _privateConstructorUsedError;
  @override
  @HiveField(11)
  List<String>? get tags => throw _privateConstructorUsedError;
  @override
  @HiveField(12)
  String? get importedId => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ContactCopyWith<_Contact> get copyWith =>
      throw _privateConstructorUsedError;
}

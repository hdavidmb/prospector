// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserEntityAdapter extends TypeAdapter<_$_UserEntity> {
  @override
  final int typeId = 2;

  @override
  _$_UserEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_UserEntity(
      uid: fields[0] as String,
      name: fields[1] as String,
      subscription: fields[2] as String,
      expiryDate: fields[3] as DateTime,
      created: fields[4] as DateTime,
      modified: fields[5] as DateTime,
      email: fields[6] as String?,
      photoURL: fields[7] as String?,
      subscriptionSKU: fields[8] as String?,
      countryCode: fields[9] as String?,
      dialCode: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, _$_UserEntity obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.subscription)
      ..writeByte(3)
      ..write(obj.expiryDate)
      ..writeByte(4)
      ..write(obj.created)
      ..writeByte(5)
      ..write(obj.modified)
      ..writeByte(6)
      ..write(obj.email)
      ..writeByte(7)
      ..write(obj.photoURL)
      ..writeByte(8)
      ..write(obj.subscriptionSKU)
      ..writeByte(9)
      ..write(obj.countryCode)
      ..writeByte(10)
      ..write(obj.dialCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

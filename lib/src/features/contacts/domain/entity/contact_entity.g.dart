// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContactAdapter extends TypeAdapter<_$_Contact> {
  @override
  final int typeId = 3;

  @override
  _$_Contact read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_Contact(
      id: fields[0] as String,
      name: fields[1] as String,
      status: fields[2] as String,
      created: fields[3] as DateTime,
      modified: fields[4] as DateTime,
      gender: fields[5] as String?,
      location: fields[6] as String?,
      phone: fields[7] as String?,
      whatsapp: fields[8] as String?,
      phones: (fields[9] as List?)?.cast<dynamic>(),
      photo: fields[10] as String?,
      tags: (fields[11] as List?)?.cast<dynamic>(),
      importedId: fields[12] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, _$_Contact obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.created)
      ..writeByte(4)
      ..write(obj.modified)
      ..writeByte(5)
      ..write(obj.gender)
      ..writeByte(6)
      ..write(obj.location)
      ..writeByte(7)
      ..write(obj.phone)
      ..writeByte(8)
      ..write(obj.whatsapp)
      ..writeByte(9)
      ..write(obj.phones)
      ..writeByte(10)
      ..write(obj.photo)
      ..writeByte(11)
      ..write(obj.tags)
      ..writeByte(12)
      ..write(obj.importedId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

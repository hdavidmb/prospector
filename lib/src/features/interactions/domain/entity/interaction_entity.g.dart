// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interaction_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InteractionAdapter extends TypeAdapter<_$_Interaction> {
  @override
  final int typeId = 5;

  @override
  _$_Interaction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_Interaction(
      id: fields[0] as String,
      description: fields[1] as String,
      contact: fields[2] as String,
      type: fields[3] as String,
      created: fields[4] as DateTime,
      event: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, _$_Interaction obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.contact)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.created)
      ..writeByte(5)
      ..write(obj.event);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InteractionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

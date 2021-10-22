// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EventAdapter extends TypeAdapter<_$_Event> {
  @override
  final int typeId = 6;

  @override
  _$_Event read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_Event(
      id: fields[0] as String,
      title: fields[1] as String,
      created: fields[2] as DateTime,
      modified: fields[3] as DateTime,
      type: fields[4] as String,
      startDate: fields[5] as DateTime,
      endDate: fields[6] as DateTime,
      allDay: fields[7] as bool,
      guests: (fields[8] as List?)?.cast<dynamic>(),
      location: fields[9] as String?,
      notifications: (fields[10] as List?)?.cast<dynamic>(),
      notificationsIDs: (fields[11] as List?)?.cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, _$_Event obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.created)
      ..writeByte(3)
      ..write(obj.modified)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.startDate)
      ..writeByte(6)
      ..write(obj.endDate)
      ..writeByte(7)
      ..write(obj.allDay)
      ..writeByte(8)
      ..write(obj.guests)
      ..writeByte(9)
      ..write(obj.location)
      ..writeByte(10)
      ..write(obj.notifications)
      ..writeByte(11)
      ..write(obj.notificationsIDs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

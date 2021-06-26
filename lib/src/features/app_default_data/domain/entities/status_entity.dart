import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'status_entity.freezed.dart';
part 'status_entity.g.dart';

@freezed
class Status with _$Status {
  @HiveType(typeId: 0)
  const factory Status({
    @HiveField(0) required String id,
    @HiveField(1) required String key,
    @HiveField(2) required DateTime created,
  }) = _Status;

  const Status._();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'key': key,
      'created': created,
    };
  }

  factory Status.fromMap(Map<String, dynamic> map) {
    return Status(
      id: map['id'] as String,
      key: map['key'] as String,
      created: map['created'] as DateTime,
    );
  }
}
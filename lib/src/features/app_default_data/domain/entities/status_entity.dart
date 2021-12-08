import 'package:freezed_annotation/freezed_annotation.dart';

part 'status_entity.freezed.dart';

@freezed
class Status with _$Status {
  const factory Status({
    required String id,
    required String key,
    required DateTime created,
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

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'tag_entity.freezed.dart';

part 'tag_entity.g.dart';

@freezed
class Tag with _$Tag {
  @HiveType(typeId: 4)
  const factory Tag({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) required DateTime created,
  }) = _Tag;

  const Tag._();

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> tagMap = {
      'id': id,
      'name': name,
      'created': created,
    };
    return tagMap;
  }

  factory Tag.fromMap(Map<String, dynamic> map) {
    return Tag(
      id: map['id'] as String,
      name: map['name'] as String,
      created: map['id'] as DateTime,
    );
  }
}

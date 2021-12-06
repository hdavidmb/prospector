import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag_entity.freezed.dart';

@freezed
class Tag with _$Tag {
  const factory Tag({
    required String id,
    required String name,
    required DateTime created,
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
      created: map['created'] as DateTime,
    );
  }
}

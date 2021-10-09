import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'interaction_entity.freezed.dart';
part 'interaction_entity.g.dart';

@freezed
class Interaction with _$Interaction {
  @HiveType(typeId: 5)
  const factory Interaction({
    @HiveField(0) required String id,
    @HiveField(1) required String description,
    @HiveField(2) required String contact,
    @HiveField(3) required String type,
    @HiveField(4) required DateTime created,
    @HiveField(5) String? event,
  }) = _Interaction;

  const Interaction._();

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> interactionMap = {
      'id': id,
      'description': description,
      'contact': contact,
      'type': type,
    };
    if (event != null) interactionMap['event'] = event;
    return interactionMap;
  }

  factory Interaction.fromMap(Map<String, dynamic> map) {
    return Interaction(
        id: map['id'] as String,
        description: map['description'] as String,
        contact: map['contact'] as String,
        type: map['type'] as String,
        created: map['created'] as DateTime,
        event: map['event'] as String?);
  }
}

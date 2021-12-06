import 'package:freezed_annotation/freezed_annotation.dart';

part 'interaction_entity.freezed.dart';

@freezed
class Interaction with _$Interaction {
  const factory Interaction({
    required String id,
    required String description,
    required String contact,
    required String type,
    required DateTime created,
    String? event,
  }) = _Interaction;

  const Interaction._();

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> interactionMap = {
      'id': id,
      'created': created,
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
      event: map['event'] as String?,
    );
  }
}

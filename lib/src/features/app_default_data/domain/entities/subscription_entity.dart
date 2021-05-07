import 'package:hive/hive.dart';

part 'subscription_entity.g.dart';

@HiveType(typeId: 1)
class Subscription {
  @HiveField(0)
  final String key;
  @HiveField(1)
  final String id;
  @HiveField(2)
  final DateTime created;

  Subscription({
    required this.key,
    required this.id,
    required this.created,
  });

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'id': id,
      'created': created,
    };
  }

  factory Subscription.fromMap(Map<String, dynamic> map) {
    return Subscription(
      key: map['key'] as String,
      id: map['id'] as String ,
      created: map['created'] as DateTime,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Subscription &&
      other.key == key &&
      other.id == id &&
      other.created == created;
  }

  @override
  int get hashCode => key.hashCode ^ id.hashCode ^ created.hashCode;

  @override
  String toString() => 'Subscription(key: $key, id: $id, created: $created)';
}

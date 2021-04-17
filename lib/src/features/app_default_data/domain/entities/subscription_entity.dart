class Subscription {
  final String key;
  final String id;
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
      'created': created.millisecondsSinceEpoch,
    };
  }

  factory Subscription.fromMap(Map<String, dynamic> map) {
    return Subscription(
      key: map['key'] as String,
      id: map['id'] as String ,
      created: DateTime.fromMillisecondsSinceEpoch(map['created']as int),
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

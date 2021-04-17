class Status {
  final String id;
  final String key;
  final DateTime created;

  Status({
    required this.id,
    required this.key,
    required this.created,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'key': key,
      'created': created.millisecondsSinceEpoch,
    };
  }

  factory Status.fromMap(Map<String, dynamic> map) {
    return Status(
      id: map['id'] as String,
      key: map['key'] as String,
      created: DateTime.fromMillisecondsSinceEpoch(map['created'] as int),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Status &&
      other.id == id &&
      other.key == key &&
      other.created == created;
  }

  @override
  int get hashCode => id.hashCode ^ key.hashCode ^ created.hashCode;

  @override
  String toString() => 'Status(id: $id, key: $key, created: $created)';
}

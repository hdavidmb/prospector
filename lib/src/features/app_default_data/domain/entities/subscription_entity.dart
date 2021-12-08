import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_entity.freezed.dart';

@freezed
class Subscription with _$Subscription {
  const factory Subscription({
    required String key,
    required String id,
    required DateTime created,
  }) = _Subscription;

  const Subscription._();

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
      id: map['id'] as String,
      created: map['created'] as DateTime,
    );
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'subscription_entity.freezed.dart';

part 'subscription_entity.g.dart';

@freezed
class Subscription with _$Subscription {
  @HiveType(typeId: 1)
  const factory Subscription({
    @HiveField(0) required String key,
    @HiveField(1) required String id,
    @HiveField(2) required DateTime created,
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
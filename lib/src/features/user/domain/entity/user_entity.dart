import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'user_entity.g.dart';

part 'user_entity.freezed.dart';

@freezed
class UserEntity with _$UserEntity {
  @HiveType(typeId: 2)
  const factory UserEntity({
    @HiveField(0) required String uid,
    @HiveField(1) required String name,
    @HiveField(2) required String subscription,
    @HiveField(3) required DateTime expiryDate,
    @HiveField(4) required DateTime created,
    @HiveField(5) required DateTime modified,
    @HiveField(6) String? email,
    @HiveField(7) String? photoURL,
    @HiveField(8) String? subscriptionSKU,
    @HiveField(9) String? countryCode,
    @HiveField(10) String? dialCode,
  }) = _UserEntity;

  const UserEntity._();

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> userMap = {
      'uid': uid,
      'name': name,
      'subscription': subscription,
      'expiry_date': expiryDate,
      'created': created,
      'modified': modified,
    };
    if (email != null) userMap['email'] = email;
    if (photoURL != null) userMap['photoURL'] = photoURL;
    if (subscriptionSKU != null) userMap['subscription_sku'] = subscriptionSKU;
    if (countryCode != null) userMap['country_code'] = countryCode;
    if (dialCode != null) userMap['dial_code'] = dialCode;
    return userMap;
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      uid: map['uid'] as String,
      name: map['name'] as String,
      subscription: map['subscription'] as String,
      expiryDate: map['expiry_date'] as DateTime,
      created: map['created'] as DateTime,
      modified: map['modified'] as DateTime,
      email: map['email'] as String?,
      photoURL: map['photoURL'] as String?,
      subscriptionSKU: map['subscription_sku'] as String?,
      countryCode: map['country_code'] as String?,
      dialCode: map['dial_code'] as String?,
    );
  }
}
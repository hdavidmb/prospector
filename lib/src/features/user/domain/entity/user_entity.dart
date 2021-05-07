import 'dart:convert';

import 'package:hive/hive.dart';

part 'user_entity.g.dart';

@HiveType(typeId: 2)
class UserEntity {
  @HiveField(0)
  final String uid;
  @HiveField(1)
  String name;
  @HiveField(2)
  String subscription;
  @HiveField(3)
  DateTime expiryDate;
  @HiveField(4)
  DateTime created;
  @HiveField(5)
  DateTime modified;
  @HiveField(6)
  String? email;
  @HiveField(7)
  String? photoURL;
  @HiveField(8)
  String? subscriptionSKU;
  @HiveField(9)
  String? countryCode;
  @HiveField(10)
  String? dialCode;

  UserEntity({
    required this.uid,
    required this.name,
    required this.subscription,
    required this.expiryDate,
    required this.created,
    required this.modified,
    this.email,
    this.photoURL,
    this.subscriptionSKU,
    this.countryCode,
    this.dialCode,
  });

  UserEntity copyWith({
    String? name,
    String? subscription,
    DateTime? expiryDate,
    DateTime? created,
    DateTime? modified,
    String? email,
    String? photoURL,
    String? subscriptionSKU,
    String? countryCode,
    String? dialCode,
  }) {
    return UserEntity(
      uid: uid,
      name: name ?? this.name,
      subscription: subscription ?? this.subscription,
      expiryDate: expiryDate ?? this.expiryDate,
      created: created ?? this.created,
      modified: modified ?? this.modified,
      email: email ?? this.email,
      photoURL: photoURL ?? this.photoURL,
      subscriptionSKU: subscriptionSKU ?? this.subscriptionSKU,
      countryCode: countryCode ?? this.countryCode,
      dialCode: dialCode ?? this.dialCode,
    );
  }

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

  String toJson() => json.encode(toMap());

  factory UserEntity.fromJson(String source) =>
      UserEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserEntity &&
        other.uid == uid &&
        other.email == email &&
        other.name == name &&
        other.photoURL == photoURL &&
        other.subscription == subscription &&
        other.subscriptionSKU == subscriptionSKU &&
        other.countryCode == countryCode &&
        other.dialCode == dialCode &&
        other.expiryDate == expiryDate &&
        other.created == created &&
        other.modified == modified;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        email.hashCode ^
        name.hashCode ^
        photoURL.hashCode ^
        subscription.hashCode ^
        subscriptionSKU.hashCode ^
        countryCode.hashCode ^
        dialCode.hashCode ^
        expiryDate.hashCode ^
        created.hashCode ^
        modified.hashCode;
  }

  @override
  String toString() {
    return 'UserEntity(uid: $uid, email: $email, name: $name, photoURL: $photoURL, subscription: $subscription, subscriptionSKU: $subscriptionSKU, countryCode: $countryCode, dialCode: $dialCode, expiryDate: $expiryDate, created: $created, modified: $modified)';
  }
}

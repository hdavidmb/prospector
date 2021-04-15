import 'dart:convert';

class UserEntity {
  final String uid;
  final String name;
  final String subscription;
  final DateTime expiryDate;
  final DateTime created;
  final DateTime modified;
  final String? email;
  final String? photoURL;
  final String? subscriptionSKU;
  final String? countryCode;
  final String? dialCode;

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

  Map<String, dynamic> toMap() { //TODO organice properly given the required and optional fields
    return {
      'uid': uid,
      'name': name,
      'subscription': subscription,
      'expiry_date': expiryDate.millisecondsSinceEpoch,
      'created': created.millisecondsSinceEpoch,
      'modified': modified.millisecondsSinceEpoch,
      'email': email,
      'photo_url': photoURL,
      'subscription_sku': subscriptionSKU,
      'country_code': countryCode,
      'dial_code': dialCode,
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) { //TODO organice properly given the required and optional fields
    return UserEntity(
      uid: map['uid'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      photoURL: map['photo_url'] as String,
      subscription: map['subscription'] as String,
      subscriptionSKU: map['subscription_sku'] as String,
      countryCode: map['country_code'] as String,
      dialCode: map['dial_code'] as String,
      expiryDate:
          DateTime.fromMillisecondsSinceEpoch(map['expiry_date'] as int),
      created: DateTime.fromMillisecondsSinceEpoch(map['created'] as int),
      modified: DateTime.fromMillisecondsSinceEpoch(map['modified'] as int),
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

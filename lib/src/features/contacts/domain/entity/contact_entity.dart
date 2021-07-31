import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'contact_entity.freezed.dart';
part 'contact_entity.g.dart';

@freezed
class Contact with _$Contact {
  @HiveType(typeId: 3)
  const factory Contact({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) required String status,
    @HiveField(3) required DateTime created,
    @HiveField(4) required DateTime modified,
    @HiveField(5) String? gender,
    @HiveField(6) String? location,
    @HiveField(7) String? phone,
    @HiveField(8) String? whatsapp,
    @HiveField(9) List<String>? phones,
    @HiveField(10) String? photo,
    @HiveField(11) List<String>? tags,
    @HiveField(12) String? importedId,
  }) = _Contact;
  
  // ignore: unused_element
  const Contact._();

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> contactMap = {
      'name': name,
      'created': created,
      'modified': modified,
      'status': status,
      'id': id,
    };
    if (gender != null) contactMap['gender'] = gender;
    if (location != null) contactMap['location'] = location;
    if (phone != null) contactMap['phone'] = phone;
    if (whatsapp != null) contactMap['whatsapp'] = whatsapp;
    if (phones != null && phones!.isNotEmpty) {
      contactMap['phones'] = phones;
    } else {
      if (phone != null) {
        contactMap['phones'] = [phone];
      }
    }
    if (photo != null) contactMap['photo'] = photo;
    if (tags != null) contactMap['tags'] = tags;
    if (importedId != null) contactMap['imported_id'] = importedId;
    return contactMap;
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'] as String,
      name: map['name'] as String,
      status: map['status'] as String,
      created: map['created'] as DateTime,
      modified: map['modified'] as DateTime,
      gender: map['gender'] as String?,
      location: map['location'] as String?,
      phone: map['phone'] as String?,
      whatsapp: map['whatsapp'] as String?,
      phones: map['phones'] as List<String>?,
      photo: map['photo'] as String?,
      tags: map['tags'] as List<String>?,
      importedId: map['imported_id'] as String?,
    );
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_entity.freezed.dart';

@freezed
class Contact with _$Contact {
  const factory Contact({
    required String id,
    required String name,
    required String status,
    required DateTime created,
    required DateTime modified,
    String? gender,
    String? location,
    String? phone,
    String? whatsapp,
    List<String>? phones,
    String? photo,
    List<String>? tags,
    String? importedId,
  }) = _Contact;

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

  factory Contact.empty() => Contact(
        id: '',
        name: '',
        status: '',
        created: DateTime.now(),
        modified: DateTime.now(),
      );
}

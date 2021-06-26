import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../contacts/domain/entity/contact_entity.dart';

part 'imported_contact_entity.freezed.dart';

@freezed
class ImportedContact with _$ImportedContact {
  const factory ImportedContact(
      {required String importedID,
      required String name,
      List<String>? phones,
      @Default(false) bool selected,
      Uint8List? photo}) = _ImportedContact;

  // ignore: unused_element
  const ImportedContact._();

  factory ImportedContact.fromContact(Contact contact) {
    return ImportedContact(
      importedID: contact.importedId ?? '',
      name: contact.name,
      phones: contact.phones
    );
  }
}

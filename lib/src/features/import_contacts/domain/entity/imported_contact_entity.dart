import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'imported_contact_entity.freezed.dart';

@freezed
class ImportedContact with _$ImportedContact{
  const factory ImportedContact({
    required String importedID,
    required String name,
    List<String>? phones,
    Uint8List? photo

  }) = _ImportedContact;
}
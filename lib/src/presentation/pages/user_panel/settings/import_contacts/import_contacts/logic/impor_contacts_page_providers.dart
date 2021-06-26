import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/import_contacts/application/import_contacts_providers.dart';
import 'package:prospector/src/features/import_contacts/domain/entity/imported_contact_entity.dart';
import 'package:prospector/src/features/storage/application/storage_providers.dart';
import 'package:prospector/src/features/storage/domain/use_cases/upload_contact_image.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/import_contacts/import_contacts/logic/import_contacts_page_notifier.dart';

final importContactsPageProvider =
    ChangeNotifierProvider<ImportContactsPageNotifier>((ref) {
  final List<ImportedContact> _deviceContacts =
      ref.watch(importContactsProvider).deviceContacts;
  final UploadContactImage _uploadContactImage = ref.watch(uploadContactImage);
  return ImportContactsPageNotifier(
    deviceContacts: _deviceContacts,
    uploadContactImage: _uploadContactImage,
    read: ref.read,
  );
});

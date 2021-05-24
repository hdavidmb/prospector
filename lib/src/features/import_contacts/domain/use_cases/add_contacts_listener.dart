import 'package:prospector/src/features/import_contacts/domain/interface/i_import_contacts_repository.dart';

class AddContactsListener {
  final IImportContactsRepository importContactsRepository;
  AddContactsListener({
    required this.importContactsRepository,
  });

  void call(void Function() callback) => importContactsRepository.addContactsListener(callback);
}

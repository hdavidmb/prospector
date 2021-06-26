import '../interface/i_import_contacts_repository.dart';

class RemoveContactsListener {
  final IImportContactsRepository importContactsRepository;
  RemoveContactsListener({
    required this.importContactsRepository,
  });

  void call(void Function() callback) => importContactsRepository.removeContactsListener(callback);
}
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/instances/database_instance_provider.dart';
import '../data/local/hive_contacts_repository.dart';
import '../data/remote/firebase_contacts_repository.dart';
import '../domain/interfaces/i_contacts_local_repository.dart';
import '../domain/interfaces/i_contacts_remote_repository.dart';
import '../domain/use_cases/create_contact_document.dart';
import '../domain/use_cases/delete_contact_document.dart';
import '../domain/use_cases/get_contacts_list.dart';
import '../domain/use_cases/update_contact_document.dart';
import 'contacts_notifier.dart';

// * Repositorioes
final remoteContactsRepository = Provider<IContactsRemoteRepository>((ref) {
  return FirebaseContactsRepository(
      firestoreInstance: ref.watch(firestoreInstance));
});

final localContactsRepository = Provider<IContactsLocalRepository>((ref) {
  return HiveContactsRepository();
});

// * Use cases
final createContactDocument = Provider<CreateContactDocument>((ref) {
  final _localContactsRepository = ref.watch(localContactsRepository);
  final _remoteContactsRepository = ref.watch(remoteContactsRepository);
  return CreateContactDocument(
    localContactsRepository: _localContactsRepository,
    remoteContactsRepository: _remoteContactsRepository,
  );
});

final deleteContactDocument = Provider<DeleteContactDocument>((ref) {
  final _localContactsRepository = ref.watch(localContactsRepository);
  final _remoteContactsRepository = ref.watch(remoteContactsRepository);
  return DeleteContactDocument(
    localContactsRepository: _localContactsRepository,
    remoteContactsRepository: _remoteContactsRepository,
  );
});

final updateContactDocument = Provider<UpdateContactDocument>((ref) {
  final _localContactsRepository = ref.watch(localContactsRepository);
  final _remoteContactsRepository = ref.watch(remoteContactsRepository);
  return UpdateContactDocument(
    localContactsRepository: _localContactsRepository,
    remoteContactsRepository: _remoteContactsRepository,
  );
});

final getContactsList = Provider<GetContactsList>((ref) {
  final _localContactsRepository = ref.watch(localContactsRepository);
  final _remoteContactsRepository = ref.watch(remoteContactsRepository);
  return GetContactsList(
    localContactsRepository: _localContactsRepository,
    remoteContactsRepository: _remoteContactsRepository,
  );
});

// * Notifier
final contactsNotifierProvider =
    ChangeNotifierProvider<ContactsNotifier>((ref) {
final _createContactDocument = ref.watch(createContactDocument);
final _deleteContactDocument = ref.watch(deleteContactDocument);
final _updateContactDocument = ref.watch(updateContactDocument);
final _getContactsList = ref.watch(getContactsList);
  return ContactsNotifier(
    createContactDocument: _createContactDocument,
    deleteContactDocument: _deleteContactDocument,
    updateContactDocument: _updateContactDocument,
    getContactsList: _getContactsList,
    read: ref.read,
  );
});

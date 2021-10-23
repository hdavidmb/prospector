import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/instances/database_instance_provider.dart';
import '../../../core/user_collections/data/local/hive_user_collection_repository.dart';
import '../../../core/user_collections/data/remote/firebase_user_collection_repository.dart';
import '../../../core/user_collections/domain/interfaces/i_user_collection_local_repository.dart';
import '../../../core/user_collections/domain/interfaces/i_user_collection_remote_repository.dart';
import '../domain/contacts_use_cases.dart';
import 'contacts_notifier.dart';

// * Repositorioes
final remoteContactsRepository =
    Provider<IUserCollectionRemoteRepository>((ref) {
  return FirebaseUserCollectionRepository(
      firestoreInstance: ref.watch(firestoreInstance),
      collectionName: 'contacts');
});

final localContactsRepository = Provider<IUserCollectionLocalRepository>((ref) {
  return HiveUserCollectionRepository(collectionName: 'contacts');
});

// * Use cases
final contactsUseCases = Provider<ContactsUseCases>((ref) {
  final _localContactsRepository = ref.watch(localContactsRepository);
  final _remoteContactsRepository = ref.watch(remoteContactsRepository);
  return ContactsUseCases(
    localContactsRepository: _localContactsRepository,
    remoteContactsRepository: _remoteContactsRepository,
  );
});

// * Notifier
final contactsNotifierProvider =
    ChangeNotifierProvider<ContactsNotifier>((ref) {
  final _contactsUseCases = ref.watch(contactsUseCases);
  return ContactsNotifier(
    contactsUseCases: _contactsUseCases,
    read: ref.read,
  );
});

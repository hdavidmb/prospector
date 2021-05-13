import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:prospector/src/core/database/database_failures/database_failure.dart';
import 'package:prospector/src/features/contacts/application/contacts_state.dart';
import 'package:prospector/src/features/contacts/domain/entity/contact_entity.dart';
import 'package:prospector/src/features/contacts/domain/use_cases/create_contact_document.dart';
import 'package:prospector/src/features/contacts/domain/use_cases/delete_contact_document.dart';
import 'package:prospector/src/features/contacts/domain/use_cases/get_contacts_list.dart';
import 'package:prospector/src/features/contacts/domain/use_cases/update_contact_document.dart';
import 'package:prospector/src/features/user/application/user_info_providers.dart';

class ContactsNotifier extends ChangeNotifier {
  final CreateContactDocument createContactDocument;
  final DeleteContactDocument deleteContactDocument;
  final UpdateContactDocument updateContactDocument;
  final GetContactsList getContactsList;
  final Reader read;
  ContactsNotifier({
    required this.createContactDocument,
    required this.deleteContactDocument,
    required this.updateContactDocument,
    required this.getContactsList,
    required this.read,
  });

  ContactsState _contactsState = const ContactsState.initial();
  late List<Contact> _contacts;

  ContactsState get contactsState => _contactsState;
  List<Contact> get contacts => _contacts;

  void reset() => _contactsState = const ContactsState.initial();

  Future<Either<DatabaseFailure, Unit>> createContact(Contact contact) async {
    final uid = read(userInfoNotifierProvider).user.uid;
    final createResult =
        await createContactDocument(contact: contact, uid: uid);
    return createResult.fold(
      (failure) => left(failure),
      (unit) {
        _contacts
          ..add(contact) //TODO test insertAt(0)
          ..sort((a, b) => b.modified.compareTo(a.modified)); //TODO test order
        notifyListeners();
        return right(unit);
      },
    );
  }

  Future<void> getContacts() async {
    if (_contactsState != const ContactsState.fetching()) {
      _contactsState = const ContactsState.fetching();
      final uid = read(userInfoNotifierProvider).user.uid;
      final getResult = await getContactsList(uid: uid);
      getResult.fold(
        (failure) => _contactsState = const ContactsState.error(),
        (contactsList) {
      contactsList
          .sort((a, b) => b.modified.compareTo(a.modified));
          _contacts = contactsList;
          _contactsState = const ContactsState.ready();
        },
      );
      notifyListeners();
    }
  }

  Future<Either<DatabaseFailure, Unit>> updateContact(Contact contact) async {
    // TODO test
    // TODO if status changed create status interaction
    final uid = read(userInfoNotifierProvider).user.uid;
    final newContactInfo = contact.copyWith(modified: DateTime.now());
    final updateResult =
        await updateContactDocument(contact: newContactInfo, uid: uid);
    return updateResult.fold(
      (failure) => left(failure),
      (unit) {
        final int index = _contacts
            .indexWhere((listContact) => listContact.id == newContactInfo.id);
        _contacts[index] = newContactInfo;
        _contacts.sort((a, b) => b.modified.compareTo(a.modified));
        notifyListeners();
        return right(unit);
      },
    );
  }

  Future<Either<DatabaseFailure, Unit>> deleteContact(
      {required String contactID}) async {
    // TODO test
    // TODO delete contact interactions
    // TODO delete contact from events
    final uid = read(userInfoNotifierProvider).user.uid;
    final deleteResult =
        await deleteContactDocument(contactID: contactID, uid: uid);
    return deleteResult.fold(
      (failure) => left(failure),
      (unit) {
        _contacts.removeWhere((listContact) => listContact.id == contactID);
        notifyListeners();
        return right(unit);
      },
    );
  }
}

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_failures/database_failure.dart';
import '../../app_default_data/application/app_default_data_providers.dart';
import '../../user/application/user_info_providers.dart';
import '../domain/entity/contact_entity.dart';
import '../domain/use_cases/create_contact_document.dart';
import '../domain/use_cases/delete_contact_document.dart';
import '../domain/use_cases/get_contacts_list.dart';
import '../domain/use_cases/update_contact_document.dart';
import 'contacts_state.dart';

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
    final uid = read(userInfoNotifierProvider).user?.uid;
    if (uid != null) {
      final createResult =
          await createContactDocument(contact: contact, uid: uid);
      return createResult.fold(
        (failure) => left(failure),
        (unit) {
          _contacts
            ..add(contact) //TODO test insertAt(0)
            ..sort((a, b) => b.modified.compareTo(a.modified));
          notifyListeners();
          return right(unit);
        },
      );
    } else {
      return left(const DatabaseFailure.noUserAuthenticated());
    }
  }

  Future<void> getContacts() async {
    if (_contactsState == const ContactsState.initial()) {
      _contactsState = const ContactsState.fetching();
      final uid = read(userInfoNotifierProvider).user?.uid;
      if (uid != null) {
        final getResult = await getContactsList(uid: uid);
        getResult.fold(
          (failure) => _contactsState = const ContactsState.error(),
          (contactsList) {
            contactsList.sort((a, b) => b.modified.compareTo(a.modified));
            _contacts = contactsList;
            _contactsState = const ContactsState.ready();
          },
        );
      } else {
        _contactsState = const ContactsState.error();
      }
      notifyListeners();
    }
  }

  Future<Either<DatabaseFailure, Unit>> updateContact(Contact contact,
      {bool removingDeletedTag = false}) async {
    // TODO if status changed create status interaction
    final uid = read(userInfoNotifierProvider).user?.uid;

    if (uid != null) {
      final newContactInfo = removingDeletedTag
          ? contact
          : contact.copyWith(modified: DateTime.now());
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
    } else {
      return left(const DatabaseFailure.noUserAuthenticated());
    }
  }

  void deleteTagFromContacts({required String tagID}) {
    for (final Contact contact in _contacts) {
      if (contact.tags != null && contact.tags!.contains(tagID)) {
        final newContactInfo = contact.copyWith();
        newContactInfo.tags!.remove(tagID);
        updateContact(newContactInfo, removingDeletedTag: true);
      }
    }
  }

  Future<Either<DatabaseFailure, Unit>> deleteContact(
      {required String contactID}) async {
    // TODO delete contact interactions
    // TODO delete contact from events
    final uid = read(userInfoNotifierProvider).user?.uid;
    if (uid != null) {
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
    } else {
      return left(const DatabaseFailure.noUserAuthenticated());
    }
  }

  // ************ FILTERS ***************
  String _genderFilter = '';
  String _locationFilter = '';
  List<String> _tagsFilter = [];

  String get genderFilter => _genderFilter;
  String get locationFilter => _locationFilter;
  List<String> get tagsFilter => _tagsFilter;

  bool get isFiltered =>
      _genderFilter.isNotEmpty ||
      _locationFilter.isNotEmpty ||
      _tagsFilter.isNotEmpty;

  void setFilters({String? gender, String? location, List<String>? tags}) {
    if (gender != null) _genderFilter = gender;
    if (location != null) _locationFilter = location;
    if (tags != null) _tagsFilter = tags;
    notifyListeners();
  }

  void clearFilters() {
    _genderFilter = '';
    _locationFilter = '';
    _tagsFilter = [];
    notifyListeners();
  }

  List<Contact> get filteredContacts => _contacts
      .where(
        (contact) =>
            (_genderFilter.isEmpty || contact.gender == _genderFilter) &&
            (_locationFilter.isEmpty || contact.location == _locationFilter) &&
            (_tagsFilter.isEmpty ||
                (contact.tags != null &&
                    _tagsFilter.every(
                        (filterTag) => contact.tags!.contains(filterTag)))),
      )
      .toList();

  List<Object> get notContactedContacts {
    final notContactedID = read(appDefaultDataProvider).notContactedID;
    final _notContactedContacts = _contacts
        .where(
          (contact) =>
              (contact.status == notContactedID) &&
              (_genderFilter.isEmpty || contact.gender == _genderFilter) &&
              (_locationFilter.isEmpty ||
                  contact.location == _locationFilter) &&
              (_tagsFilter.isEmpty ||
                  (contact.tags != null &&
                      _tagsFilter.every(
                          (filterTag) => contact.tags!.contains(filterTag)))),
        )
        .toList();

    return _notContactedContacts;
  }

  List<Object> get notInterestedContacts {
    final notInterestedID = read(appDefaultDataProvider).notInterestedID;
    return _contacts
        .where(
          (contact) =>
              (contact.status == notInterestedID) &&
              (_genderFilter.isEmpty || contact.gender == _genderFilter) &&
              (_locationFilter.isEmpty ||
                  contact.location == _locationFilter) &&
              (_tagsFilter.isEmpty ||
                  (contact.tags != null &&
                      _tagsFilter.every(
                          (filterTag) => contact.tags!.contains(filterTag)))),
        )
        .toList();
  }

  List<Object> get invitedContacts {
    final invitedID = read(appDefaultDataProvider).invitedID;
    return _contacts
        .where(
          (contact) =>
              (contact.status == invitedID) &&
              (_genderFilter.isEmpty || contact.gender == _genderFilter) &&
              (_locationFilter.isEmpty ||
                  contact.location == _locationFilter) &&
              (_tagsFilter.isEmpty ||
                  (contact.tags != null &&
                      _tagsFilter.every(
                          (filterTag) => contact.tags!.contains(filterTag)))),
        )
        .toList();
  }

  List<Object> get followUpContacts {
    final followUpID = read(appDefaultDataProvider).followUpID;
    return _contacts
        .where(
          (contact) =>
              (contact.status == followUpID) &&
              (_genderFilter.isEmpty || contact.gender == _genderFilter) &&
              (_locationFilter.isEmpty ||
                  contact.location == _locationFilter) &&
              (_tagsFilter.isEmpty ||
                  (contact.tags != null &&
                      _tagsFilter.every(
                          (filterTag) => contact.tags!.contains(filterTag)))),
        )
        .toList();
  }

  List<Object> get clientContacts {
    final clientID = read(appDefaultDataProvider).clientID;
    return _contacts
        .where(
          (contact) =>
              (contact.status == clientID) &&
              (_genderFilter.isEmpty || contact.gender == _genderFilter) &&
              (_locationFilter.isEmpty ||
                  contact.location == _locationFilter) &&
              (_tagsFilter.isEmpty ||
                  (contact.tags != null &&
                      _tagsFilter.every(
                          (filterTag) => contact.tags!.contains(filterTag)))),
        )
        .toList();
  }

  List<Object> get executiveContacts {
    final executiveID = read(appDefaultDataProvider).executiveID;
    return _contacts
        .where(
          (contact) =>
              (contact.status == executiveID) &&
              (_genderFilter.isEmpty || contact.gender == _genderFilter) &&
              (_locationFilter.isEmpty ||
                  contact.location == _locationFilter) &&
              (_tagsFilter.isEmpty ||
                  (contact.tags != null &&
                      _tagsFilter.every(
                          (filterTag) => contact.tags!.contains(filterTag)))),
        )
        .toList();
  }

  // ************ SEARCH ***************
  String _searchText = '';
  bool _isSearchBarShowing = false;

  bool get isSearchBarShowing => _isSearchBarShowing;
  bool get isSearchTextEmpty => _searchText.isEmpty;

  void search({required String searchText}) {
    _searchText = searchText;
    notifyListeners();
  }

  void showSearchBar() {
    _isSearchBarShowing = true;
    notifyListeners();
  }

  void cancelSearch() {
    _isSearchBarShowing = false;
    _searchText = '';
    notifyListeners();
  }

  List<Contact> get searchingContacts => _contacts
      .where(
        (contact) =>
            _searchText.isEmpty ||
            contact.name.toLowerCase().contains(_searchText.toLowerCase()),
      )
      .toList();
}

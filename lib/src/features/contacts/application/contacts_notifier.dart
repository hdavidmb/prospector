import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/events/application/events_providers.dart';

import '../../../core/database/database_failures/database_failure.dart';
import '../../app_default_data/application/app_default_data_providers.dart';
import '../../interactions/application/interactions_providers.dart';
import '../../user/application/user_info_providers.dart';
import '../domain/contacts_use_cases.dart';
import '../domain/entity/contact_entity.dart';
import 'contacts_state.dart';

class ContactsNotifier extends ChangeNotifier {
  final ContactsUseCases contactsUseCases;
  final Reader read;
  ContactsNotifier({
    required this.contactsUseCases,
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
          await contactsUseCases.createContact(contact: contact, uid: uid);
      return createResult.fold(
        (failure) => left(failure),
        (unit) {
          _contacts.insert(0, contact);
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
        final getResult = await contactsUseCases.getContactsList(uid: uid);
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
    final uid = read(userInfoNotifierProvider).user?.uid;

    if (uid != null) {
      final newContactInfo = removingDeletedTag
          ? contact
          : contact.copyWith(modified: DateTime.now());
      final updateResult = await contactsUseCases.updateContact(
          contact: newContactInfo, uid: uid);
      return updateResult.fold(
        (failure) => left(failure),
        (unit) async {
          final int index = _contacts
              .indexWhere((listContact) => listContact.id == newContactInfo.id);
          if (_contacts[index].status != newContactInfo.status) {
            await read(interactionsNotifierProvider)
                .createStatusInteraction(contact: newContactInfo);
          }
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
    final uid = read(userInfoNotifierProvider).user?.uid;
    if (uid != null) {
      final deleteResult =
          await contactsUseCases.deleteContact(contactID: contactID, uid: uid);
      return deleteResult.fold(
        (failure) => left(failure),
        (unit) {
          read(interactionsNotifierProvider)
              .deleteContactInteractions(contactID: contactID);
          _contacts.removeWhere((listContact) => listContact.id == contactID);
          read(eventsNotifierProvider)
              .removeContactFromAllEvents(contactID: contactID);
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

  List<Contact> get searchingContacts =>
      searchContactsByName(query: _searchText);

  List<Contact> searchContactsByName({required String query}) {
    final _filteredSearchContacts = _contacts
        .where(
          (contact) =>
              query.isNotEmpty &&
              contact.name.toLowerCase().trim().split(' ').any(
                    (word) => word.startsWith(
                      query.toLowerCase().trim(),
                    ),
                  ),
        )
        .toList();
    _filteredSearchContacts.sort((a, b) => a.name.compareTo(b.name));
    return _filteredSearchContacts;
  }
}

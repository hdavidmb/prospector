import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../features/app_default_data/application/app_default_data_providers.dart';
import '../../../../../../features/contacts/application/contacts_providers.dart';
import '../../../../../../features/contacts/domain/entity/contact_entity.dart';
import '../../../../../core/dialogs.dart';

class ContactDetailsNotifier {
  final Reader read;
  ContactDetailsNotifier({
    required this.read,
  });

  Future<void> backwardActionButtonPressed({required Contact contact}) async {
    final notInterestedID = read(appDefaultDataProvider).notInterestedID;
    final notContactedID = read(appDefaultDataProvider).notContactedID;
    final newStatus =
        contact.status == notInterestedID ? notContactedID : notInterestedID;
    read(contactsNotifierProvider)
        .updateContact(contact.copyWith(status: newStatus));
  }

  Future<void> forewardActionButtonPressed(
      {required BuildContext context, required Contact contact}) async {
    final invitedID = read(appDefaultDataProvider).invitedID;
    final followUpID = read(appDefaultDataProvider).followUpID;
    final clientID = read(appDefaultDataProvider).clientID;
    final executiveID = read(appDefaultDataProvider).executiveID;
    String newStatus = executiveID;
    if (contact.status == executiveID) {
      return;
    } else if (contact.status == clientID) {
      newStatus = executiveID;
    } else if (contact.status == followUpID) {
      final result =
          await showAffiliationDialog(context: context, gender: contact.gender);
      if (result.isNone()) return;
      result.fold(() => null, (newStatusId) => newStatus = newStatusId);
    } else if (contact.status == invitedID) {
      newStatus = followUpID;
    } else {
      newStatus = invitedID;
    }
    read(contactsNotifierProvider)
        .updateContact(contact.copyWith(status: newStatus));
  }
}

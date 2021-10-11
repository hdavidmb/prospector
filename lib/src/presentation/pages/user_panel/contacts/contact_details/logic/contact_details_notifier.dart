import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_string/random_string.dart';

import '../../../../../../features/app_default_data/application/app_default_data_providers.dart';
import '../../../../../../features/contacts/application/contacts_providers.dart';
import '../../../../../../features/contacts/domain/entity/contact_entity.dart';
import '../../../../../../features/interactions/application/interactions_providers.dart';
import '../../../../../../features/interactions/domain/entity/interaction_entity.dart';
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

  Future<bool> interactionSubmitButtonPressed(
      {required String description, required String contactID}) async {
    //TODO create submittingstate to disable buttons when submitting
    final Interaction interaction = Interaction(
        id: randomAlphaNumeric(20),
        description: description,
        contact: contactID,
        type: 'user',
        created: DateTime.now());
    final createResult =
        await read(interactionsNotifierProvider).createInteraction(interaction);
    return createResult.isRight();
  }
}

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/generated/l10n.dart';
import 'package:prospector/src/features/user/application/user_info_providers.dart';
import 'package:random_string/random_string.dart';
import 'package:url_launcher/url_launcher.dart';

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
      {required String description, required Contact contact}) async {
    //TODO create submittingstate to disable buttons when submitting
    final Interaction interaction = Interaction(
        id: randomAlphaNumeric(20),
        description: description,
        contact: contact.id,
        type: 'user',
        created: DateTime.now());
    final createResult = await read(interactionsNotifierProvider)
        .createInteraction(interaction, contact: contact);
    return createResult.isRight();
  }

  Future<void> callTextButtonPressed(
      {required BuildContext context,
      required Contact contact,
      required bool isTexting}) async {
    final isPremium = read(userInfoNotifierProvider).isPremiumUser;
    if (isPremium) {
      final String? dialCode = read(userInfoNotifierProvider).user!.dialCode;
      final bool hasDialCode = dialCode != null && dialCode.isNotEmpty;
      if (!isTexting || (isTexting && hasDialCode)) {
        //TODO check or ask for textingApp (whatsapp or iOSmessenger)
        if (contact.phones != null && contact.phones!.isNotEmpty) {
          String? contactNumber = isTexting ? contact.whatsapp : contact.phone;
          if (contactNumber == null || contactNumber.isEmpty) {
            final Option<String> selection = await showOptionsSelectionDialog(
                context: context,
                options: contact.phones!,
                title: AppLocalizations.current.selectANumber,
                dismissible: false);
            selection.fold(
              () => null,
              (number) async {
                final Contact newContactInfo = isTexting
                    ? contact.copyWith(whatsapp: number)
                    : contact.copyWith(phone: number);
                read(contactsNotifierProvider).updateContact(newContactInfo);
                contactNumber = number;
              },
            );
          }
          final bool success = await _performContactAction(
              number: contactNumber!,
              dialCode: dialCode!,
              isTexting: isTexting);
          if (!success) {
            Future.delayed(
                Duration.zero,
                () => showSnackBar(
                    context: context,
                    message: AppLocalizations.current.serverError,
                    type: SnackbarType.failure));
          }
        } else {
          showMessageDialog(
              context: context,
              title: AppLocalizations.current.noPhonesTitle,
              message: AppLocalizations.current.noPhonesMessage);
        }
      } else {
        //TODO request dialCode
        print('Request dial code');
      }
    } else {
      showPremiumDialog(context: context);
    }
  }

  Future<bool> _performContactAction(
      {required String number,
      required String dialCode,
      required bool isTexting}) async {
    //TODO delete final completeNumber = number[0] == '+' ? number : '$dialCode $number';

    final urlNumber =
        number[0] == '+' ? number : '$dialCode $number'; //TODO test on android
    // TODO delete isWhatsapp
    //     ? completeNumber.replaceAll(RegExp(r'$[^0-9]'), '')
    //     : completeNumber;

    // TODO delete ? number.replaceAll(RegExp(r'[^0-9]'), '')
    // : dialCode.replaceAll(RegExp(r'[^0-9]'), '') +
    //     number.replaceAll(RegExp(r'[^0-9]'), '');

    final String baseUrl = isTexting
        ? Platform.isIOS
            ? "whatsapp://wa.me/"
            : "whatsapp://send?phone="
        : "tel:";

    final url = Uri.encodeFull("$baseUrl$urlNumber"); //TODO test on android

    // TODO delete final String url = isTexting
    //     ? Platform.isIOS
    //         ? Uri.encodeFull("whatsapp://wa.me/$urlNumber")
    //         : "whatsapp://send?phone=$urlNumber"
    //     : Uri.encodeFull("tel:$urlNumber"); //TODO test on android

    if (await canLaunch(url)) {
      try {
        launch(url); //TODO test on android
        return true;
      } catch (error) {
        return false;
      }
    } else {
      return false;
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/generated/l10n.dart';
import 'package:prospector/src/features/app_default_data/application/app_default_data_providers.dart';
import 'package:prospector/src/features/contacts/application/contacts_providers.dart';
import 'package:prospector/src/features/contacts/domain/entity/contact_entity.dart';
import 'package:random_string/random_string.dart';

import '../../../core/database/database_failures/database_failure.dart';
import '../../user/application/user_info_providers.dart';
import '../domain/entity/interaction_entity.dart';
import '../domain/use_cases/create_interaction_document.dart';
import '../domain/use_cases/delete_interaction_document.dart';
import '../domain/use_cases/get_interactions_list.dart';
import '../domain/use_cases/update_interaction_document.dart';
import 'interactions_state.dart';

class InteractionsNotifier extends ChangeNotifier {
  final CreateInteractionDocument createInteractionDocumentUC;
  final DeleteInteractionDocument deleteInteractionDocumentUC;
  final UpdateInteractionDocument updateInteractionDocumentUC;
  final GetInteractionsList getInteractionsListUC;
  final Reader read;
  InteractionsNotifier({
    required this.createInteractionDocumentUC,
    required this.deleteInteractionDocumentUC,
    required this.updateInteractionDocumentUC,
    required this.getInteractionsListUC,
    required this.read,
  });

  InteractionsState _interactionsState = const InteractionsState.initial();
  late List<Interaction> _interactions;

  InteractionsState get interactionsState => _interactionsState;
  List<Interaction> get interactions => _interactions;

  void reset() => _interactionsState = const InteractionsState.initial();

  Future<Either<DatabaseFailure, Unit>> createInteraction(
      Interaction interaction,
      {required Contact contact}) async {
    final uid = read(userInfoNotifierProvider).user?.uid;
    if (uid != null) {
      final createResult =
          await createInteractionDocumentUC(interaction: interaction, uid: uid);

      return createResult.fold(
        (failure) => left(failure),
        (_) {
          _interactions
            ..add(interaction)
            ..sort((a, b) => b.created.compareTo(a.created));
          notifyListeners();
          if (interaction.type != 'status') {
            read(contactsNotifierProvider).updateContact(contact);
          }
          return right(unit);
        },
      );
    } else {
      return left(const DatabaseFailure.noUserAuthenticated());
    }
  }

  Future<Either<DatabaseFailure, Unit>> createStatusInteraction(
      {required Contact contact}) {
    final String statusText = read(appDefaultDataProvider)
        .getStatusText(statusID: contact.status, isPlural: true);
    final String movedTo = contact.gender == 'female'
        ? AppLocalizations.current.movedToF
        : AppLocalizations.current.movedToM;
    final Interaction interaction = Interaction(
      id: randomAlphaNumeric(20),
      description: '$movedTo $statusText',
      contact: contact.id,
      type: 'status',
      created: DateTime.now(),
    );
    return createInteraction(interaction, contact: contact);
  }

  Future<void> getInteractions() async {
    if (_interactionsState == const InteractionsState.initial()) {
      _interactionsState = const InteractionsState.fetching();
      final uid = read(userInfoNotifierProvider).user?.uid;
      if (uid != null) {
        final getResult = await getInteractionsListUC(uid: uid);
        getResult.fold(
          (failure) => _interactionsState = const InteractionsState.error(),
          (interactionsList) {
            interactionsList.sort((a, b) =>
                b.created.compareTo(a.created)); //TODO check sort order
            _interactions = interactionsList;
            _interactionsState = const InteractionsState.ready();
          },
        );
      } else {
        _interactionsState = const InteractionsState.error();
      }
      notifyListeners();
    }
  }

  Future<Either<DatabaseFailure, Unit>> updateInteraction(
      Interaction interaction) async {
    final uid = read(userInfoNotifierProvider).user?.uid;

    if (uid != null) {
      final updateResult =
          await updateInteractionDocumentUC(interaction: interaction, uid: uid);
      return updateResult.fold(
        (failure) => left(failure),
        (unit) {
          final int index = _interactions.indexWhere(
              (listInteraction) => listInteraction.id == interaction.id);
          _interactions[index] = interaction;
          _interactions.sort((a, b) => b.created.compareTo(a.created));
          notifyListeners();
          return right(unit);
        },
      );
    } else {
      return left(const DatabaseFailure.noUserAuthenticated());
    }
  }

  Future<Either<DatabaseFailure, Unit>> deleteInteraction(
      {required String interactionID}) async {
    //TODO delete contact from event if it's event interaction
    final uid = read(userInfoNotifierProvider).user?.uid;

    if (uid != null) {
      final deleteResult = await deleteInteractionDocumentUC(
          interactionID: interactionID, uid: uid);
      return deleteResult.fold(
        (failure) => left(failure),
        (unit) {
          _interactions.removeWhere(
              (listInteraction) => listInteraction.id == interactionID);
          notifyListeners();
          return right(unit);
        },
      );
    } else {
      return left(const DatabaseFailure.noUserAuthenticated());
    }
  }

  Future<Either<DatabaseFailure, Unit>> deleteContactInteractions(
      {required String contactID}) async {
    Either<DatabaseFailure, Unit> deleteResult = right(unit);
    final List<Interaction> contactInteractions = _interactions
        .where((interaction) => interaction.contact == contactID)
        .toList();
    for (final Interaction interaction in contactInteractions) {
      deleteResult = await deleteInteraction(interactionID: interaction.id);
      if (deleteResult.isLeft()) break;
    }
    return deleteResult;
  }
}

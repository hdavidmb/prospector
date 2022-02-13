import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_string/random_string.dart';

import '../../../../generated/l10n.dart';
import '../../../core/database/database_failures/database_failure.dart';
import '../../../core/fetch_state/fetch_state.dart';
import '../../app_default_data/application/app_default_data_providers.dart';
import '../../contacts/application/contacts_providers.dart';
import '../../contacts/domain/entity/contact_entity.dart';
import '../../user/application/user_info_providers.dart';
import '../domain/entity/interaction_entity.dart';
import '../domain/interactions_use_cases.dart';

class InteractionsNotifier extends ChangeNotifier {
  final InteractionsUseCases interactionsUseCases;
  final Reader read;
  InteractionsNotifier({
    required this.interactionsUseCases,
    required this.read,
  });

  FetchState _interactionsState = const FetchState.initial();
  late List<Interaction> _interactions;

  FetchState get interactionsState => _interactionsState;
  List<Interaction> get interactions => _interactions;

  void reset() => _interactionsState = const FetchState.initial();

  Future<Either<DatabaseFailure, Unit>> createInteraction(
      Interaction interaction,
      {required Contact contact}) async {
    final uid = read(userInfoNotifierProvider).user?.uid;
    if (uid != null) {
      final createResult = await interactionsUseCases.createInteraction(
          interaction: interaction, uid: uid);

      return createResult.fold(
        (failure) => left(failure),
        (_) {
          _interactions
            ..add(interaction)
            ..sort((a, b) => b.created.compareTo(a.created));
          notifyListeners();
          if (interaction.type != 'status') {
            //TODO: check if can delete this because it will never be status from where the method is being called
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
    if (_interactionsState.isInitial) {
      _interactionsState = const FetchState.fetching();
      final uid = read(userInfoNotifierProvider).user?.uid;
      if (uid != null) {
        final getResult =
            await interactionsUseCases.getInteractionsList(uid: uid);
        getResult.fold(
          (failure) => _interactionsState = const FetchState.error(),
          (interactionsList) {
            interactionsList.sort((a, b) => b.created.compareTo(a.created));
            _interactions = interactionsList;
            _interactionsState = const FetchState.ready();
          },
        );
      } else {
        _interactionsState = const FetchState.error();
      }
      notifyListeners();
    }
  }

  Future<Either<DatabaseFailure, Unit>> updateInteraction(
      Interaction interaction) async {
    final uid = read(userInfoNotifierProvider).user?.uid;

    if (uid != null) {
      final updateResult = await interactionsUseCases.updateInteraction(
          interaction: interaction, uid: uid);
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
    final uid = read(userInfoNotifierProvider).user?.uid;

    if (uid != null) {
      final deleteResult = await interactionsUseCases.deleteInteraction(
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

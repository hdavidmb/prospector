import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/core/fetch_state/fetch_state.dart';

import '../../../core/database/database_failures/database_failure.dart';
import '../../contacts/application/contacts_providers.dart';
import '../../user/application/user_info_providers.dart';
import '../domain/entity/tag_entity.dart';
import '../domain/tags_use_cases.dart';

class TagsNotifier extends ChangeNotifier {
  final TagsUseCases tagsUseCases;
  final Reader read;
  TagsNotifier({
    required this.tagsUseCases,
    required this.read,
  });

  FetchState _tagsState = const FetchState.initial();
  late List<Tag> _tags;

  FetchState get tagsState => _tagsState;
  List<Tag> get tags => _tags;

  void reset() => _tagsState = const FetchState.initial();

  Future<Either<DatabaseFailure, Unit>> createTag(Tag tag) async {
    final uid = read(userInfoNotifierProvider).user?.uid;
    if (uid != null) {
      final createResult = await tagsUseCases.createTag(tag: tag, uid: uid);
      return createResult.fold(
        (failure) => left(failure),
        (unit) {
          _tags.add(tag);
          notifyListeners();
          return right(unit);
        },
      );
    } else {
      return left(const DatabaseFailure.noUserAuthenticated());
    }
  }

  Future<void> getTags() async {
    if (!_tagsState.isFetching) {
      _tagsState = const FetchState.fetching();
      final uid = read(userInfoNotifierProvider).user?.uid;
      if (uid != null) {
        final getResult = await tagsUseCases.getTagsList(uid: uid);
        getResult.fold(
          (failure) => _tagsState = const FetchState.error(),
          (tagsList) {
            _tags = tagsList;
            _tagsState = const FetchState.ready();
          },
        );
      } else {
        _tagsState = const FetchState.error();
      }
      notifyListeners();
    }
  }

  Future<Either<DatabaseFailure, Unit>> deleteTag(
      {required String tagID}) async {
    final uid = read(userInfoNotifierProvider).user?.uid;
    if (uid != null) {
      final deleteResult = await tagsUseCases.deleteTag(tagID: tagID, uid: uid);
      return deleteResult.fold(
        (failure) => left(failure),
        (unit) {
          _tags.removeWhere((listTag) => listTag.id == tagID);
          read(contactsNotifierProvider).deleteTagFromContacts(tagID: tagID);
          notifyListeners();
          return right(unit);
        },
      );
    } else {
      return left(const DatabaseFailure.noUserAuthenticated());
    }
  }
}

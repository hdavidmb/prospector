import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:prospector/src/features/tags/domain/tags_use_cases.dart';

import '../../../core/database/database_failures/database_failure.dart';
import '../../contacts/application/contacts_providers.dart';
import '../../user/application/user_info_providers.dart';
import '../domain/entity/tag_entity.dart';
import '../domain/use_cases/create_tag_document.dart';
import '../domain/use_cases/delete_tag_document.dart';
import '../domain/use_cases/get_tags_list.dart';
import 'tags_state.dart';

class TagsNotifier extends ChangeNotifier {
  // final CreateTagDocument createTagDocument;
  // final DeleteTagDocument deleteTagDocument;
  // final GetTagsList getTagsList;
  // final Reader read;
  // TagsNotifier({
  //   required this.createTagDocument,
  //   required this.deleteTagDocument,
  //   required this.getTagsList,
  //   required this.read,
  // });
  final TagsUseCases tagsUseCases;
  final Reader read;
  TagsNotifier({
    required this.tagsUseCases,
    required this.read,
  });

  TagsState _tagsState = const TagsState.initial();
  late List<Tag> _tags;

  TagsState get tagsState => _tagsState;
  List<Tag> get tags => _tags;

  void reset() => _tagsState = const TagsState.initial();

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
    if (_tagsState != const TagsState.fetching()) {
      _tagsState = const TagsState.fetching();
      final uid = read(userInfoNotifierProvider).user?.uid;
      if (uid != null) {
        final getResult = await tagsUseCases.getTagsList(uid: uid);
        getResult.fold(
          (failure) => _tagsState = const TagsState.error(),
          (tagsList) {
            _tags = tagsList;
            _tagsState = const TagsState.ready();
          },
        );
      } else {
        _tagsState = const TagsState.error();
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

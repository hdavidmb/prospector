import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/core/database/database_failures/database_failure.dart';
import 'package:prospector/src/features/contacts/application/contacts_providers.dart';
import 'package:prospector/src/features/tags/application/tags_state.dart';
import 'package:prospector/src/features/tags/domain/entity/tag_entity.dart';

import 'package:prospector/src/features/tags/domain/use_cases/create_tag_document.dart';
import 'package:prospector/src/features/tags/domain/use_cases/delete_tag_document.dart';
import 'package:prospector/src/features/tags/domain/use_cases/get_tags_list.dart';
import 'package:prospector/src/features/user/application/user_info_providers.dart';

class TagsNotifier extends ChangeNotifier {
  final CreateTagDocument createTagDocument;
  final DeleteTagDocument deleteTagDocument;
  final GetTagsList getTagsList;
  final Reader read;
  TagsNotifier({
    required this.createTagDocument,
    required this.deleteTagDocument,
    required this.getTagsList,
    required this.read,
  });

  TagsState _tagsState = const TagsState.initial();
  late List<Tag> _tags;

  TagsState get tagsState => _tagsState;
  List<Tag> get tags => _tags;

  void reset() => _tagsState = const TagsState.initial();

  Future<Either<DatabaseFailure, Unit>> createTag(Tag tag) async {
    final uid = read(userInfoNotifierProvider).user.uid;
    final createResult = await createTagDocument(tag: tag, uid: uid);
    return createResult.fold(
      (failure) => left(failure),
      (unit) {
        _tags.add(tag);
        notifyListeners();
        return right(unit);
      },
    );
  }

  Future<void> getTags() async {
    if (_tagsState != const TagsState.fetching()) {
      _tagsState = const TagsState.fetching();
      final uid = read(userInfoNotifierProvider).user.uid;
      final getResult = await getTagsList(uid: uid);
      getResult.fold(
        (failure) => _tagsState = const TagsState.error(),
        (tagsList) {
          _tags = tagsList;
          _tagsState = const TagsState.ready();
        },
      );
      notifyListeners();
    }
  }

  Future<Either<DatabaseFailure, Unit>> deleteTag(
      {required String tagID}) async {
    final uid = read(userInfoNotifierProvider).user.uid;
    final deleteResult = await deleteTagDocument(tagID: tagID, uid: uid);
    return deleteResult.fold(
      (failure) => left(failure),
      (unit) {
        _tags.removeWhere((listTag) => listTag.id == tagID);
        read(contactsNotifierProvider).deleteTagFromContacts(tagID: tagID);
        notifyListeners();
        return right(unit);
      },
    );
  }
}

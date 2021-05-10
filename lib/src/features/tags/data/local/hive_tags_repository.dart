import 'package:hive/hive.dart';
import 'package:dartz/dartz.dart';
import 'package:prospector/src/features/tags/domain/entity/tag_entity.dart';
import 'package:prospector/src/core/database/database_failures/database_failure.dart';
import 'package:prospector/src/features/tags/domain/interfaces/i_tags_local_repository.dart';

class HiveTagsRepository implements ITagsLocalRepository {
  @override
  Future<Either<DatabaseFailure, Unit>> createTagDocument(
      {required Tag tag, required String uid}) async {
    try {
      if (!Hive.isBoxOpen('$uid-tags')) await Hive.openBox<Tag>('$uid-tags');
      await Hive.box<Tag>('$uid-tags').put(tag.id, tag);
      return right(unit);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }

  @override
  Future<Either<DatabaseFailure, Unit>> deleteTagDocument(
      {required String tagID, required String uid}) async {
    try {
      if (!Hive.isBoxOpen('$uid-tags')) await Hive.openBox<Tag>('$uid-tags');
      await Hive.box<Tag>('$uid-tags').delete(tagID);
      return right(unit);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }

  @override
  Future<Either<DatabaseFailure, List<Tag>>> getTagsList(
      {required String uid}) async {
    try {
      if (!Hive.isBoxOpen('$uid-tags')) await Hive.openBox<Tag>('$uid-tags');
      final tags = Hive.box<Tag>('$uid-tags').values.toList();
      return right(tags);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }

  @override
  Future<Either<DatabaseFailure, bool>> tagsCollectionExists(
      {required String uid}) async {
    try {
      final bool exists = await Hive.boxExists('$uid-tags');
      return right(exists);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }
}

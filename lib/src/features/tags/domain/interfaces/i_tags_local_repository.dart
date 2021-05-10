import 'package:dartz/dartz.dart';
import 'package:prospector/src/core/database/database_failures/database_failure.dart';
import 'package:prospector/src/features/tags/domain/entity/tag_entity.dart';

abstract class ITagsLocalRepository {
  // Check existance
  Future<Either<DatabaseFailure, bool>> tagsCollectionExists({required String uid});
  // CRUD
  Future<Either<DatabaseFailure, Unit>> createTagDocument({required Tag tag, required String uid});
  Future<Either<DatabaseFailure, List<Tag>>> getTagsList({required String uid});
  Future<Either<DatabaseFailure, Unit>> deleteTagDocument({required String tagID, required String uid});
}
import 'package:dartz/dartz.dart';

import '../../../../core/database/database_failures/database_failure.dart';
import '../entity/tag_entity.dart';

abstract class ITagsRemoteRepository {
  Future<Either<DatabaseFailure, Unit>> createTagDocument({required Tag tag, required String uid});
  Future<Either<DatabaseFailure, List<Tag>>> getTagsList({required String uid});
  Future<Either<DatabaseFailure, Unit>> deleteTagDocument({required String tagID, required String uid});
}
import 'package:dartz/dartz.dart';
import 'package:prospector/src/core/database/database_failures/database_failure.dart';

abstract class ILastImportIdentifiersRepository {
  Future<Either<DatabaseFailure, List<String>>> getLastImportIdentifiers(
      {required String uid});
  Future<Either<DatabaseFailure, Unit>> saveIdentifiersList(
      {required List<String> identifiers, required String uid});
  Future<Either<DatabaseFailure, Unit>> saveSingleIdentifier(
      {required String identifier, required String uid});
}

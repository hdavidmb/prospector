import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

import '../../../core/database/database_failures/database_failure.dart';
import '../domain/interface/i_last_import_identifiers_repository.dart';

class HiveLastImportRepository implements ILastImportIdentifiersRepository {
  @override
  Future<Either<DatabaseFailure, List<String>>> getLastImportIdentifiers(
      {required String uid}) async {
    try {
      if (!Hive.isBoxOpen('$uid-last_import')) await Hive.openBox<String>('$uid-last_import');
      final identifiers = Hive.box<String>('$uid-last_import').values.toList();
      return right(identifiers);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }

  @override
  Future<Either<DatabaseFailure, Unit>> saveIdentifiersList(
      {required List<String> identifiers, required String uid}) async {
    try {
      if (!Hive.isBoxOpen('$uid-last_import')) await Hive.openBox<String>('$uid-last_import');
      await Hive.box<String>('$uid-last_import').addAll(identifiers);
      return right(unit);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }

  @override
  Future<Either<DatabaseFailure, Unit>> saveSingleIdentifier(
      {required String identifier, required String uid}) async {
    try {
      if (!Hive.isBoxOpen('$uid-last_import')) await Hive.openBox<String>('$uid-last_import');
      await Hive.box<String>('$uid-last_import').add(identifier);
      return right(unit);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }
}

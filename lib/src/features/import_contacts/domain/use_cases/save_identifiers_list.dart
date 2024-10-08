import 'package:dartz/dartz.dart';

import '../../../../core/database/database_failures/database_failure.dart';
import '../interface/i_last_import_identifiers_repository.dart';

class SaveIdentifiersList {
  final ILastImportIdentifiersRepository lastImportIdentifiersRepository;
  SaveIdentifiersList({
    required this.lastImportIdentifiersRepository,
  });

  Future<Either<DatabaseFailure, Unit>> call(
          {required List<String> identifiers, required String uid}) =>
      lastImportIdentifiersRepository.saveIdentifiersList(
          identifiers: identifiers, uid: uid);
}

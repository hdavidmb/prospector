import 'package:dartz/dartz.dart';

import '../../../../core/database/database_failures/database_failure.dart';
import '../interface/i_last_import_identifiers_repository.dart';

class GetLastImportIdentifiers {
  final ILastImportIdentifiersRepository lastImportIdentifiersRepository;
  GetLastImportIdentifiers({
    required this.lastImportIdentifiersRepository,
  });

  Future<Either<DatabaseFailure, List<String>>> call({required String uid}) =>
      lastImportIdentifiersRepository.getLastImportIdentifiers(uid: uid);
}

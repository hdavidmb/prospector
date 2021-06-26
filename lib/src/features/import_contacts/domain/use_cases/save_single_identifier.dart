import 'package:dartz/dartz.dart';
import 'package:prospector/src/core/database/database_failures/database_failure.dart';
import 'package:prospector/src/features/import_contacts/domain/interface/i_last_import_identifiers_repository.dart';

class SaveSingleIdentifier {
  final ILastImportIdentifiersRepository lastImportIdentifiersRepository;
  SaveSingleIdentifier({
    required this.lastImportIdentifiersRepository,
  });
  
  Future<Either<DatabaseFailure, Unit>> call({required String identifier, required String uid}) => lastImportIdentifiersRepository.saveSingleIdentifier(identifier: identifier, uid: uid);

}

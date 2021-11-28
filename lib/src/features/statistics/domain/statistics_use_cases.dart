import 'package:dartz/dartz.dart';
import '../../../core/database/database_failures/database_failure.dart';
import '../../../core/user_collections/domain/interfaces/i_user_collection_local_repository.dart';
import '../../../core/user_collections/domain/interfaces/i_user_collection_remote_repository.dart';
import 'statistic_entity.dart';

class StatisticsUseCases {
  final IUserCollectionLocalRepository localStatisticsRepository;
  final IUserCollectionRemoteRepository remoteStatisticsRepository;
  StatisticsUseCases({
    required this.localStatisticsRepository,
    required this.remoteStatisticsRepository,
  });

  Future<Either<DatabaseFailure, Unit>> createStatistic({
    required Statistic statistic,
    required String uid,
  }) async {
    final Map<String, dynamic> statisticMap = statistic.toMap();
    final localCreate = await localStatisticsRepository.createDocument(
        document: statisticMap, uid: uid);
    return localCreate.fold(
      (failure) => left(failure),
      (unit) {
        remoteStatisticsRepository.createDocument(
            document: statisticMap, uid: uid);
        return right(unit);
      },
    );
  }

  Future<Either<DatabaseFailure, Unit>> deleteStatistic(
      {required String statisticID, required String uid}) async {
    final localDelete = await localStatisticsRepository.deleteDocument(
        docID: statisticID, uid: uid);
    return localDelete.fold(
      (failure) => left(failure),
      (unit) {
        remoteStatisticsRepository.deleteDocument(docID: statisticID, uid: uid);
        return right(unit);
      },
    );
  }

  Future<Either<DatabaseFailure, List<Statistic>>> getStatisticsList(
      {required String uid}) async {
    // Check if exists locally
    final localCheckResult =
        await localStatisticsRepository.collectionExists(uid: uid);
    return localCheckResult.fold(
      (failure) => left(failure),
      (existsLocally) async {
        if (existsLocally) {
          // yes? -> get and return local statistics list
          final Either<DatabaseFailure, List<Map<String, dynamic>>> localGet =
              await localStatisticsRepository.getDocumentsList(uid: uid);
          return localGet.fold(
            (failure) => left(failure),
            (statisticsMapsList) => right(
              statisticsMapsList
                  .map((statisticMap) => Statistic.fromMap(statisticMap))
                  .toList(),
            ),
          );
        } else {
          // no? -> get remote statistics list, save it locally and return it
          final Either<DatabaseFailure, List<Map<String, dynamic>>> remoteGet =
              await remoteStatisticsRepository.getDocumentsList(uid: uid);
          return remoteGet.fold(
            (failure) => left(failure),
            (statisticsMapsList) async {
              final List<Statistic> statisticsList = statisticsMapsList.map(
                (statisticMap) {
                  statisticMap['created'] =
                      statisticMap['created']?.toDate() ?? DateTime.now();

                  localStatisticsRepository.createDocument(
                      document: statisticMap, uid: uid);

                  return Statistic.fromMap(statisticMap);
                },
              ).toList();
              return right(statisticsList);
            },
          );
        }
      },
    );
  }
}

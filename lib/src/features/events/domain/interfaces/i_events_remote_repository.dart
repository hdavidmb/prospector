import 'package:dartz/dartz.dart';

import '../../../../core/database/database_failures/database_failure.dart';
import '../entity/event_entity.dart';

abstract class IEventsRemoteRepository {
  Future<Either<DatabaseFailure, Unit>> createEventDocument(
      {required Event event, required String uid});
  Future<Either<DatabaseFailure, List<Event>>> getEventsList(
      {required String uid});
  Future<Either<DatabaseFailure, Unit>> updateEventDocument(
      {required Event event, required String uid});
  Future<Either<DatabaseFailure, Unit>> deleteEventDocument(
      {required String eventID, required String uid});
}

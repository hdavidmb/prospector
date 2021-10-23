import 'package:dartz/dartz.dart';
import 'package:prospector/src/core/database/database_failures/database_failure.dart';
import 'package:prospector/src/core/user_collections/domain/interfaces/i_user_collection_local_repository.dart';
import 'package:prospector/src/core/user_collections/domain/interfaces/i_user_collection_remote_repository.dart';
import 'package:prospector/src/features/events/domain/entity/event_entity.dart';

class EventsUseCases {
  final IUserCollectionLocalRepository localEventsRepository;
  final IUserCollectionRemoteRepository remoteEventsRepository;
  EventsUseCases({
    required this.localEventsRepository,
    required this.remoteEventsRepository,
  });

  Future<Either<DatabaseFailure, Unit>> createEvent(
      {required Event event, required String uid}) async {
    final Map<String, dynamic> eventMap = event.toMap();
    final localCreate = await localEventsRepository.createDocument(
        document: eventMap, uid: uid);
    return localCreate.fold(
      (failure) => left(failure),
      (_) {
        remoteEventsRepository.createDocument(document: eventMap, uid: uid);
        return right(unit);
      },
    );
  }

  Future<Either<DatabaseFailure, Unit>> updateEvent(
      {required Event event, required String uid}) async {
    final Map<String, dynamic> eventMap = event.toMap();
    final localUpdate = await localEventsRepository.updateDocument(
        document: eventMap, uid: uid);
    return localUpdate.fold(
      (failure) => left(failure),
      (_) {
        remoteEventsRepository.updateDocument(document: eventMap, uid: uid);
        return right(unit);
      },
    );
  }

  Future<Either<DatabaseFailure, Unit>> deleteEvent(
      {required String eventID, required String uid}) async {
    final localDelete =
        await localEventsRepository.deleteDocument(docID: eventID, uid: uid);
    return localDelete.fold(
      (failure) => left(failure),
      (_) {
        remoteEventsRepository.deleteDocument(docID: eventID, uid: uid);
        return right(unit);
      },
    );
  }

  Future<Either<DatabaseFailure, List<Event>>> getEventsList(
      {required String uid}) async {
    // Check if exists locally
    final localCheckResult =
        await localEventsRepository.collectionExists(uid: uid);
    return localCheckResult.fold(
      (failure) => left(failure),
      (existsLocally) async {
        if (existsLocally) {
          // yes? -> get and return local contacts list
          final Either<DatabaseFailure, List<Map<String, dynamic>>> localGet =
              await localEventsRepository.getDocumentsList(uid: uid);
          return localGet.fold(
            (failure) => left(failure),
            (eventsMapsList) => right(
              eventsMapsList
                  .map((eventMap) => Event.fromMap(eventMap))
                  .toList(),
            ),
          );
        } else {
          // no? -> get remote contacts list, save it locally and return it
          final Either<DatabaseFailure, List<Map<String, dynamic>>> remoteGet =
              await remoteEventsRepository.getDocumentsList(uid: uid);
          return remoteGet.fold(
            (failure) => left(failure),
            (eventsMapsList) async {
              final List<Event> eventsList = eventsMapsList.map(
                (eventMap) {
                  eventMap['created'] =
                      eventMap['created']?.toDate() ?? DateTime.now();
                  eventMap['modified'] =
                      eventMap['modified']?.toDate() ?? DateTime.now();
                  eventMap['start_date'] =
                      eventMap['start_date']?.toDate() ?? DateTime.now();
                  eventMap['end_date'] =
                      eventMap['end_date']?.toDate() ?? DateTime.now();

                  if (eventMap['guests'] != null) {
                    eventMap['guests'] =
                        List<String>.from(eventMap['guests'] as List<dynamic>);

                    //TODO test and delete (eventMap['phones']
                    //         as List<dynamic>)
                    //     .map((phone) => phone.toString())
                    //     .toList(); //TODO try List<String>.from(contactMap['phones'])
                  }
                  if (eventMap['notifications'] != null) {
                    eventMap['notifications'] =
                        (eventMap['notifications'] as List<dynamic>) //TODO test
                            .map((timestamp) => timestamp.toDate())
                            .toList();
                    //TODO test and delete List<String>.from(
                    //     eventMap['notifications'] as List<dynamic>);
                  }
                  if (eventMap['notificationsIDs'] != null) {
                    eventMap['notificationsIDs'] = List<String>.from(
                        eventMap['notificationsIDs'] as List<dynamic>);
                  }

                  localEventsRepository.createDocument(
                      document: eventMap, uid: uid);

                  return Event.fromMap(eventMap);
                },
              ).toList();
              return right(eventsList);
            },
          );
        }
      },
    );
  }
}

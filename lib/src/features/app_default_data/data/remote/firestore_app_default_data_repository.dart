import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import 'package:prospector/src/core/database/dabase_failures/database_failure.dart';
import 'package:prospector/src/features/app_default_data/domain/entities/status_entity.dart';
import 'package:prospector/src/features/app_default_data/domain/entities/subscription_entity.dart';
import 'package:prospector/src/features/app_default_data/domain/interface/i_app_default_data_repository.dart';

class FirestoreAppDefaultDataRepository implements IAppDefaultDataRepository {
  final FirebaseFirestore firestoreInstance;

  FirestoreAppDefaultDataRepository({required this.firestoreInstance});

  @override
  Future<Either<DatabaseFailure, List<Status>>> getStatusList() async { //TODO test
    try {
      final QuerySnapshot querySnapshot =
          await firestoreInstance.collection('statuses').get();
      final List<Status> statuses = querySnapshot.docs.map((doc) {
        final Map<String, dynamic> docMap = doc.data();
        docMap['id'] = doc.id;
        docMap['created'] = docMap['created'].millisecondsSinceEpoch;
        return Status.fromMap(docMap);
      }).toList();
      return right(statuses);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }

  @override
  Future<Either<DatabaseFailure, List<Subscription>>> getSubscriptionList() async { //TODO test
    try {
      final QuerySnapshot querySnapshot =
          await firestoreInstance.collection('subscriptions').get();
      final List<Subscription> subscriptions = querySnapshot.docs.map((doc) {
        final Map<String, dynamic> docMap = doc.data();
        docMap['id'] = doc.id;
        docMap['created'] = docMap['created'].millisecondsSinceEpoch;
        return Subscription.fromMap(docMap);
      }).toList();
      return right(subscriptions);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }
}

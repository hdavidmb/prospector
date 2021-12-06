import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/connection/connection_checker.dart';
import '../../../../core/database/database_failures/database_failure.dart';
import '../../domain/entities/status_entity.dart';
import '../../domain/entities/subscription_entity.dart';
import '../../domain/interface/i_app_default_data_repository.dart';

class FirestoreAppDefaultDataRepository
    implements IAppDefaultDataRemoteRepository {
  final FirebaseFirestore firestoreInstance;

  FirestoreAppDefaultDataRepository({required this.firestoreInstance});

  

  @override
  Future<Either<DatabaseFailure, List<Status>>> getStatusList() async {
    final bool isConnected = await checkConnection();
    if (!isConnected) return left(const DatabaseFailure.noConnection());
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await firestoreInstance.collection('statuses').get();
      final List<Status> statuses = querySnapshot.docs.map((doc) {
        final Map<String, dynamic> docMap = doc.data();
        docMap['id'] = doc.id;
        docMap['created'] = docMap['created'].toDate();
        return Status.fromMap(docMap);
      }).toList();
      return right(statuses);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }

  @override
  Future<Either<DatabaseFailure, List<Subscription>>>
      getSubscriptionList() async {
    final bool isConnected = await checkConnection();
    if (!isConnected) return left(const DatabaseFailure.noConnection());
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await firestoreInstance.collection('subscriptions').get();
      final List<Subscription> subscriptions = querySnapshot.docs.map((doc) {
        final Map<String, dynamic> docMap = doc.data();
        docMap['id'] = doc.id;
        docMap['created'] = docMap['created'].toDate();
        return Subscription.fromMap(docMap);
      }).toList();
      return right(subscriptions);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prospector/src/core/connection/connection_checker.dart';
import 'package:prospector/src/features/tags/domain/entity/tag_entity.dart';
import 'package:prospector/src/core/database/database_failures/database_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:prospector/src/features/tags/domain/interfaces/i_tags_remote_repository.dart';

class FirebaseTagsRepository implements ITagsRemoteRepository {
  final FirebaseFirestore firestoreInstance;
  FirebaseTagsRepository({
    required this.firestoreInstance,
  });

  @override
  Future<Either<DatabaseFailure, Unit>> createTagDocument(
      {required Tag tag, required String uid}) async {
    //TODO test
    final Map<String, dynamic> tagMap = tag.toMap();
    try {
      await firestoreInstance
          .collection('users')
          .doc(uid)
          .collection('tags')
          .doc(tag.id)
          .set(tagMap);
      return right(unit);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }

  @override
  Future<Either<DatabaseFailure, Unit>> deleteTagDocument(
      {required String tagID, required String uid}) async {
        // TODO test
      try {
        await firestoreInstance
          .collection('users')
          .doc(uid)
          .collection('tags')
          .doc(tagID)
          .delete();
      return right(unit);
      } catch (e) {
      return left(const DatabaseFailure.serverError());
      }
  }

  @override
  Future<Either<DatabaseFailure, List<Tag>>> getTagsList(
      {required String uid}) async { // TODO test
    final bool isConnected = await checkConnection();
    if (!isConnected) return left(const DatabaseFailure.noConnection());
    try {
      final QuerySnapshot<Map<String, dynamic>> tagsSnapshot = await firestoreInstance
              .collection('users')
              .doc(uid)
              .collection('tags')
              .get();
      // * Transform timestamps into DateTimes and complete with required info
      final List<Tag> tags = tagsSnapshot.docs.map((tagDoc) {
        final Map<String, dynamic> tagMap = tagDoc.data();
        tagMap['id'] = tagDoc.id;
        tagMap['created'] = tagMap['created']?.toDate() ?? DateTime.now();

        return Tag.fromMap(tagMap);
      }).toList();
      return right(tags);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }
}

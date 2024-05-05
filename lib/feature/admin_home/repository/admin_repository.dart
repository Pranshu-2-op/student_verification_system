import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_verification_system/constants/constants.dart';
import 'package:student_verification_system/core/core.dart';

final adminRepositorryProvider =
    Provider((ref) => AdminRepositorry(db: ref.read(firestoreProvider)));

class AdminRepositorry {
  final FirebaseFirestore _db;
  AdminRepositorry({required FirebaseFirestore db}) : _db = db;
  CollectionReference get _users =>
      _db.collection(FireBaseConstants.userCollection);
  CollectionReference get _meet =>
      _db.collection(FireBaseConstants.meetLinkCollection);

  Future<List<DocumentSnapshot>> getAllUsers() async {
    // getting tweets from newer to older
    List<DocumentSnapshot> documents = await _users.get().then(
      (value) {
        List<DocumentSnapshot> docs = [];
        for (var document in value.docs) {
          docs.add(document);
        }
        return docs;
      },
    );
    // print("the complete list of tweets are $documents");
    return documents;
  }

  Future<List<DocumentSnapshot>> getAllMeetLinks() async {
    // getting tweets from newer to older
    List<DocumentSnapshot> documents = await _meet.get().then(
      (value) {
        List<DocumentSnapshot> docs = [];
        for (var document in value.docs) {
          docs.add(document);
        }
        return docs;
      },
    );
    // print("the complete list of tweets are $documents");
    return documents;
  }
}

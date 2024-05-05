import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:student_verification_system/constants/firebase_constants.dart';
import 'package:student_verification_system/core/core.dart';
import 'package:student_verification_system/models/meet_link.dart';
import 'package:student_verification_system/models/user_model.dart';

final meetLinkProvider =
    Provider((ref) => MeetLinkAPI(db: ref.read(firestoreProvider)));

abstract class IMeetLinkAPI {
  FutureEither<MeetLinkModel> sendMeetLink(MeetLinkModel meetLinkModel);
  // Stream<MeetLink?> getMeetLink(String uid);
}

class MeetLinkAPI implements IMeetLinkAPI {
  final FirebaseFirestore _db;
  MeetLinkAPI({required FirebaseFirestore db}) : _db = db;
  CollectionReference get _meet =>
      _db.collection(FireBaseConstants.meetLinkCollection);
  @override
  FutureEither<MeetLinkModel> sendMeetLink(MeetLinkModel meetLinkModel) async {
    try {
      DocumentReference docRef =
          _meet.doc(); // setting up the reference in database
      String docID = docRef.id;
      await docRef.set(meetLinkModel.copyWith(linkUID: docID).toMap());
      return right(meetLinkModel);
    } on FirebaseException catch (e, stackTrace) {
      return left(Failure(e.message ?? "Some error occurred", stackTrace));
    }
  }

  Future<List<DocumentSnapshot>> getMeetLink(
      {required UserModel userModel}) async {
    // CollectionReference get _meet => _db.collection(FireBaseConstants.meetLinkCollection);
    // print(userModel);
    // print("standard ${userModel.standard}");
    List<DocumentSnapshot> documents = await _meet
        .where('standard', isEqualTo: userModel.standard)
        .get()
        .then((value) {
      List<DocumentSnapshot> docs = [];
      for (var document in value.docs) {
        docs.add(document);
      }
      return docs;
    });
    // print("from api $documents");
    return documents;
  }
}

// import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:student_verification_system/constants/firebase_constants.dart';
import 'package:student_verification_system/core/core.dart';
import 'package:student_verification_system/models/user_model.dart';

abstract class IUserAPI {
  FutureEither saveUserData(UserModel userModel);
  Stream<UserModel?> getUserData(String uid);
  Stream<bool> getVerifiedUserLive({required User user});
}

final userAPIProvider = StateProvider((ref) =>
    UserAPI(db: ref.read(firestoreProvider), auth: ref.read(authProvider)));

class UserAPI implements IUserAPI {
  final FirebaseFirestore _db;

  UserAPI({required FirebaseFirestore db, required FirebaseAuth auth})
      : _db = db;

  CollectionReference get _users =>
      _db.collection(FireBaseConstants.userCollection);

  CollectionReference get _verify =>
      _db.collection(FireBaseConstants.verifiedCollection);

  @override
  FutureEither saveUserData(UserModel userModel) async {
    try {
      await _users.doc(userModel.uid).set(userModel.toMap());
      return right(userModel);
    } on FirebaseException catch (e, stackTrace) {
      return left(Failure(e.message ?? "Some error occurred", stackTrace));
    }
  }

  @override
  Stream<UserModel?> getUserData(String uid) {
    return _users.doc(uid).snapshots().map(
      (event) {
        // print(userModel);
        return UserModel.fromMap(event.data() as Map<String, dynamic>);
      },
    ).handleError((error) {
      // Handle errors such as permission denied, network issues, etc.
      // You can return a default UserModel here or rethrow the error.
      return null;
    });
  }

  @override
  Stream<bool> getVerifiedUserLive({required User user}) {
    return _verify
        .where('email', isEqualTo: user.email)
        .snapshots()
        .map((value) {
      if (value.docs.isEmpty) {
        return false;
      } else {
        bool isTrue = true;
        return isTrue;
      }
    }).handleError((error) {
      return false;
    });
  }
}

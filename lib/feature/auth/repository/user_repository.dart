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
  // Future<> getUserData(String uid);
  Stream<bool> getVerifiedUserLive({required User user});
  // Future<Stream<bool>> getVerifiedUserLive({required User user});
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

  // Future<bool> getVerifiedUser({required User user}) async {
  //   return await _verify
  //       .where('email', isEqualTo: user.email)
  //       .get()
  //       .then((value) {
  //     print("response length ${value.docs.length}");
  //     value.docs.forEach((element) {
  //       print(element.data());
  //     });
  //     if (value.docs.length == 0) {
  //       return false;
  //     } else {
  //       bool isTrue = false;
  //       for (var element in value.docs) {
  //         final map = (element.data() as Map<dynamic, dynamic>);
  //         print("${map.keys.runtimeType}, ${map.keys.runtimeType}");
  //         if (map.containsValue(user.email) &&
  //             map.containsValue(user.displayName)) {
  //           isTrue = true;
  //         } else {
  //           print('no mchd');
  //           isTrue = false;
  //         }
  //       }
  //       return isTrue;
  //     }
  //   }).onError((error, stackTrace) {
  //     return false;
  //   });
  // }

  // final BehaviorSubject<UserModel?> _userData = BehaviorSubject<UserModel?>();

  // Stream<UserModel?> getUserData(String uid) {
  //   _users.doc(uid).snapshots().map(
  //     (event) {
  //       final userModel =
  //           UserModel.fromMap(event.data() as Map<String, dynamic>);
  //       print(userModel);
  //       return userModel;
  //     },
  //   ).handleError((error) {
  //     // Handle errors such as permission denied, network issues, etc.
  //     // You can return a default UserModel here or rethrow the error.
  //     return null;
  //   }).listen((userModel) {
  //     _userData.add(userModel);
  //   });

  //   return _userData.stream;
  // }

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

  // final BehaviorSubject<bool> _verifiedUser = BehaviorSubject<bool>();

  // @override
  // Stream<bool> getVerifiedUserLive({required User user}) async* {
  //   try {
  //     _verify.where('email', isEqualTo: user.email).snapshots().listen((value) {
  //       if (value.docs.isEmpty) {
  //         _verifiedUser.add(false);
  //       } else {
  //         bool isTrue = false;
  //         for (var element in value.docs) {
  //           final map = (element.data() as Map<dynamic, dynamic>);
  //           if (map.containsValue(user.email) &&
  //               map.containsValue(user.displayName)) {
  //             isTrue = true;
  //           } else {
  //             isTrue = false;
  //           }
  //         }
  //         _verifiedUser.add(isTrue);
  //       }
  //     });

  //     yield* _verifiedUser.stream;
  //   } catch (error) {
  //     _verifiedUser.addError(error);
  //     yield* _verifiedUser.stream;
  //   }
  // }

  // final BehaviorSubject<bool> _verifiedUser = BehaviorSubject<bool>();

  // @override
  // Future<Stream<bool>> getVerifiedUserLive({required User user}) async {
  //   try {
  //     _verify.where('email', isEqualTo: user.email).snapshots().listen((value) {
  //       if (value.docs.isEmpty) {
  //         _verifiedUser.add(false);
  //       } else {
  //         bool isTrue = false;
  //         for (var element in value.docs) {
  //           final map = (element.data() as Map<dynamic, dynamic>);
  //           if (map.containsValue(user.email) &&
  //               map.containsValue(user.displayName)) {
  //             isTrue = true;
  //           } else {
  //             isTrue = false;
  //           }
  //         }
  //         _verifiedUser.add(isTrue);
  //       }
  //     });

  //     return _verifiedUser.stream;
  //   } catch (error) {
  //     _verifiedUser.addError(error);
  //     return _verifiedUser.stream;
  //   }
  // }

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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:student_verification_system/common/common.dart';
import 'package:student_verification_system/feature/auth/repository/auth_repositorry.dart';
import 'package:student_verification_system/core/core.dart';
import 'package:student_verification_system/feature/auth/repository/user_repository.dart';
import 'package:student_verification_system/feature/meet_link/view/create_meet_link.dart';
// import 'package:student_verification_system/feature/meet_link/view/create_meet_link.dart';
import 'package:student_verification_system/models/user_model.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
      authRepositorry: ref.read(authRepositorryProvider),
      userAPI: ref.read(userAPIProvider)),
);

final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange;
});

final userModelProvider = StreamProvider<UserModel?>((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange.map((user) {
    if (user != null) {
      UserModel? userModel;
      authController.getUserData(user.uid).map((event) {
        userModel = event!;
      });
      return userModel;
    } else {
      return null;
    }
  });
});

final userProvider = StateProvider<UserModel?>((ref) => null);
final verificationProvider = StateProvider<bool?>((ref) => null);

class AuthController extends StateNotifier<bool> {
  final AuthRepositorry _authRepositorry;
  // final bool _isVerified;
  final UserAPI _userAPI;
  AuthController(
      {required AuthRepositorry authRepositorry, required UserAPI userAPI
      // , required bool isVerified
      })
      : _authRepositorry = authRepositorry,
        // _isVerified = isVerified,
        _userAPI = userAPI,
        super(false);
  Stream<User?> get authStateChange => _authRepositorry.authStateChange;

  Stream<UserModel?> getUserData(String uid) async* {
    yield* _userAPI.getUserData(uid);
  }

  Stream<bool> getVerificationData(User user) {
    return _userAPI.getVerifiedUserLive(user: user);
  }

  void signInWithGoogle(
      {required BuildContext context, required String standard}) async {
    final res = await _authRepositorry.signInWithGoogle();
    res.fold((l) {
      return null;
    }, (userCredential) async {
      // print("phone number is ${userCredential.user!.phoneNumber}");
      // final user = userCredential.user;
      // print(user);
      if (userCredential.additionalUserInfo!.isNewUser) {
        state = true;
        // if (userCredential.additionalUserInfo!.isNewUser) {
        final userModel = UserModel(
          uid: userCredential.user!.uid,
          email: userCredential.user!.email ?? '',
          name: userCredential.user!.displayName ?? '',
          profilePic: userCredential.user!.photoURL ?? '',
          isAdminOf: '',
          phoneNumber: '',
          standard: standard,
          isMainAdmin: false,
        );
        // print(userModel);
        bool isVerified = await _userAPI
            .getVerifiedUserLive(user: userCredential.user!)
            .first;
        // print('res2 $res2');
        if (isVerified) {
          final res3 = await _userAPI.saveUserData(userModel);
          res3.fold((l) => showSnackBar(context, l.message), (r) {
            showSnackBar(context, "Welcome ${userModel.name}");
            state = false;
            return null;
            // return null;
          });
        } else {
          Navigator.pushReplacement(
              // ignore: use_build_context_synchronously
              context,
              CreateMeetLink.route());
          // ErrorPage.route(
          //     error:
          //         "Your are not a part of this organisation. If you think this is a mistake Contact on your WhatsApp Group"));
        }
      } else {
        js.context.callMethod('location.reload');
      }
    });
  }
}

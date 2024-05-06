import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_verification_system/feature/auth/repository/auth_repositorry.dart';
import 'package:student_verification_system/core/core.dart';
import 'package:student_verification_system/feature/auth/repository/user_repository.dart';

import 'package:student_verification_system/models/user_model.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

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
      {required AuthRepositorry authRepositorry, required UserAPI userAPI})
      : _authRepositorry = authRepositorry,
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
    state = true;

    final res = await _authRepositorry.signInWithGoogle();

    res.fold((l) {
      state = false;
      showSnackBar(context, l.message);
      return null;
    }, (userCredential) async {
      if (userCredential.additionalUserInfo!.isNewUser) {
        final userModel = UserModel(
          uid: userCredential.user!.uid,
          email: userCredential.user!.email ?? '',
          name: userCredential.user!.displayName ?? '',
          profilePic: userCredential.user!.photoURL ?? '',
          isAdminOf: '',
          phoneNumber: userCredential.user!.phoneNumber ?? '',
          standard: standard,
          isMainAdmin: false,
        );
        bool isVerified = await _userAPI
            .getVerifiedUserLive(user: userCredential.user!)
            .first;
        if (isVerified) {
          final res3 = await _userAPI.saveUserData(userModel);
          res3.fold((l) => showSnackBar(context, l.message), (r) {
            showSnackBar(context, "Welcome ${userModel.name}");
            state = false;
            return null;
          });
        } else {
          state = false;
          return null;
        }
      } else {
        state = false;
        js.context.callMethod('location.reload');
      }
    });
  }

  void signOut(BuildContext context) async {
    state = true;
    final res = await _authRepositorry.signOut();
    res.fold((l) {
      state = false;
      return showSnackBar(context, l.message);
    }, (r) {
      state = false;
      window.location.reload();
      return null;
    });
  }
}

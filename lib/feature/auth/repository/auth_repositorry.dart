import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:student_verification_system/core/core.dart';

final authRepositorryProvider = Provider(
  (ref) => AuthRepositorry(
    auth: ref.watch(authProvider),
    googleSignIn: ref.watch(gooogleSignInProvider),
  ),
);

class AuthRepositorry {
  // final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthRepositorry({
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
  })  : _auth = auth,
        // _firestore = firestore,
        _googleSignIn = googleSignIn;

  Stream<User?> get authStateChange {
    return _auth.authStateChanges();
  }

  FutureEither<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      userCredential.user!.uid;
      return right(userCredential);
    } catch (E, stackTrace) {
      return left(Failure("Google SignIn Error", stackTrace));
    }
  }
}

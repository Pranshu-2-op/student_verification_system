import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_verification_system/common/common.dart';
import 'package:student_verification_system/constants/ui_constants.dart';
import 'package:student_verification_system/feature/auth/controller/auth_controller.dart';
import 'package:student_verification_system/feature/auth/view/sign_in_view.dart';
import 'package:student_verification_system/feature/meet_link/view/create_meet_link.dart';
import 'package:student_verification_system/feature/user_home/view/user_home.dart';
import 'package:student_verification_system/firebase_options.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_verification_system/theme/app_theme.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Create ProviderContainer
  // await FirebaseAuth.instance.setPersistence(Persistence.INDEXED_DB);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  void getData(WidgetRef ref, User user) async {
    final userModel = await ref
        .watch(authControllerProvider.notifier)
        .getUserData(user.uid)
        .first;
    // ref.read(userIdProvider.notifier).update((state) => uid);
    ref.read(userProvider.notifier).update((state) => userModel);
  }

  void getVerifiedData(WidgetRef ref, User user) async {
    final isVerified = await ref
        .watch(authControllerProvider.notifier)
        .getVerificationData(user)
        .first;
    ref.read(verificationProvider.notifier).update((state) => isVerified);
  }

  bool isVerified(WidgetRef ref) {
    bool isverify = ref.watch(verificationProvider)!;
    return isverify;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Secure Meet",
        theme: AppTheme.theme,
        home: ref.watch(authStateChangeProvider).when(
            data: (user) {
              if (user != null) {
                getVerifiedData(ref, user);
                if (isVerified(ref)) {
                  getData(ref, user);
                  return const UserHomeView();
                } else {
                  return const UnVerifiedPage();
                }
              } else {
                return const SignInView();
              }
            },
            error: (error, st) {
              return ErrorPage(error: error.toString());
            },
            loading: () => const Loader()));
  }
}

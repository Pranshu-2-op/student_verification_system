import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_verification_system/common/common.dart';
import 'package:student_verification_system/constants/constants.dart';
import 'package:student_verification_system/core/core.dart';
import 'package:student_verification_system/feature/auth/controller/auth_controller.dart';
import 'package:student_verification_system/feature/auth/view/class_selection_button.dart';
import 'package:student_verification_system/feature/auth/view/google_signin_button.dart';

class SignInView extends ConsumerStatefulWidget {
  const SignInView({super.key});
  static route() => MaterialPageRoute(
        builder: (context) => const SignInView(),
      );

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInViewState();
}

class _SignInViewState extends ConsumerState<SignInView> {
  AppBar appBar = UIConstants.appBar();
  String _standard = '';
  List<String> meetClasses = ['12 A', '12 B'];
  @override
  Widget build(BuildContext context) {
    bool isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: appBar,
      body: isLoading
          ? const Loader()
          : SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(height: 100),
                      const Text(
                        'Welcome to Secure Meet.\nTrying to make things Secure and Practical.',
                        style: TextStyle(fontSize: 30),
                      ),
                      const SizedBox(height: 45),
                      const Text(
                        "Please choose your class correctly. This cannot be changed later.",
                        style: TextStyle(
                            color: Color.fromARGB(255, 231, 100, 100),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 25),
                      SizedBox(
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(
                            meetClasses.length,
                            (index) => Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: ClassSelectionBUtton(
                                  onTap: () {
                                    setState(() {
                                      _standard = meetClasses[index];
                                    });
                                  },
                                  label: meetClasses[index],
                                  backgroundColor: _standard !=
                                          meetClasses[index]
                                      ? const Color.fromARGB(255, 26, 26, 26)
                                      : const Color.fromARGB(255, 83, 83, 83),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 45),
                      SizedBox(
                        // height,
                        child: GoogleSignInButton(
                          icon: AssetsConstants.googleLogo,
                          label: "Sign in with Google",
                          onTap: () {
                            if (_standard == '') {
                              showSnackBar(context,
                                  "Please select your class first to sign in");
                            } else {
                              ref
                                  .watch(authControllerProvider.notifier)
                                  .signInWithGoogle(
                                      context: context, standard: _standard);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

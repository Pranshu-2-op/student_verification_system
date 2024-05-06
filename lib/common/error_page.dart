import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_verification_system/constants/ui_constants.dart';
import 'dart:js' as js;

class ErrorPage extends StatelessWidget {
  final String error;
  const ErrorPage({super.key, required this.error});
  static route({required String error}) {
    return MaterialPageRoute(
      builder: (context) => ErrorPage(
        error: error,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          error,
          style: const TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
    );
  }
}

class UnVerifiedPage extends StatelessWidget {
  const UnVerifiedPage({super.key});
  static route({required String error}) {
    return MaterialPageRoute(
      builder: (context) => const UnVerifiedPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIConstants.appBarHomePage(context1: context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "You are not verified\nIf you feel this is a mistake\nPlease fill this Contact Us Form.",
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 130),
            child: ContactUsButton(onTap: () {
              js.context.callMethod('open', [
                "https://docs.google.com/forms/d/e/1FAIpQLSe3vVGitj3AeGISCJ-QrUUPzQO5iKnp4GK_Q2VJQlfIt-lU-Q/viewform?usp=sf_link"
              ]);
            }),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:student_verification_system/constants/constants.dart';
import 'package:student_verification_system/theme/pallete.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            AssetsConstants.googleLogo,
            height: 30,
          ),
          const CircularProgressIndicator(
            strokeWidth: 2,
            strokeCap: StrokeCap.round,
            color: Pallete.blueColor,
            backgroundColor: Colors.black,
          ),
        ],
      ),
    );
  }
}

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  AssetsConstants.googleLogo,
                  height: 30,
                ),
                const CircularProgressIndicator(
                  strokeWidth: 2,
                  strokeCap: StrokeCap.round,
                  color: Pallete.blueColor,
                  backgroundColor: Colors.black,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Loading...",
                style: TextStyle(
                  color: Pallete.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ))
          ],
        ),
      ),
    );
  }
}

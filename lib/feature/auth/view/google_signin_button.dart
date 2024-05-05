import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:student_verification_system/constants/constants.dart';
import 'package:student_verification_system/theme/pallete.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onTap;
  final backgroundColor = Pallete.whiteColor;
  final textColor = Pallete.backgroundColor;
  final label = 'Sign in with Google';
  const GoogleSignInButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Chip(
        labelPadding: const EdgeInsets.symmetric(horizontal: 14),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: BorderSide(
              width: 10,
              color: backgroundColor,
            )),
        backgroundColor: backgroundColor,
        label: Row(
          children: [
            SvgPicture.asset(AssetsConstants.googleLogo),
            Text(
              " $label",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16, color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:student_verification_system/theme/pallete.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onTap;
  final backgroundColor = Pallete.whiteColor;
  final textColor = Pallete.backgroundColor;
  final String label;
  final String icon;
  const GoogleSignInButton(
      {super.key,
      required this.onTap,
      required this.label,
      required this.icon});

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
            SvgPicture.asset(
              icon,
              height: 25,
            ),
            const SizedBox(
              width: 20,
            ),
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

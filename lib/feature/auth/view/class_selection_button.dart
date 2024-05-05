import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:student_verification_system/constants/constants.dart';
import 'package:student_verification_system/theme/pallete.dart';

class ClassSelectionBUtton extends StatelessWidget {
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color textColor = Pallete.whiteColor;
  final String label;
  const ClassSelectionBUtton(
      {super.key,
      required this.onTap,
      required this.label,
      required this.backgroundColor});

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
              AssetsConstants.googleMeetLogo,
              height: 30,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              label,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20, color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}

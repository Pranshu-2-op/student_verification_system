import 'package:flutter/material.dart';
import 'package:student_verification_system/theme/theme.dart';

class SmallRoundedButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final Color backgroundColor;
  final Color textColor;
  const SmallRoundedButton({
    super.key,
    required this.onTap,
    required this.label,
    this.backgroundColor = Pallete.whiteColor,
    this.textColor = Colors.black,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Chip(
        labelPadding: const EdgeInsets.symmetric(horizontal: 14),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: BorderSide(
              color: backgroundColor,
            )),
        backgroundColor: backgroundColor,
        label: Text(
          label,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: textColor),
        ),
      ),
    );
  }
}

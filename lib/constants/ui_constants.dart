import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:student_verification_system/constants/constants.dart';
import 'package:student_verification_system/core/utils.dart';
import 'package:student_verification_system/feature/admin_home/view/meet_list.dart';
import 'package:student_verification_system/feature/admin_home/view/user_list.dart';
import 'package:student_verification_system/feature/auth/controller/auth_controller.dart';
import 'package:student_verification_system/models/meet_link.dart';
import 'package:student_verification_system/theme/theme.dart';
import 'dart:js' as js;

class UIConstants {
  static AppBar appBar() {
    return AppBar(
      surfaceTintColor: Pallete.backgroundColor,
      title: SvgPicture.asset(
        AssetsConstants.googleLogo,
        width: 30,
      ),
      centerTitle: true,
    );
  }

  static AppBar appBarHomePage({
    VoidCallback? refresh,
    required BuildContext context1,
  }) {
    return AppBar(
      // backgroundColor: Pallete.backgroundColor,
      leading: Consumer(
        builder: (context, ref, child) => IconButton(
          tooltip: 'Sign Out',
          onPressed: () {
            ref.watch(authControllerProvider.notifier).signOut(context1);
          },
          icon: const Icon(Icons.logout_rounded),
        ),
      ),
      surfaceTintColor: Pallete.backgroundColor,
      title: SvgPicture.asset(
        AssetsConstants.googleLogo,
        width: 30,
      ),
      centerTitle: true,
      actions: [
        if (refresh != null) ...[
          IconButton(
            onPressed: refresh,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
          ),
          const SizedBox(
            width: 20,
          ),
        ]
      ],
    );
  }

  static List<Widget> bottomTabBarPages = [
    const UserList(),
    const MeetList(),
  ];
}

class ContactUsButton extends StatelessWidget {
  final VoidCallback onTap;
  final backgroundColor = Pallete.whiteColor;
  final textColor = Pallete.backgroundColor;
  const ContactUsButton({
    super.key,
    required this.onTap,
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
              width: 10,
              color: backgroundColor,
            )),
        backgroundColor: backgroundColor,
        label: Row(
          children: [
            const Icon(
              Icons.contact_page,
              color: Colors.blue,
            ),
            const SizedBox(
              width: 25,
            ),
            Text(
              "Contact Us",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16, color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}

class GoogleMeetLinkButton extends StatelessWidget {
  final MeetLinkModel meetLinkModel;
  final backgroundColor = Pallete.whiteColor;
  final textColor = Pallete.backgroundColor;
  final BuildContext context1;
  final label = 'Join Meet';
  const GoogleMeetLinkButton(
      {super.key, required this.meetLinkModel, required this.context1});

  void redirectToMeet(
      {required String link, required BuildContext context}) async {
    if (link == '') {
      showSnackBar(context1, "No meeting link is found");
      return;
    }
    try {
      js.context.callMethod('open', [link]);
    } catch (e) {
      // Error occurred
      showSnackBar(context1, "No meeting link is found");
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime meetTime = meetLinkModel.time;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Subject: ${meetLinkModel.subject}"),
              Text('Time: ${DateFormat('h:mm a').format(meetTime)}'),
            ],
          ),
          InkWell(
            onTap: () =>
                redirectToMeet(link: meetLinkModel.link, context: context1),
            child: Chip(
              labelPadding: const EdgeInsets.symmetric(horizontal: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                  side: BorderSide(
                    width: 10,
                    color: backgroundColor,
                  )),
              backgroundColor: backgroundColor,
              label: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AssetsConstants.googleMeetLogo,
                    height: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    " $label",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: textColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

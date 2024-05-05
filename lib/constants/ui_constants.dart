import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:student_verification_system/constants/constants.dart';
import 'package:student_verification_system/feature/admin_home/view/meet_list.dart';
import 'package:student_verification_system/feature/admin_home/view/user_list.dart';
// import 'package:student_verification_system/features/tweet/widgets/tweet_list.dart';
import 'package:student_verification_system/theme/theme.dart';

class UIConstants {
  static AppBar appBar() {
    return AppBar(
      surfaceTintColor: Pallete.backgroundColor,
      title: SvgPicture.asset(
        AssetsConstants.secureEduLogo,
        width: 30,
      ),
      centerTitle: true,
    );
  }

  static AppBar appBarHomePage(String userProfile, VoidCallback onPressed) {
    return AppBar(
      // backgroundColor: Pallete.backgroundColor,
      surfaceTintColor: Pallete.backgroundColor,
      title: SvgPicture.asset(
        AssetsConstants.secureEduLogo,
        width: 30,
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.logout_outlined),
        tooltip: 'Sign out',
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            foregroundImage: NetworkImage(userProfile),
            radius: 18,
          ),
        )
      ],
    );
  }

  static List<Widget> bottomTabBarPages = [
    // const TweetList(),
    // const Text('Search Page'),
    const UserList(),
    const MeetList(),
  ];
}

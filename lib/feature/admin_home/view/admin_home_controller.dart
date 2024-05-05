import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:student_verification_system/constants/assets_constants.dart';
import 'package:student_verification_system/constants/ui_constants.dart';
import 'package:student_verification_system/feature/meet_link/view/create_meet_link.dart';
import 'package:student_verification_system/theme/pallete.dart';

class AdminHomeView extends StatefulWidget {
  const AdminHomeView({super.key});
  static route() => MaterialPageRoute(
        builder: (context) => const AdminHomeView(),
      );

  @override
  State<AdminHomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<AdminHomeView> {
  int _page = 0;

  void onTap(int index) {
    setState(() {
      _page = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // to enable providers access
    return Consumer(
      builder: (context, ref, child) {
        return Scaffold(
          // showing a default image till userprofile comes
          body: SingleChildScrollView(
            child: IndexedStack(
              index: _page,
              children: UIConstants.bottomTabBarPages,
            ),
          ),
          floatingActionButton: IconButton(
              onPressed: () {
                Navigator.push(context, CreateMeetLink.route());
              },
              tooltip: "Create Meet Link",
              style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Pallete.whiteColor)),
              icon: SvgPicture.asset(
                AssetsConstants.googleMeetLogo,
                height: 20,
              )),
          bottomNavigationBar: CupertinoTabBar(
            backgroundColor: Pallete.backgroundColor,
            currentIndex: _page,
            onTap: onTap,
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.list_alt),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(AssetsConstants.googleMeetLogo,
                    height: 25),
              ),
            ],
          ),
        );
      },
    );
  }
}

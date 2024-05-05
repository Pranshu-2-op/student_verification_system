// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:student_verification_system/common/common.dart';
import 'package:student_verification_system/constants/constants.dart';
import 'package:student_verification_system/core/core.dart';
import 'package:student_verification_system/feature/admin_home/view/admin_home_controller.dart';
import 'package:student_verification_system/feature/auth/controller/auth_controller.dart';
import 'package:student_verification_system/feature/meet_link/controller/meet_link_controller.dart';
import 'package:student_verification_system/models/meet_link.dart';
import 'package:student_verification_system/theme/theme.dart';
// import 'package:http/http.dart' as http;

class UserHomeView extends ConsumerStatefulWidget {
  const UserHomeView({super.key});
  static route() {
    return MaterialPageRoute(
      builder: (context) => const UserHomeView(),
    );
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserHomeViewState();
}

class _UserHomeViewState extends ConsumerState<UserHomeView> {
  @override
  Widget build(BuildContext context) {
    final userModel = ref.watch(userProvider);

    // print(userModel);
    // print(userModel);
    ref.watch(userProvider.notifier).stream.listen((event) {
      if (event != null) {
        if (event.isAdminOf == '12 A') {
          Navigator.pushReplacement(context, AdminHomeView.route());
        }
      }
    });
    return Scaffold(
      appBar: UIConstants.appBar(),
      body: userModel == null
          ? const Loader()
          : ref.watch(meetProvider(userModel)).when(
                data: (meetLinks) {
                  // print(meetLinks);
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome, ${userModel.name}",
                          style: const TextStyle(fontSize: 30),
                        ),
                        if (meetLinks.isNotEmpty) ...[
                          const SizedBox(
                            height: 40,
                          ),
                          const Text(
                            "Your meet links are",
                            style: TextStyle(fontSize: 30),
                          ),
                        ],
                        if (meetLinks.isEmpty) ...[
                          const SizedBox(
                            height: 100,
                          ),
                          const Text(
                            "No meetings scheduled please refresh or check after some time.",
                            style: TextStyle(fontSize: 30),
                          ),
                        ],
                        Expanded(
                          child: ListView.builder(
                            itemCount: meetLinks.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              final meetLinkModel = meetLinks[index];
                              // print(meetLinkModel);
                              return GoogleMeetLinkButton(
                                meetLinkModel: MeetLinkModel.fromMap(
                                    meetLinkModel.data()
                                        as Map<String, dynamic>),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  );
                },
                error: (error, stackTrace) {
                  return ErrorPage(error: error.toString());
                },
                loading: () => const Loader(),
              ),
    );
  }
}

class GoogleMeetLinkButton extends StatelessWidget {
  // final VoidCallback onTap;
  final MeetLinkModel meetLinkModel;
  final backgroundColor = Pallete.whiteColor;
  final textColor = Pallete.backgroundColor;
  final label = 'Join Meet';
  const GoogleMeetLinkButton({super.key, required this.meetLinkModel});

  @override
  Widget build(BuildContext context) {
    DateTime meetTime = meetLinkModel.time;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        // crossAxisAlignment: ,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Subject: ${meetLinkModel.subject}"),
              Text('Time: ${DateFormat('h:mm a').format(meetTime)}'),
            ],
          ),
          //  Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          //     Text("Subject: "),
          //     Text('Time: '),
          //   ],
          // ),
          InkWell(
            onTap: () {
              redirectToMeet(context: context, link: meetLinkModel.link);
            },
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
          )
        ],
      ),
    );
  }
}

void redirectToMeet(
    {required String link, required BuildContext context}) async {
  if (link == '') {
    showSnackBar(context, "No meeting link is found");
    return;
  }
  try {
    js.context.callMethod('open', [link]);
  } catch (e) {
    // Error occurred
    showSnackBar(context, "No meeting link is found");
  }
}

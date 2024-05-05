import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:student_verification_system/common/common.dart';
import 'package:student_verification_system/constants/constants.dart';
import 'package:student_verification_system/core/core.dart';
import 'package:student_verification_system/feature/admin_home/view/admin_home_controller.dart';
import 'package:student_verification_system/feature/auth/view/class_selection_button.dart';
import 'package:student_verification_system/feature/meet_link/controller/meet_link_controller.dart';
import 'package:student_verification_system/theme/theme.dart';

class CreateMeetLink extends ConsumerStatefulWidget {
  const CreateMeetLink({super.key});
  static route() {
    return MaterialPageRoute(
      builder: (context) => const CreateMeetLink(),
    );
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateMeetLinkState();
}

class _CreateMeetLinkState extends ConsumerState<CreateMeetLink> {
  TextEditingController meetLinkEditingController = TextEditingController();
  String _standard = '12 A';

  void shareLink({required BuildContext context}) {
    final text = meetLinkEditingController.text.trim();
    if (text.contains('https://meet.google.com/')) {
      ref.watch(meetLinkControllerProvider.notifier).shareMeetLink(
            meetLink: text,
            context: context,
            standard: _standard,
          );
      Navigator.pop(context, AdminHomeView.route());
    } else {
      showSnackBar(context,
          "Please enter the link in correct form like https://meet.google.com/kbp-rsyg-mjc");
    }
  }

  List<String> meetClasses = ['12 A', '12 B'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(
          onPressed: () => Navigator.pop(context, AdminHomeView.route()),
          // onPressed: () {},
          style: ButtonStyle(iconSize: MaterialStateProperty.all(30)),
        ),
        title: SvgPicture.asset(
          AssetsConstants.secureEduLogo,
          height: 30,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SmallRoundedButton(
              onTap: () {
                shareLink(context: context);
              },
              label: "Send Link",
              backgroundColor: Pallete.blueColor,
              textColor: Pallete.whiteColor,
            ),
          )
        ],
      ),

      //body part where post will be written
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 2.5, 0, 0),
                      child: TextFormField(
                        style: const TextStyle(fontSize: 20),
                        controller: meetLinkEditingController,
                        autofocus: true,
                        maxLength: 100,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          hintText: "Enter the Google Meet Link",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 20,
                          ),
                        ),
                        maxLines: null,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                        meetClasses.length,
                        (index) => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: ClassSelectionBUtton(
                              onTap: () {
                                setState(() {
                                  _standard = meetClasses[index];
                                });
                              },
                              label: meetClasses[index],
                              backgroundColor: _standard != meetClasses[index]
                                  ? Color.fromARGB(255, 26, 26, 26)
                                  : const Color.fromARGB(255, 83, 83, 83),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    //   body: SafeArea(
    //     child: SingleChildScrollView(
    //       child: Column(
    //         children: [
    //           const SizedBox(
    //             height: 15,
    //           ),
    //           Row(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               const SizedBox(
    //                 width: 10,
    //               ),
    //               const SizedBox(width: 15),
    //               Expanded(
    //                 child: Padding(
    //                   padding: const EdgeInsets.fromLTRB(0, 2.5, 0, 0),
    //                   child: TextFormField(
    //                     style: const TextStyle(fontSize: 20),
    //                     controller: meetLinkEditingController,
    //                     autofocus: true,
    //                     maxLength: 100,
    //                     decoration: const InputDecoration(
    //                         border: InputBorder.none,
    //                         contentPadding: EdgeInsets.fromLTRB(0, 0, 10, 0),
    //                         hintText: "Enter the Google Meet Link",
    //                         hintStyle: TextStyle(
    //                             fontWeight: FontWeight.w300, fontSize: 20)),
    //                     maxLines: null,
    //                   ),
    //                 ),
    //               ),
    //               SizedBox(
    //                 height: 60,
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                   children: List.generate(
    //                     meetClasses.length,
    //                     (index) => Expanded(
    //                       child: Padding(
    //                         padding:
    //                             const EdgeInsets.symmetric(horizontal: 12.0),
    //                         child: ClassSelectionBUtton(
    //                           onTap: () {
    //                             setState(() {
    //                               _standard = meetClasses[index];
    //                             });
    //                           },
    //                           label: meetClasses[index],
    //                           backgroundColor: _standard != meetClasses[index]
    //                               ? Color.fromARGB(255, 26, 26, 26)
    //                               : const Color.fromARGB(255, 83, 83, 83),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}

// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_verification_system/common/common.dart';
import 'package:student_verification_system/constants/constants.dart';
import 'package:student_verification_system/feature/admin_home/view/admin_home_controller.dart';
import 'package:student_verification_system/feature/auth/controller/auth_controller.dart';
import 'package:student_verification_system/feature/meet_link/controller/meet_link_controller.dart';
import 'package:student_verification_system/models/meet_link.dart';
import 'package:student_verification_system/theme/theme.dart';

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

    ref.watch(userProvider.notifier).stream.listen((event) {
      if (event != null) {
        if (event.isAdminOf == '12 A') {
          Navigator.pushReplacement(context, AdminHomeView.route());
        }
      }
    });
    return Scaffold(
      appBar: UIConstants.appBarHomePage(
          context1: context,
          refresh: () {
            ref.watch(meetProviderRefresh(userModel!));
          }),
      body: userModel == null
          ? const Loader()
          : ref.watch(meetProvider(userModel)).when(
                data: (meetLinks) {
                  // print(meetLinks);
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
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
                          if (meetLinks.isNotEmpty) ...[
                            Column(
                              children: List.generate(
                                meetLinks.length,
                                (index) {
                                  final meetLinkModel = meetLinks[index];
                                  return GoogleMeetLinkButton(
                                    context1: context,
                                    meetLinkModel: MeetLinkModel.fromMap(
                                      meetLinkModel.data()
                                          as Map<String, dynamic>,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Your class: ${userModel.standard}",
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                error: (error, stackTrace) {
                  return ErrorPage(error: error.toString());
                },
                loading: () => const Loader(),
              ),
      bottomNavigationBar: BottomAppBar(
        color: Pallete.backgroundColor,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 130),
          child: ContactUsButton(
            onTap: () {
              js.context.callMethod('open', [
                "https://docs.google.com/forms/d/e/1FAIpQLSfY8x5h6jN_s5LIcAZ_TqbUPXu5Ia4ZV9YD_lFg8jXaEzesHg/viewform?usp=sf_link"
              ]);
            },
          ),
        ),
      ),
    );
  }
}

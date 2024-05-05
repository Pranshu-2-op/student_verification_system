import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:student_verification_system/constants/constants.dart';
import 'package:student_verification_system/models/meet_link.dart';
import 'package:student_verification_system/theme/pallete.dart';
// import 'package:twitter_clone/features/tweet/controller/tweet_controller.dart';

class MeetCard extends ConsumerWidget {
  final MeetLinkModel meetLink;
  const MeetCard({super.key, required this.meetLink});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      // Card properties
      margin: const EdgeInsets.symmetric(vertical: 0),
      shape: const LinearBorder(
        bottom: LinearBorderEdge(size: 1),
        side: BorderSide(width: 0.4, color: Pallete.greyColor),
      ),
      child: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(20),
        // color: Pallete.backgroundColor,
        decoration: BoxDecoration(
            color: Pallete.backgroundColor,
            border: Border.all(color: Pallete.backgroundColor)),

        // Card elements
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  // foregroundImage: NetworkImage(user.profilePic),
                  backgroundColor: Pallete.backgroundColor,
                  backgroundImage: NetworkImage(
                    // ref.watch(authStateChangeProvider).whenData((value) => value!.photoURL)
                    AssetsConstants.googleMeetLogoPNG,
                    // scale: 100,
                  ),
                  radius: 20,
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      meetLink.link,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Pallete.blueColor),
                    ),
                    Text(
                      "Class: ${meetLink.standard}",
                      style: const TextStyle(
                          color: Pallete.whiteColor, fontSize: 12),
                    ),
                    // SizedBox(height: 10,),
                    Text(
                      "Subject: ${meetLink.subject}",
                      style: const TextStyle(
                          color: Pallete.whiteColor, fontSize: 12),
                    ),
                    Text(
                      "Time: ${DateFormat('h:mm a').format(meetLink.time)}",
                      style: const TextStyle(
                          color: Pallete.whiteColor, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_verification_system/models/user_model.dart';
import 'package:student_verification_system/theme/pallete.dart';
// import 'package:twitter_clone/features/tweet/controller/tweet_controller.dart';

class UserCard extends ConsumerWidget {
  final UserModel user;
  const UserCard({super.key, required this.user});

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
                CircleAvatar(
                  // foregroundImage: NetworkImage(user.profilePic),
                  backgroundImage: NetworkImage(
                      // ref.watch(authStateChangeProvider).whenData((value) => value!.photoURL)
                      user.profilePic),
                  radius: 30,
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Pallete.whiteColor),
                    ),
                    Text(
                      "Class: ${user.standard}",
                      style: const TextStyle(
                          color: Pallete.whiteColor, fontSize: 15),
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

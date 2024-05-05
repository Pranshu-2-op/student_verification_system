import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_verification_system/common/common.dart';
import 'package:student_verification_system/feature/admin_home/controller/admin_controller.dart';
import 'package:student_verification_system/feature/admin_home/widgets/meet_card.dart';
import 'package:student_verification_system/models/meet_link.dart';

class MeetList extends ConsumerStatefulWidget {
  const MeetList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MeetListState();
}

class _MeetListState extends ConsumerState<MeetList> {
  // bool initialData = true;
  // List<DocumentSnapshot> tweetList = [];
  @override
  Widget build(BuildContext context) {
    return ref.watch(getAllMeetLinkProvider).when(
        data: (meetLinks) {
          return SizedBox(
            height: 720,
            child: ListView.builder(
              itemCount: meetLinks.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final meetLink = meetLinks[index];
                return MeetCard(
                    meetLink: MeetLinkModel.fromMap(
                        meetLink.data() as Map<String, dynamic>));
              },
            ),
          );
        },
        error: (error, stackTrace) {
          return ErrorPage(
            error: error.toString(),
          );
        },
        loading: () => const Loader());
  }
}

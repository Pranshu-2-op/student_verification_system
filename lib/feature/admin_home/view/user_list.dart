import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_verification_system/common/common.dart';
import 'package:student_verification_system/feature/admin_home/controller/admin_controller.dart';
import 'package:student_verification_system/feature/admin_home/widgets/user_card.dart';
import 'package:student_verification_system/models/user_model.dart';

class UserList extends ConsumerStatefulWidget {
  const UserList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserListState();
}

class _UserListState extends ConsumerState<UserList> {
  bool initialData = true;
  // List<DocumentSnapshot> tweetList = [];
  @override
  Widget build(BuildContext context) {
    return ref.watch(getAllUserProvider).when(
        data: (users) {
          return SizedBox(
            height: 720,
            child: ListView.builder(
              itemCount: users.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final user = users[index];
                return UserCard(
                    user:
                        UserModel.fromMap(user.data() as Map<String, dynamic>));
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

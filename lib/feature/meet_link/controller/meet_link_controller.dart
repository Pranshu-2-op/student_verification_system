import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_verification_system/core/core.dart';
import 'package:student_verification_system/feature/admin_home/view/admin_home_controller.dart';
import 'package:student_verification_system/feature/meet_link/repository/meet_link_api.dart';
import 'package:student_verification_system/models/meet_link.dart';
import 'package:student_verification_system/models/user_model.dart';

final meetLinkControllerProvider =
    StateNotifierProvider<MeetLinkController, bool>(
  (ref) => MeetLinkController(meetLinkAPI: ref.watch(meetLinkProvider)),
);

// Assuming you want to trigger refresh of meetProvider when meetLinkControllerProvider changes
final meetProviderRefresh =
    FutureProvider.autoDispose.family<void, UserModel>((ref, userModel) {
  ref.watch(meetLinkControllerProvider);
  return ref.refresh(meetProvider(userModel));
});

final meetProvider = FutureProvider.family((ref, UserModel userModel) async {
  final meetLinkController = ref.watch(meetLinkControllerProvider.notifier);
  return meetLinkController.getMeetLink(userModel: userModel);
});

class MeetLinkController extends StateNotifier<bool> {
  final MeetLinkAPI _meetLinkAPI;
  MeetLinkController({required MeetLinkAPI meetLinkAPI})
      : _meetLinkAPI = meetLinkAPI,
        super(false);

  /// Converts a time string in the format "X AM" or "X PM" to a DateTime object representing the current date and time with the specified time.
  ///
  /// For example, if the current date and time is 2023-03-08 14:30:00 and the input string is "10 AM", the output will be 2023-03-08 10:00:00.
  /// If the input string is "10 PM", the output will be 2023-03-08 22:00:00.
  DateTime convertTimeStringToDateTime(String timeString) {
    // Get the current date and time
    final now = DateTime.now();
    int hours = int.parse(timeString.split(' ')[0]);
    // Convert the time to milliseconds since epoch.
    DateTime dateTime = DateTime(now.year, now.month, now.day, hours);
    return dateTime;
  }

  void shareMeetLink({
    required String meetLink,
    required BuildContext context,
    required String standard,
    required String time,
    required String subject,
  }) async {
    state = true;
    DateTime parsedTime = convertTimeStringToDateTime(time);

    final meetLinkModel = MeetLinkModel(
        linkUID: '',
        link: meetLink,
        subject: subject,
        time: parsedTime,
        standard: standard);
    final res = await _meetLinkAPI.sendMeetLink(meetLinkModel);
    res.fold((l) {
      state = false;
      showSnackBar(context, l.message);
    }, (r) {
      state = false;
      showSnackBar(context, 'Meet link has been shared');
      Navigator.pop(context, AdminHomeView.route());
    });
  }

  Future<List<DocumentSnapshot>> getMeetLink(
      {required UserModel userModel}) async {
    final list = await _meetLinkAPI.getMeetLink(userModel: userModel);
    return list;
  }
}

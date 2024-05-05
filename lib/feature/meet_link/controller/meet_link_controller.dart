import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_verification_system/core/core.dart';
import 'package:student_verification_system/feature/meet_link/repository/meet_link_api.dart';
import 'package:student_verification_system/models/meet_link.dart';
import 'package:student_verification_system/models/user_model.dart';

final meetLinkControllerProvider =
    StateNotifierProvider<MeetLinkController, bool>(
  (ref) => MeetLinkController(meetLinkAPI: ref.watch(meetLinkProvider)),
);

final meetProvider = FutureProvider.family((ref, UserModel userModel) async {
  final meetLinkController = ref.watch(meetLinkControllerProvider.notifier);
  return meetLinkController.getMeetLink(userModel: userModel);
});

class MeetLinkController extends StateNotifier<bool> {
  final MeetLinkAPI _meetLinkAPI;
  MeetLinkController({required MeetLinkAPI meetLinkAPI})
      : _meetLinkAPI = meetLinkAPI,
        super(false);

  void shareMeetLink(
      {required String meetLink,
      required BuildContext context,
      required String standard}) async {
    state = true;
    final meetLinkModel = MeetLinkModel(
        linkUID: '',
        link: meetLink,
        subject: 'english',
        time: DateTime.now(),
        standard: standard);
    final res = await _meetLinkAPI.sendMeetLink(meetLinkModel);
    res.fold((l) {
      state = false;
      showSnackBar(context, l.message);
    }, (r) {
      state = false;
      showSnackBar(context, 'Meet link has been shared');
    });
  }

  Future<List<DocumentSnapshot>> getMeetLink(
      {required UserModel userModel}) async {
    final list = await _meetLinkAPI.getMeetLink(userModel: userModel);
    return list;
  }
}

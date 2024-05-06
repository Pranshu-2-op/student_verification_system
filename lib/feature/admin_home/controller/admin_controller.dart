import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_verification_system/feature/admin_home/repository/admin_repository.dart';

final adminControllerProvider =
    StateNotifierProvider<AdminController, bool>((ref) {
  return AdminController(admin: ref.watch(adminRepositorryProvider));
});

final getAllMeetLinkProvider = FutureProvider.autoDispose((ref) async {
  final tweetController = ref.watch(adminControllerProvider.notifier);
  return tweetController.getAllMeetLinks();
});

final refreshAllMeetLinkProvider = Provider.autoDispose<void>((ref) {
  // Watch the getAllMeetLinkProvider to trigger a refresh when needed
  return ref.refresh(getAllMeetLinkProvider);
});

final getAllUserProvider = FutureProvider.autoDispose((ref) async {
  final tweetController = ref.watch(adminControllerProvider.notifier);
  return tweetController.getAllUsers();
});

class AdminController extends StateNotifier<bool> {
  final AdminRepositorry _admin;
  AdminController({required AdminRepositorry admin})
      : _admin = admin,
        super(false);

  Future<List<DocumentSnapshot>> getAllUsers() async {
    final tweetList = await _admin.getAllUsers();
    return tweetList;
  }

  Future<List<DocumentSnapshot>> getAllMeetLinks() async {
    final allMeetLinks = await _admin.getAllMeetLinks();
    return allMeetLinks;
  }
}

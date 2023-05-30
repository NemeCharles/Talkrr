import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/user.dart';
import '../../storage_services/hive_services.dart';

final userListProvider = FutureProvider.autoDispose<List<UserData>> ((ref) => ref.watch(userListController).loadAllUsers());
final userListController = Provider<UsersListController>((ref) => UsersListController());

class UsersListController {

  final CollectionReference _userStore = FirebaseFirestore.instance.collection('user');

  Future<List<UserData>> loadAllUsers() async {
    final loggedInUser = HiveServices().getUser();
    List<UserData> userList = <UserData>[];
    try {
      await _userStore.withConverter(
          fromFirestore: (snapshot, _) => UserData.fromJson(snapshot.data()!),
          toFirestore: (userData, _) => userData.toJson()
      ).where('uid', isNotEqualTo: loggedInUser?.uid).get().then((value) {
        for (final user in value.docs) {
          userList.add(user.data());
        }
      });
    } catch(e) {print(e);}
    return userList;
  }
}
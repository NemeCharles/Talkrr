import 'package:cloud_firestore/cloud_firestore.dart';
import '../storage_services/hive_services.dart';
import '../user_model/user.dart';

class CloudStore {
  final CollectionReference _userStore = FirebaseFirestore.instance.collection('user');
  List<UserData> users = <UserData>[];

  loadAllUsers() async {
    final loggedInUser = HiveServices().getUser();
    try {
      await _userStore.withConverter(
          fromFirestore: (snapshot, _) => UserData.fromJson(snapshot.data()!),
          toFirestore: (userData, _) => userData.toJson()
      ).where('uid', isNotEqualTo: loggedInUser?.uid).get().then((value) {
        final user = value.docs;
        users.clear();
        user.map((user) =>
          users.add(user.data())).toList();
        print("Number of users: ${users.length}");
      });
    } catch(e) {print(e);}
  }
}
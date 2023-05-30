import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:text_app/storage_services/hive_services.dart';
import 'package:text_app/storage_services/user_info/user_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';

final fireAuthPod = Provider<FireAuth>((ref) => FireAuth());

class FireAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _userStore = FirebaseFirestore.instance.collection('user');
  final _hive = HiveServices();

  Future<void> signUpEmail (String email, String password, String displayName) async {
    try{
      UserCredential user = await _auth.
      createUserWithEmailAndPassword(email: email, password: password);
      print('SUCCESSFUL');
      if(user.user != null) {
        await _userStore.withConverter<UserData>(
            fromFirestore: (snapshot, _) => UserData.fromJson(snapshot.data()!),
            toFirestore: (userData, _) => userData.toJson()
        ).add(
            UserData(
              displayName: displayName,
              email: email,
              uid: user.user?.uid,
              profilePhoto: '',
            )
        ).then((value) async {
          await _hive.addUser(
            LoggedInUserData(
              userName: displayName,
              email: email,
              uid: user.user!.uid,
              profilePhoto: '',
            )
          );
        });
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
    } catch (e) {
      print(e);
    }
  }

  // Sign in with Email and Password

  Future<void> signInEmail (String email, String password) async {
    try{
      UserCredential user = await _auth.
      signInWithEmailAndPassword(email: email, password: password);

      await _userStore.withConverter<UserData>(
          fromFirestore: (snapshot, _) => UserData.fromJson(snapshot.data()!),
          toFirestore: (userData, _) => userData.toJson()
      ).where('uid', isEqualTo: user.user?.uid).get().then((value) async {
          final test = value.docs.first.data();
          await _hive.addUser(
            LoggedInUserData(
              userName: test.displayName.toString(),
              email: test.email.toString(),
              uid: test.uid.toString(),
              profilePhoto: test.profilePhoto.toString(),
            )
          );
          print('SIGN IN SUCCESSFUL');
      });

    } on FirebaseAuthException catch (e) {
      print(e.code);
    } catch (e) {
      print(e);
    }
  }

  // Sign in with Google Account

  // Sign in with Facebook Account

  // Sign out of Account

  Future<void> signOut () async {
    try {
      await _auth.signOut();
      print('SUCCESSFUL');
      await _hive.deleteUser();
    } catch (e) {
      print(e);
    }
  }

}
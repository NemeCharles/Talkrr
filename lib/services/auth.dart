import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:text_app/user_model/user.dart';

class FireAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _userStore = FirebaseFirestore.instance.collection('user');

  // Sign Up with Email and Password

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
        ).then((value) => print('USER SAVED SUCCESSFULLY'));
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
      print('SIGN IN SUCCESSFUL');

      await _userStore.withConverter<UserData>(
          fromFirestore: (snapshot, _) => UserData.fromJson(snapshot.data()!),
          toFirestore: (userData, _) => userData.toJson()
      ).where('uid', isEqualTo: user.user?.uid).get().then((value) =>
          print('USERNAME: ${value.docs.first.data().displayName}'));

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
    } catch (e) {
      print(e);
    }
  }

}
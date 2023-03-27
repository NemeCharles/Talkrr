import 'package:firebase_auth/firebase_auth.dart';

class FireAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign Up with Email and Password

  Future<void> signUpEmail (String email, String password) async {
    try{
      UserCredential user = await _auth.
      createUserWithEmailAndPassword(email: email, password: password);
      print('SUCCESSFUL');
      print(user);
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
      print(user);
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
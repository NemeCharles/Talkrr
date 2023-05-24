import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:text_app/services/auth.dart';
import '../home_screen.dart';

final signUpController = Provider((ref) {
  final fireAuth = ref.watch(fireAuthPod);
  return SignUpController(fireAuth: fireAuth);
});

class SignUpController {
  SignUpController({required this.fireAuth});

  final FireAuth fireAuth;
  late TextEditingController email;
  late TextEditingController username;
  late TextEditingController password1;
  late TextEditingController password2;

  void initialiseController() {
    email = TextEditingController();
    username = TextEditingController();
    password1 = TextEditingController();
    password2 = TextEditingController();
  }

  void signUpWithEmail({required BuildContext context}) async {
    if(password1.text.trim() == password2.text.trim()) {
      await fireAuth.signUpEmail(email.text, password1.text, username.text.trim()).then((value) => Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => const HomeScreen())));
    } else {
      debugPrint('UNMATCHED PASSWORDS');
    }
  }

  void disposeControllers() {
    email.dispose();
    username.dispose();
    password1.dispose();
    password2.dispose();
  }

}
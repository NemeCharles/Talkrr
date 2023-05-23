import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:text_app/services/auth.dart';
import '../home_screen.dart';

final signInController = Provider<SignInController>((ref) {
  final fireAuth = ref.watch(fireAuthPod);
  return SignInController(fireAuth: fireAuth);
});

class SignInController {
  SignInController({required this.fireAuth});
  final FireAuth fireAuth;
  late TextEditingController email;
  late TextEditingController password;

  void signInWithEmail({required BuildContext context}) async {
    await fireAuth.signInEmail(email.text, password.text).then((value) => Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => const HomeScreen())));
  }

  void initialiseController() {
    email = TextEditingController();
    password = TextEditingController();
  }

  void disposeControllers() {
    email.dispose();
    password.dispose();
  }

}
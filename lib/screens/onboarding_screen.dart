import 'package:flutter/material.dart';

const Color primaryColor = Color(0XFF0BC4D9);

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF4F4F4),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           const Text(
                'Talkrr',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 28
              ),
            ),
          const SizedBox(
            child: Text(
              'Simple Secure Reliable Messaging'
            ),
          ),
          Container(
            child: Text('Get Started'),
            color: primaryColor,
          ),
          Row(
            children: const [
              Text(
                'Already have an account? '
              ),
              Text(
                  'Sign In',
                style: TextStyle(
                  color: primaryColor,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

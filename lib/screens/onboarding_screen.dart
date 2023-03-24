import 'package:flutter/material.dart';
import 'package:text_app/screens/signIn_screen.dart';
import 'package:text_app/screens/signUp_screen.dart';

const Color primaryColor = Color(0XFF0BC4D9);

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0XFFF4F4F4),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           SizedBox(height: h * 0.453,),
           const Text(
                'Talkrr',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 40,
                color: primaryColor
              ),
            ),
           SizedBox(height: h/20.96,),
           SizedBox(
            width: 230,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                 Text(
                  'Simple Secure Reliable',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500
                  ),
                ),
                Text(
                  'Messaging',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: h * 0.179,),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const SignUpScreen()
              )
              );
            },
            child: Container(
              height: 40,
              width: w * 0.703,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(15)
              ),
              child: const Text(
                'Get Started',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0XFFF4F4F4)
                ),
              ),
            ),
          ),
          SizedBox(height: h/27.95,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Already have an account? ',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) => const SignInScreen()
                    )
                  );
                },
                child: const Text(
                    'Sign In',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

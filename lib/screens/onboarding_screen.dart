import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:text_app/screens/signIn_screen.dart';
import 'package:text_app/screens/signUp_screen.dart';

const Color primaryColor = Color(0XFF0BC4D9);

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF4F4F4),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           SizedBox(height: 379.h,),
          Text(
                'Talkrr',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 40.sp,
                color: primaryColor
              ),
            ),
           SizedBox(height: 40.h,),
           SizedBox(
            width: 230,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 Text(
                  'Simple Secure Reliable',
                  style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w500
                  ),
                ),
                Text(
                  'Messaging',
                  style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w500
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 150.h,),
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
              width: 270.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(15)
              ),
              child: Text(
                'Get Started',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0XFFF4F4F4)
                ),
              ),
            ),
          ),
          SizedBox(height: 30.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account? ',
                style: TextStyle(
                  fontSize: 15.sp,
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
                child: Text(
                    'Sign In',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 15.sp,
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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:text_app/screens/signUp_screen.dart';
import '../components/account_tile.dart';
import '../components/text_fields.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  late final TextEditingController email;
  late final TextEditingController password;

  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF0BC4D9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                height: 140.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.h,),
                    Text(
                      'Sign In',
                      style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0XFFF4F4F4)
                      ),
                    ),
                    SizedBox(height: 10.h,),
                    Text(
                      'Login to an account',
                      style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0XFFF4F4F4)
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  width: double.maxFinite,
                  height: 673.5.h,
                  decoration: const BoxDecoration(
                      color: Color(0XFFF4F4F4),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)
                      )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 25.h,),
                      Text(
                        'Enter Email Address',
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(height: 8.h,),
                      TextArea(
                        controller: email,
                      ),
                      SizedBox(height: 8.h,),
                      Text(
                        'Enter Password',
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(height: 8.h,),
                      TextArea(controller: password, hintText: 'Enter Password', isPassword : true),
                      SizedBox(height: 10.h,),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.grey.withOpacity(0.7),
                            wordSpacing: 1.5,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h,),
                      GestureDetector(
                        onTap: () async {},
                        child: Container(
                          height: 40,
                          width: 344.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: const Color(0XFF0BC4D9),
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0XFFF4F4F4)
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25.h,),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Or Connect With',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            color: Colors.grey.withOpacity(0.7),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          AccountImageTile(imagePath: 'google.png',),
                          AccountImageTile(imagePath: 'apple.png',),
                          AccountImageTile(imagePath: 'facebook.png',),
                        ],
                      ),
                      SizedBox(height: 180.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.grey.withOpacity(0.7),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (BuildContext context) => const SignUpScreen()
                                  )
                              );
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  color: const Color(0XFF0BC4D9),
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}

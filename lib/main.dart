import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:text_app/firebase_options.dart';
import 'package:text_app/screens/onboarding_screen.dart';
import 'package:text_app/storage_services/hive_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveServices.initialiseBoxes();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(384, 838.4),
      builder: (context, child) {
        return MaterialApp(
          title: 'Talkrr',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          home: const OnBoardingScreen(),
        );
      },
    );
  }
}
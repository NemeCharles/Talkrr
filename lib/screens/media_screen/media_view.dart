import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../components/text_fields.dart';

class MediaViewScreen extends StatelessWidget {
  const MediaViewScreen({Key? key, required this.image}) : super(key: key);

  final File image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        height: 830.h,
        child: Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(height: 30.h,),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 740.h
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(image)
                        )
                      ),
                    ),
                  ),
                ],
          ),
            ),
            Positioned(
              bottom: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: SizedBox(
                  width: 384.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const MediaMessageField(),
                      InkWell(
                        child: Container(
                          height: 45.h,
                          width: 45.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: const Color(0XFF202020)
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.send,
                              color: Color(0XFF0BC4D9),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
        ]
        ),
      ),
    );
  }
}


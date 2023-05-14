import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class OutgoingCall extends StatefulWidget {
  const OutgoingCall({Key? key}) : super(key: key);

  @override
  State<OutgoingCall> createState() => _OutgoingCallState();
}

class _OutgoingCallState extends State<OutgoingCall> {

  final String testImage = 'https://firebasestorage.googleapis.com/v0/b/chat-app-96c03.appspot.com/o/images%2FtestImage?alt=media&token=338145f0-9d7d-43d5-9c1b-0e8dd2c949f0';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF4F4F4),
      body: Container(
        width: 384.w,
        height: 838.4.h,
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            image: DecorationImage(
              image: NetworkImage(testImage,),
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high
            )
        ),
        padding: const EdgeInsets.only(top: 35, bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 90.h,
              width: 345.w,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black.withOpacity(0.4)
              ),
              child: Row(
                children: [
                  Container(
                    height: 60.h,
                    width: 60.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.2),
                      image: DecorationImage(
                        image: NetworkImage(testImage,),
                        fit: BoxFit.cover,
                      )
                    ),
                  ),
                  SizedBox(width: 10.w,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 25.h,),
                      Text(
                        'Grim Reaper',
                        style: TextStyle(
                          fontSize: 27.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0XFFF4F4F4)
                        ),
                      ),
                      SizedBox(height: 5.h,),
                      Text(
                        'Connecting...',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0XFFF4F4F4)
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: 80.h,
              width: 360.w,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black.withOpacity(0.5)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Container(
                      height: 50.h,
                      width: 50.w,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Color(0XFFF4F4F4),
                        shape: BoxShape.circle
                      ),
                      child: Icon(
                        Icons.videocam_off,
                        color: Colors.black,
                        size: 30.sp,
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      height: 50.h,
                      width: 50.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle
                      ),
                      child: Icon(
                        Icons.mic,
                        color: const Color(0XFFF4F4F4),
                        size: 30.sp,
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      height: 50.h,
                      width: 50.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle
                      ),
                      child: Icon(
                        Icons.volume_up,
                        color: const Color(0XFFF4F4F4),
                        size: 30.sp,
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      height: 50.h,
                      width: 50.w,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle
                      ),
                      child: Icon(
                        Icons.call_end,
                        color: const Color(0XFFF4F4F4),
                        size: 30.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const String whiteSpace = '           ';

class LeftTextBubble extends StatelessWidget {
  const LeftTextBubble({Key? key,
    required this.message,
    required this.timeSent
  }) : super(key: key);

  final String message;
  final String timeSent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 10.w),
      child: Align(
        alignment: Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minWidth: 10.w,
              minHeight: 31.h,
              maxWidth: 300.w,
              maxHeight: 350.h
          ),
          child: Container(
            padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 7.h, bottom: 7.h),
            decoration: BoxDecoration(
              color: const Color(0XFF0BC4D9).withOpacity(0.26),
              borderRadius: BorderRadius.circular(19),
            ),
            child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Text(
                    '$message$whiteSpace',
                    style: TextStyle(
                        color: Colors.black87.withOpacity(0.67),
                        fontSize: 17.sp
                    ),

                  ),
                  Positioned(
                    right: 0,
                    bottom: -4,
                    child: Text(
                      timeSent,
                      style: TextStyle(
                          fontSize: 12.5.sp,
                          color: Colors.black87.withOpacity(0.57)
                      ),
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}


class RightTextBubble extends StatelessWidget {
  const RightTextBubble({Key? key,
    required this.message,
    required this.timeSent
  }) : super(key: key);

  final String message;
  final String timeSent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 10.w),
      child: Align(
        alignment: Alignment.centerRight,
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minWidth: 10.w,
              minHeight: 31.h,
              maxWidth: 300.w,
              maxHeight: 350.h
          ),
          child: Container(
            padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 7.h, bottom: 7.h),
            decoration: BoxDecoration(
              color: const Color(0XFF0BC4D9),
              borderRadius: BorderRadius.circular(19),
            ),
            child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Text(
                    '$message$whiteSpace',
                    style: TextStyle(
                        color: const Color(0XFFF4F4F4),
                        fontSize: 17.sp
                    ),

                  ),
                  Positioned(
                    right: 0,
                    bottom: -4,
                    child: Text(
                      timeSent,
                      style: TextStyle(fontSize: 12.5.sp, color: const Color(0XFFF4F4F4)),
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}

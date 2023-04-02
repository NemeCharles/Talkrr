import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CallTile extends StatelessWidget {
  const CallTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        height: 80.h,
        width: 384.w,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 27,
            ),
            SizedBox(width: 20.w,),
            SizedBox(
              height: 80.h,
              width: 280.w,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Meh.',
                        style: TextStyle(
                            fontSize: 19.sp,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(height: 13.h,),
                      Text(
                        'Today, 13:08',
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.grey.withOpacity(0.9)
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    // color: Colors.red,
                    width: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(
                          Icons.phone,
                          size: 30,
                          color: Color(0XFF0BC4D9),
                        ),
                        Icon(
                          Icons.videocam,
                          size: 30,
                          color: Color(0XFF0BC4D9),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

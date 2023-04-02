import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageTile extends StatelessWidget {
  const MessageTile({
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
              width: 280.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Meh.',
                        style: TextStyle(
                            fontSize: 19.sp,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      const Text(
                        'Yesterday',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0XFF0BC4D9)
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 7.h,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Hello',
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.grey.withOpacity(0.9)
                        ),
                      ),
                      Container(
                        height: 20.h,
                        width: 20.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0XFF0BC4D9)
                        ),
                        child: Center(
                            child: Text(
                              '1',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500
                              ),
                            )
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

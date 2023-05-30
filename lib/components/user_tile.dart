import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../screens/chat_screen/chat_screen.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    required this.displayName,
    required this.profilePic,
    required this.userId,
    super.key,
  });

  final String profilePic;
  final String displayName;
  final String userId;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => ChatScreen(
                uid: userId,
                displayName: displayName,
                profile: profilePic
            )
            )
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        height: 65.h,
        width: 384.w,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 27.r,
            ),
            SizedBox(width: 20.w,),
            SizedBox(
              width: 280.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15.h,),
                  Text(
                    displayName,
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500
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

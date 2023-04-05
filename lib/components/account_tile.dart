import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountImageTile extends StatelessWidget {
  const AccountImageTile({
    super.key, required this.imagePath,
  });

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
        child: Container(
          height: 50.h,
          width: 50.w,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.grey.withOpacity(0.08),
          ),
          child: Image.asset('images/$imagePath'),
        ),
      ),
    );
  }
}

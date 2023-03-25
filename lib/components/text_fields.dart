import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextArea extends StatelessWidget {
  const TextArea({
    super.key,
    this.hintText = 'Enter Email',
    this.isPassword = false,
    this.isUsername = false,
  });

  final String hintText;
  final bool isPassword;
  final bool isUsername;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      margin: const EdgeInsets.only(left: 7),
      width: 344.w,
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.08),
          borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 270.w,
            child: TextField(
              keyboardType: isUsername ? TextInputType.name : isPassword ? TextInputType.visiblePassword  : TextInputType.emailAddress,
              autocorrect: false,
              style: TextStyle(fontSize: 17.sp),
              decoration: InputDecoration(
                hintText: hintText,
                fillColor: Colors.grey.withOpacity(0.5),
                focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
                enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
          isPassword ? const Icon(Icons.remove_red_eye_outlined) : const SizedBox()
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextArea extends StatelessWidget {
  const TextArea({
    super.key,
    this.hintText = 'Enter Email',
    this.isPassword = false,
    this.isUsername = false,
    required this.controller
  });

  final String hintText;
  final bool isPassword;
  final bool isUsername;
  final TextEditingController controller;

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
              controller: controller,
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


class MessageField extends StatelessWidget {
  const MessageField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 315.w,
      height: 50.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.15),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.emoji_emotions,
            size: 28.sp,
            color: const Color(0XFF0BC4D9),
          ),
          SizedBox(width: 7.w,),
          SizedBox(
            width: 250,
            child: TextFormField(
              keyboardType: TextInputType.multiline,
              style: TextStyle(fontSize: 18.sp),
              maxLines: 3,
              minLines: 1,
              cursorHeight: 20.h,
              decoration: const InputDecoration(
                  hintText: 'Type your message',
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.zero
              ),
            ),
          )
        ],
      ),
    );
  }
}


class MediaMessageField extends StatelessWidget {
  const MediaMessageField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 315.w,
      height: 50.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: const Color(0XFF202020),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.emoji_emotions,
            size: 28.sp,
            color: const Color(0XFF0BC4D9),
          ),
          SizedBox(width: 7.w,),
          SizedBox(
            width: 250,
            child: TextFormField(
              style: TextStyle(fontSize: 18.sp, color: const Color(0XFFF4F4F4)),
              maxLines: 1,
              minLines: 1,
              cursorHeight: 20.h,
              decoration: const InputDecoration(
                  hintText: 'Add a caption',
                  hintStyle: TextStyle(color: Color(0XFFF4F4F4)),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.zero
              ),
            ),
          )
        ],
      ),
    );
  }
}

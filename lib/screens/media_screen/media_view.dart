import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import '../../components/text_fields.dart';

class MediaViewScreen extends StatefulWidget {
  const MediaViewScreen({Key? key,
    required this.image,
    required this.tag
  }) : super(key: key);

  final File image;
  final String tag;

  @override
  State<MediaViewScreen> createState() => _MediaViewScreenState();
}

class _MediaViewScreenState extends State<MediaViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        height: 830.h,
        child: Stack(children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              margin: const EdgeInsets.only(top: 55),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 700.h),
                child: ClipRect(
                  child: PhotoView(
                    imageProvider: FileImage(widget.image),
                    minScale: PhotoViewComputedScale.contained * 1,
                    maxScale: PhotoViewComputedScale.covered * 2,
                    heroAttributes: PhotoViewHeroAttributes(tag: widget.tag),
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 70.h,
            left: 10.w,
            child: SizedBox(
              width: 360.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      borderRadius: BorderRadius.circular(50),
                      child: SizedBox(
                        height: 45.h,
                        width: 45.w,
                        child: Center(
                          child: Icon(
                            Icons.close,
                            size: 33,
                            color: Colors.white,
                            shadows: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.6),
                                spreadRadius: 5,
                                blurRadius: 5,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {},
                      borderRadius: BorderRadius.circular(50),
                      child: SizedBox(
                        height: 45.h,
                        width: 45.w,
                        child: Center(
                          child: Icon(
                            Icons.crop_rotate,
                            size: 30,
                            color: Colors.white,
                            shadows: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.6),
                                spreadRadius: 5,
                                blurRadius: 5,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        onTap: () async {},
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          height: 45.h,
                          width: 45.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: const Color(0XFF202020)),
                          child: const Center(
                            child: Icon(
                              Icons.send,
                              color: Color(0XFF0BC4D9),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}

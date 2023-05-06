import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:photo_view/photo_view.dart';
import 'package:video_trimmer/video_trimmer.dart';
import '../../components/text_fields.dart';

class VideoEditorScreen extends StatefulWidget {
  const VideoEditorScreen({Key? key,
    required this.video,
    required this.tag
  }) : super(key: key);

  final File video;
  final String tag;

  @override
  State<VideoEditorScreen> createState() => _VideoEditorScreenState();
}

class _VideoEditorScreenState extends State<VideoEditorScreen> {

  final _trimmer = Trimmer();
  double startValue = 0;
  double endValue = 0;
  late File videoFile;
  bool isPlaying = false;

  @override
  void initState() {
    videoFile = widget.video;
    _trimmer.loadVideo(videoFile: videoFile);
    super.initState();
  }


  @override
  void dispose() {
    _trimmer.dispose();
    super.dispose();
  }

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
            child: Container(
              margin: const EdgeInsets.only(top: 55),
              child: GestureDetector(
                onTap: () async {
                  final playbackState = await _trimmer.videoPlaybackControl(
                    startValue: startValue,
                    endValue: endValue
                  );
                  setState(() => isPlaying = playbackState);
                },
                child: Hero(
                  tag: widget.tag,
                  child: SizedBox(
                    height: 700.h,
                    child: VideoViewer(
                      trimmer: _trimmer,
                    ),
                  ),
                ),
              ),
            ),
          ),
            Positioned(
            top: 70.h,
            left: 10.w,
            child: ClipRRect(
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
          ),
            Positioned(
              top: 107.h,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: TrimViewer(
                  trimmer: _trimmer,
                  viewerHeight: 40.h,
                  viewerWidth: 370.w,
                  durationStyle: DurationStyle.FORMAT_MM_SS,
                  maxVideoLength: Duration(minutes: _trimmer.videoPlayerController!.value.duration.inMinutes),
                  onChangeStart: (value) => startValue = value,
                  onChangeEnd: (value) => endValue = value,
                  onChangePlaybackState: (value) => setState(() => isPlaying = value),
                ),
              ),
            ),
            Positioned(
              top: 350.h,
              left: 160.w,
              child: Visibility(
                visible: !isPlaying,
                child: Container(
                  height: 70.h,
                  width: 70.w,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    color: const Color(0XFFF4F4F4),
                    size: 45.sp,
                  ),
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


class ImageEditorScreen extends StatefulWidget {
  const ImageEditorScreen({Key? key,
    required this.image,
    required this.tag
  }) : super(key: key);

  final File image;
  final String tag;

  @override
  State<ImageEditorScreen> createState() => _ImageEditorScreenState();
}

class _ImageEditorScreenState extends State<ImageEditorScreen> {

  late File image;
  void cropImage () async {
    final test = await ImageCropper().cropImage(
        sourcePath: widget.image.path,
        uiSettings: [
          AndroidUiSettings(
            lockAspectRatio: false,
            initAspectRatio: CropAspectRatioPreset.original,
            hideBottomControls: true
          )
        ]
    );
    if(test == null) return;
    final imageFile = File(test.path);
    setState(() {
      image = imageFile;
    });
  }

  @override
  void initState() {
    image = widget.image;
    super.initState();
  }

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
                    imageProvider: FileImage(image),
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
                      onTap: () {
                        cropImage();
                      },
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

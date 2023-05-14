import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:text_app/screens/media_screen/media_screen.dart';
import '../../components/text_fields.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';

class BottomChatField extends StatefulWidget {
  const BottomChatField({Key? key}) : super(key: key);

  @override
  State<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends State<BottomChatField> {

  bool isCancelled = false;
  bool isRecording = false;
  double left = 301.w;
  double containerW = 319.w;
  FlutterSoundRecorder? recorder;
  String? path = '';

  void initialiseRecorder() async {
    recorder= FlutterSoundRecorder();
    await recorder!.openRecorder();
  }

  void disposeRecorder() async {
    await recorder!.closeRecorder();
  }

  void startRecording() async {
    final status = await Permission.microphone.request();
    if(status != PermissionStatus.granted) {
      throw RecordingPermissionException('MICROPHONE PERMISSION NOT GRANTED');
    }
    Directory tempDir = await getTemporaryDirectory();
    path = '${tempDir.path}/voice_note.aac';
    await recorder!.startRecorder(toFile: path, codec: Codec.defaultCodec);
    setState(() {
      isRecording = true;
    });
    startTimer();
  }

  void cancelRecording() async {
    await recorder!.stopRecorder();
    setState(() {
      left = 301.w;
      containerW = 319.w;
      isCancelled = true;
      isRecording = false;
      stopTimer();
    });
  }

  void sendRecording() async {
      isCancelled = false;
      if(!isRecording) {
        setState(() {
          isRecording = false;
          left = 301.w;
          containerW = 319.w;
          stopTimer();
        });
      } else {
        await recorder!.stopRecorder();
        setState(() {
          isRecording = false;
          left = 301.w;
          containerW = 319.w;
          stopTimer();
        });
      File file = File(path!);
      }
  }

  Duration duration = const Duration();
  Timer? timer;
  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        final time = duration.inSeconds + 1;
        duration = Duration(seconds: time);
      });
    });
  }
  void stopTimer() {
      timer!.cancel();
      duration = const Duration();
  }
  String secondsDigits(int seconds) => seconds.toString().padLeft(2, '0');

  @override
  void initState() {
    initialiseRecorder();
    super.initState();
  }

  @override
  void dispose() {
    disposeRecorder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String minutes = duration.inMinutes.remainder(60).toString();
    String seconds = secondsDigits(duration.inSeconds.remainder(60));
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          height: 70.h,
          width: 384.w,
        ),
        Positioned(
          bottom: 7.h,
          left: 5.w,
          child: Opacity(
              opacity: !isRecording ? 1 : 0,
              child: MessageField(onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (
                        BuildContext context) => const MediaScreen())
                );
              },)
          ),
        ),
        Positioned(
          bottom: 7.h,
          left: 8.w,
          child: Visibility(
            visible: isRecording,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              height: 50.h,
              width: containerW,
              padding: const EdgeInsets.only(right: 35, left: 10),
              decoration: BoxDecoration(
                  color: const Color(0XFFE8E8E8),
                  borderRadius: BorderRadius.circular(30)
              ),
              child: Stack(
                children: [
                  SizedBox(
                    height: 50.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          size: 12.sp,
                          color: const Color(0XFF0BC4D9),
                        ),
                        Text(
                          'Slide to cancel',
                          style: TextStyle(
                              color: const Color(0XFF0BC4D9),
                              fontSize: 16.sp
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 50,
                    color: const Color(0XFFE8E8E8),
                    child: Row(
                      children: [
                        Icon(
                          Icons.mic,
                          size: 27.sp,
                          color: Colors.red,
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          '$minutes:$seconds',
                          style: TextStyle(
                              color: const Color(0XFF0BC4D9),
                              fontSize: 16.sp
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 150),
          curve: Curves.bounceOut,
          left: isRecording ? left : 327.w,
          bottom: isRecording ? -5.h : 7.h,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onLongPressStart: (details) {
              startRecording();
            },
            onLongPressEnd: (details) {
              sendRecording();
            },
            onLongPressMoveUpdate: (update) {
              double dx = update.globalPosition.dx;
              if(!isCancelled) {
                if(dx < 155.w) {
                  cancelRecording();
                } else if(dx > 302.w) {}
                else {
                  setState(() {
                    left = dx.w;
                    containerW = dx.w + 20;
                    isCancelled = false;
                  });
                }
              }
              if(isCancelled) {
                debugPrint('LET GO');
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeIn,
              height: isRecording ? 80.h : 50.h,
              width: isRecording ? 80.w : 50.w,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0XFF0BC4D9)
              ),
              child: Center(
                child: Icon(
                  Icons.mic,
                  color: const Color(0XFFF4F4F4),
                  size: isRecording ? 40.sp : 25.sp,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

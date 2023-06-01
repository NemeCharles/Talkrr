import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:audioplayers/audioplayers.dart';
import 'custom_track_shape.dart';
import 'enums/message_type.dart';

class RightMessage extends StatelessWidget {
  const RightMessage({Key? key,
    required this.message,
    required this.timeSent,
    required this.isRightMessage,
    required this.messageType}) : super(key: key);

  final MessageType messageType;
  final String message;
  final DateTime timeSent;
  final String whiteSpace = '           .';
  final bool isRightMessage;
  String secondsDigits(int time) => time.toString().padLeft(2, '0');



  @override
  Widget build(BuildContext context) {
    switch(messageType) {
      case MessageType.text:
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
                          '${secondsDigits(timeSent.hour)}:${secondsDigits(timeSent.minute)}',
                          style: TextStyle(fontSize: 12.5.sp, color: const Color(0XFFF4F4F4)),
                        ),
                      )
                    ]),
              ),
            ),
          ),
        );
      case MessageType.image:
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
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h,),
                decoration: BoxDecoration(
                  color: const Color(0XFF0BC4D9),
                  borderRadius: BorderRadius.circular(19),
                ),
                child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(19),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  message
                                )
                            )
                        ),
                      ),
                      Positioned(
                        right: 15,
                        bottom: 2,
                        child: Container(
                          height: 30,
                          width: 90,
                          alignment: Alignment.bottomRight,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    blurRadius: 15,
                                    spreadRadius: 5,
                                    offset: const Offset(10, -3)
                                )
                              ]
                          ),
                          child: Text(
                            '${secondsDigits(timeSent.hour)}:${secondsDigits(timeSent.minute)} ',
                            style: TextStyle(
                              fontSize: 12.5.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ]),
              ),
            ),
          ),
        );
      case MessageType.video:
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
                          '${secondsDigits(timeSent.hour)}:${secondsDigits(timeSent.minute)}',
                          style: TextStyle(fontSize: 12.5.sp, color: const Color(0XFFF4F4F4)),
                        ),
                      )
                    ]),
              ),
            ),
          ),
        );
      case MessageType.audio:
        return AudioPlayers(
            url: message,
            isRightMessage: isRightMessage,
            timeSent: '${secondsDigits(timeSent.hour)}:${secondsDigits(timeSent.minute)}'
        );
    }
  }
}

class LeftMessage extends StatelessWidget {
  const LeftMessage({Key? key,
    required this.message,
    required this.timeSent,
    required this.isRightMessage,
    required this.messageType}) : super(key: key);

  final MessageType messageType;
  final String message;
  final DateTime timeSent;
  final bool isRightMessage;
  final String whiteSpace = '           .';

  String secondsDigits(int time) => time.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    switch(messageType) {
      case MessageType.text:
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
                 color: const Color(0XFFE8E8E8),
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
                         '${secondsDigits(timeSent.hour)}:${secondsDigits(timeSent.minute)} ',
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
      case MessageType.image:
       return  Padding(
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
               padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h,),
               decoration: BoxDecoration(
                 color: const Color(0XFF0BC4D9).withOpacity(0.26),
                 borderRadius: BorderRadius.circular(19),
               ),
               child: Stack(
                   children: [
                     Container(
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(19),
                           image: DecorationImage(
                               fit: BoxFit.cover,
                               image: NetworkImage(
                                   message
                               )
                           )
                       ),
                     ),
                     Positioned(
                       right: 15,
                       bottom: 2,
                       child: Container(
                         height: 30,
                         width: 90,
                         alignment: Alignment.bottomRight,
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(50),
                             boxShadow: [
                               BoxShadow(
                                   color: Colors.black.withOpacity(0.25),
                                   blurRadius: 15,
                                   spreadRadius: 5,
                                   offset: const Offset(10, -3)
                               )
                             ]
                         ),
                         child: Text(
                           '${secondsDigits(timeSent.hour)}:${secondsDigits(timeSent.minute)} ',
                           style: TextStyle(
                             fontSize: 12.5.sp,
                             color: Colors.white,
                           ),
                         ),
                       ),
                     )
                   ]),
             ),
           ),
         ),
       );
      case MessageType.video:
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
                  color: const Color(0XFFE8E8E8),
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
                          '${secondsDigits(timeSent.hour)}:${secondsDigits(timeSent.minute)} ',
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
      case MessageType.audio:
        return AudioPlayers(
            url: message,
            isRightMessage: isRightMessage,
            timeSent: '${secondsDigits(timeSent.hour)}:${secondsDigits(timeSent.minute)}'
        );
    }
  }
}


class AudioPlayers extends StatefulWidget {
  const AudioPlayers({Key? key,
    required this.url,
    required this.isRightMessage,
    required this.timeSent}) : super(key: key);
  final String url;
  final String timeSent;
  final bool isRightMessage;

  @override
  State<AudioPlayers> createState() => _AudioPlayersState();
}

class _AudioPlayersState extends State<AudioPlayers> {

  final audioPlayer = AudioPlayer();
  Duration duration =  const Duration();
  Duration position = const Duration();
  bool isPlaying = false;

  void setSource() async {
    await audioPlayer.setSource(UrlSource(widget.url));
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });
    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
    audioPlayer.onPlayerComplete.listen((event) async {
      await audioPlayer.setSource(UrlSource(widget.url));
      setState(() {
        position = const Duration(seconds: 0);
        isPlaying = false;
      });
    });
    audioPlayer.onPlayerStateChanged.listen((playState) {
      if(playState == PlayerState.stopped && mounted) setState(() => isPlaying = false);
      if(playState == PlayerState.playing) setState(() => isPlaying = true);
      if(playState == PlayerState.paused) setState(() => isPlaying = false);
    });
  }
  List<String> splitDuration(Duration duration) {
    List<String> durationList = duration.toString().split(".")[0].split(":");
    return durationList;
  }

  @override
  void initState() {
    setSource();
    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 10.w),
      child: Align(
        alignment: widget.isRightMessage ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          height: 70,
          width: 200,
          padding: EdgeInsets.only(right: 7.w, left:7.w, top: 5.h),
          decoration: BoxDecoration(
            color: widget.isRightMessage ? const Color(0XFF0BC4D9) : const Color(0XFF0BC4D9).withOpacity(0.26),
            borderRadius: BorderRadius.circular(19),
          ),
          child: Column(
            children: [
              SizedBox(
                width: 180.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if(isPlaying) audioPlayer.pause();
                        if(!isPlaying) audioPlayer.resume();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 45.h,
                        width: 45.w,
                        decoration: BoxDecoration(
                            color: widget.isRightMessage ? const Color(0XFFF4F4F4) : const Color(0XFFF5F5F5),
                            shape: BoxShape.circle
                        ),
                        child: Icon(
                          isPlaying? Icons.pause : Icons.play_arrow,
                          color: widget.isRightMessage ? const Color(0XFF0BC4D9) : const Color(0XFF0BC4D9).withOpacity(0.5),
                          size: 30.sp,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 9),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 2.h,
                            overlayColor: Colors.transparent,
                            trackShape: CustomSliderTrackShape(),
                            thumbShape: RoundSliderThumbShape(
                                enabledThumbRadius: 5.r,
                                disabledThumbRadius: 9.r,
                                elevation: 0,
                                pressedElevation: 2
                            ),
                            activeTrackColor: widget.isRightMessage ?
                            const Color(0XFFF4F4F4) : const Color(0XFFF5F5F5),
                            inactiveTrackColor: widget.isRightMessage ?
                            const Color(0XFFF4F4F4).withOpacity(0.3) : const Color(0XFFF4F4F4).withOpacity(0.8),
                            thumbColor: widget.isRightMessage ?
                            const Color(0XFFF4F4F4) : const Color(0XFFF5F5F5),
                          ),
                          child: SizedBox(
                            height: 30,
                            width: 125,
                            child: Slider(
                              value: position.inMicroseconds.toDouble(),
                              min: 0.0,
                              max: duration.inMicroseconds.toDouble(),
                              onChanged: (value) async {
                                await audioPlayer.seek(Duration(microseconds: value.toInt()));
                              },
                            ),
                          ),
                        ),
                        Text(
                          position.inSeconds == 0 ? '${splitDuration(duration)[1]}:${splitDuration(duration)[2]}' :
                          '${splitDuration(position)[1]}:${splitDuration(position)[2]}',
                          style: TextStyle(
                              fontSize: 12.5.sp,
                              fontWeight: FontWeight.w300,
                              color: widget.isRightMessage ?
                              const Color(0XFFF4F4F4) : Colors.black87.withOpacity(0.67),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Text(
                  '${widget.timeSent}    ',
                  style: TextStyle(
                    fontSize: 12.5.sp,
                    color: widget.isRightMessage ?
                    Colors.white : Colors.black87.withOpacity(0.57),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

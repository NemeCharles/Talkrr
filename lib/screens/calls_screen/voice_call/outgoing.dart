import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';

const appId = '8eecf33c4a8a4c18a473844917119294';

class OutgoingCall extends StatefulWidget {
  const OutgoingCall({Key? key}) : super(key: key);

  @override
  State<OutgoingCall> createState() => _OutgoingCallState();
}

class _OutgoingCallState extends State<OutgoingCall> {

  final String testImage = 'https://firebasestorage.googleapis.com/v0/b/chat-app-96c03.appspot.com/o/images%2FtestImage?alt=media&token=338145f0-9d7d-43d5-9c1b-0e8dd2c949f0';
  late final RtcEngine engine;
  ChannelProfileType channelProfileType = ChannelProfileType.channelProfileLiveBroadcasting;
  bool isConnected = false;
  bool enabledSpeaker = false;
  bool enabledMic = true;
  bool userJoined = false;


  void initEngine() async {
    engine = createAgoraRtcEngine();
    await engine.initialize(const RtcEngineContext(
      appId: appId
    ));
    engine.registerEventHandler(RtcEngineEventHandler(
      onError: (ErrorCodeType err, String msg) {
        debugPrint('[onError] err: $err, msg: $msg');
      },
      onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
        debugPrint('[CHANNEL JOINED SUCCESSFULLY] connection: ${connection.toJson()} elapsed: $elapsed');
        setState(() {
          isConnected = true;
        });
      },
      onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
        debugPrint( '[USER JOINED] connection: ${connection.toJson()} uid: $remoteUid');
        setState(() {
          userJoined = true;
        });
      },
      onRtcStats: (RtcConnection connection, RtcStats stats) {
        debugPrint( '[CALL ONGOING] connection: ${connection.toJson()} duration: ${stats.duration}');
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        debugPrint( '[USER LEFT THE ROOM] connection: ${connection.toJson()} stats: ${stats.duration}');
      },
      onConnectionLost: (RtcConnection connection) {
        debugPrint( '[onConnectionStateLost] connection: ${connection.toJson()}');
      },
    ));
    await engine.enableAudio();
    await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await engine.setAudioProfile(
        profile: AudioProfileType.audioProfileDefault,
        scenario: AudioScenarioType.audioScenarioGameStreaming
    );
    await joinChannel();
  }

  Future<void> joinChannel() async {
    final micStatus = await Permission.microphone.request();
    if(micStatus != PermissionStatus.granted) {
      debugPrint('PERMISSION DENIED');
      return;
    }
    await engine.setDefaultAudioRouteToSpeakerphone(false);
    await engine.joinChannel(
      token: '007eJxTYPjJz3n51yeLpNY5/QFL9Nu3HXVlUvJkf7X+4aylLdutxdIVGCxSU5PTjI2TTRItEk2SDYGEubGFiYmlobmhoaWRpcmWJykpDYGMDGXBFcyMDBAI4gsylCTmZBcV6ZblZyan6iYn5uQwMAAAF7EkGg==',
      channelId: 'talkrr-voice-call',
      uid: 0,
      options: ChannelMediaOptions(
        channelProfile: channelProfileType,
        clientRoleType: ClientRoleType.clientRoleBroadcaster
      ),
    );
  }

  void leaveChannel() async {
    await engine.leaveChannel();
    await engine.release();
    isConnected = false;
  }

  void toggleSpeaker() async {
    await engine.setEnableSpeakerphone(!enabledSpeaker);
    setState(() {
      enabledSpeaker = !enabledSpeaker;
    });
  }
  void toggleMic() async {
    await engine.enableLocalAudio(!enabledMic);
    setState(() {
      enabledMic = !enabledMic;
    });
  }

  @override
  void initState() {
    initEngine();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    leaveChannel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF4F4F4),
      body: Container(
        width: 384.w,
        height: 838.4.h,
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            image: DecorationImage(
              image: NetworkImage(testImage,),
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high
            )
        ),
        padding: const EdgeInsets.only(top: 35, bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 90.h,
              width: 345.w,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black.withOpacity(0.4)
              ),
              child: Row(
                children: [
                  Container(
                    height: 60.h,
                    width: 60.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.2),
                      image: DecorationImage(
                        image: NetworkImage(testImage,),
                        fit: BoxFit.cover,
                      )
                    ),
                  ),
                  SizedBox(width: 10.w,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 25.h,),
                      Text(
                        'Grim Reaper',
                        style: TextStyle(
                          fontSize: 27.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0XFFF4F4F4)
                        ),
                      ),
                      SizedBox(height: 5.h,),
                      Text(
                        isConnected ?
                        'Connected...' :
                        'Connecting',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0XFFF4F4F4)
                        ),
                      ),
                    ],
                  ),
                  Text(
                    userJoined ?
                    'user has joined' :
                    'Connecting',
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0XFFF4F4F4)
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 80.h,
              width: 360.w,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black.withOpacity(0.5)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Container(
                      height: 50.h,
                      width: 50.w,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Color(0XFFF4F4F4),
                        shape: BoxShape.circle
                      ),
                      child: Icon(
                        Icons.videocam_off,
                        color: Colors.black,
                        size: 30.sp,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      toggleMic();
                    },
                    child: Container(
                      height: 50.h,
                      width: 50.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: enabledMic ? const Color(0XFFF4F4F4) :Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle
                      ),
                      child: Icon(
                        enabledMic ? Icons.mic_off : Icons.mic,
                        color: enabledMic ? Colors.black : const Color(0XFFF4F4F4),
                        size: 30.sp,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      toggleSpeaker();
                    },
                    child: Container(
                      height: 50.h,
                      width: 50.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: enabledSpeaker ? const Color(0XFFF4F4F4) :Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle
                      ),
                      child: Icon(
                        enabledSpeaker ? Icons.volume_off : Icons.volume_up,
                        color: enabledSpeaker ? Colors.black : const Color(0XFFF4F4F4),
                        size: 30.sp,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50.h,
                      width: 50.w,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle
                      ),
                      child: Icon(
                        Icons.call_end,
                        color: const Color(0XFFF4F4F4),
                        size: 30.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


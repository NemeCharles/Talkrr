import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:text_app/screens/calls_screen/incoming_call/controller.dart';
import '../../home_screen/controller.dart';
import '../voice_call/outgoing.dart';

class IncomingCallScreen extends ConsumerWidget {
  const IncomingCallScreen({Key? key}) : super(key: key);

  final String testImage = 'https://firebasestorage.googleapis.com/v0/b/chat-app-96c03.appspot.com/o/images%2FtestImage?alt=media&token=338145f0-9d7d-43d5-9c1b-0e8dd2c949f0';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        backgroundColor: const Color(0XFFF4F4F4),
        body: ref.watch(callStreamProvider).when(
            error: (error, stackTrace) => Center(child: Text(error.toString())),
            loading: () => const SizedBox(),
            data: (value) {
              final callDetails = value.data();
              return Stack(
                children: [
                  Container(
                    height: 838.3.h,
                    width: 384.w,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(testImage,),
                          fit: BoxFit.cover,
                        )
                    ),
                  ),
                  ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 160.h,
                            child: SizedBox(
                              height: 200.h,
                              width: 384.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 120.h,
                                    width: 120.w,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: NetworkImage(testImage,),
                                          fit: BoxFit.cover,
                                        )
                                    ),
                                  ),
                                  SizedBox(height: 12.h,),
                                  Text(
                                    callDetails!.callerName ?? '',
                                    style: TextStyle(
                                        fontSize: 30.sp,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0XFFF4F4F4),
                                        shadows: const [
                                          BoxShadow(
                                              blurRadius: 1,
                                              spreadRadius: 3
                                          )
                                        ]
                                    ),
                                  ),
                                  SizedBox(height: 6.h,),
                                  Text(
                                    callDetails.isVoiceCall
                                        ? 'Incoming voice call...'
                                        : 'Incoming video call...',
                                    style: TextStyle(
                                        color: const Color(0XFFF4F4F4),
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 1,
                                        shadows: const [
                                          BoxShadow(
                                              blurRadius: 1,
                                              spreadRadius: 2
                                          )
                                        ]
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 110.h,
                            left: 60.w,
                            child: GestureDetector(
                              onTap: () {
                                ref.read(incomingCallController).cancelCall();
                              },
                              child: Container(
                                height: 65.h,
                                width: 65.w,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle
                                ),
                                child: Icon(
                                  Icons.call_end_outlined,
                                  color: Colors.white,
                                  size: 35.sp,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 110.h,
                            right: 60.w,
                            child: GestureDetector(
                              onTap: () async {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (
                                        BuildContext context) => const OutgoingCall())
                                );
                                await Future.delayed(const Duration(seconds: 1),);
                                ref.read(overLayProvider).remove();
                              },
                              child: Container(
                                height: 65.h,
                                width: 65.w,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle
                                ),
                                child: Icon(
                                  Icons.call,
                                  color: Colors.white,
                                  size: 35.sp,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
        )

      // StreamBuilder<DocumentSnapshot<CallModel?>>(
      //   stream: _manager.watchForCalls(),
      //   builder: (context, snapshot) {
      //     final caller = snapshot.data?.data();
      //     if(caller != null) {
      //       return Stack(
      //         children: [
      //           Container(
      //             height: 838.3.h,
      //             width: 384.w,
      //             decoration: BoxDecoration(
      //                 image: DecorationImage(
      //                   image: NetworkImage(testImage,),
      //                   fit: BoxFit.cover,
      //                 )
      //             ),
      //           ),
      //           ClipRect(
      //             child: BackdropFilter(
      //               filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      //               child: Stack(
      //                 children: [
      //                   Positioned(
      //                     top: 160.h,
      //                     child: SizedBox(
      //                       height: 200.h,
      //                       width: 384.w,
      //                       child: Column(
      //                         crossAxisAlignment: CrossAxisAlignment.center,
      //                         children: [
      //                           Container(
      //                             height: 120.h,
      //                             width: 120.w,
      //                             decoration: BoxDecoration(
      //                                 shape: BoxShape.circle,
      //                                 image: DecorationImage(
      //                                   image: NetworkImage(testImage,),
      //                                   fit: BoxFit.cover,
      //                                 )
      //                             ),
      //                           ),
      //                           SizedBox(height: 12.h,),
      //                           Text(
      //                             caller.callerName ?? '',
      //                             style: TextStyle(
      //                                 fontSize: 30.sp,
      //                                 fontWeight: FontWeight.w400,
      //                                 color: const Color(0XFFF4F4F4),
      //                                 shadows: const [
      //                                   BoxShadow(
      //                                       blurRadius: 1,
      //                                       spreadRadius: 3
      //                                   )
      //                                 ]
      //                             ),
      //                           ),
      //                           SizedBox(height: 6.h,),
      //                           Text(
      //                             caller.isVoiceCall
      //                                 ? 'Incoming voice call...'
      //                                 : 'Incoming video call...',
      //                             style: TextStyle(
      //                                 color: const Color(0XFFF4F4F4),
      //                                 fontSize: 13.sp,
      //                                 fontWeight: FontWeight.w400,
      //                                 letterSpacing: 1,
      //                                 shadows: const [
      //                                   BoxShadow(
      //                                       blurRadius: 1,
      //                                       spreadRadius: 2
      //                                   )
      //                                 ]
      //                             ),
      //                           )
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                   Positioned(
      //                     bottom: 110.h,
      //                     left: 60.w,
      //                     child: GestureDetector(
      //                       onTap: () {
      //                         _manager.endCall();
      //                       },
      //                       child: Container(
      //                         height: 65.h,
      //                         width: 65.w,
      //                         alignment: Alignment.center,
      //                         decoration: const BoxDecoration(
      //                             color: Colors.red,
      //                             shape: BoxShape.circle
      //                         ),
      //                         child: Icon(
      //                           Icons.call_end_outlined,
      //                           color: Colors.white,
      //                           size: 35.sp,
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                   Positioned(
      //                     bottom: 110.h,
      //                     right: 60.w,
      //                     child: GestureDetector(
      //                       onTap: () async {
      //                         Navigator.push(context,
      //                             MaterialPageRoute(builder: (
      //                                 BuildContext context) => const OutgoingCall())
      //                         );
      //                         await Future.delayed(const Duration(seconds: 1),);
      //                         ref.read(overLayProvider).remove();
      //                       },
      //                       child: Container(
      //                         height: 65.h,
      //                         width: 65.w,
      //                         alignment: Alignment.center,
      //                         decoration: const BoxDecoration(
      //                             color: Colors.green,
      //                             shape: BoxShape.circle
      //                         ),
      //                         child: Icon(
      //                           Icons.call,
      //                           color: Colors.white,
      //                           size: 35.sp,
      //                         ),
      //                       ),
      //                     ),
      //                   )
      //                 ],
      //               ),
      //             ),
      //           ),
      //         ],
      //       );
      //     }
      //     return const SizedBox();
      //   }
      // ),
    );
  }
}


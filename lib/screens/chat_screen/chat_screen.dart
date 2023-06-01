import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../components/message_tiles.dart';
import '../../services/calls.dart';
import '../calls_screen/voice_call/outgoing.dart';
import 'bottom_chat_field.dart';
import 'controller.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({Key? key,
    required this.uid,
    required this.displayName,
    required this.profile,}) : super(key: key);
  final String uid;
  final String displayName;
  final String profile;
  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}


class _ChatScreenState extends ConsumerState<ChatScreen> {

  final String image = 'https://firebasestorage.googleapis.com/v0/b/chat-app-96c03.appspot.com/o/images%2FtestImage?alt=media&token=338145f0-9d7d-43d5-9c1b-0e8dd2c949f0';

  final CallManager _manager = CallManager();

  @override
  void initState() {
    ref.read(chatScreenController).assignReceiverInfo(uid: widget.uid, receiverName: widget.displayName, profile: widget.profile);
    ref.read(chatScreenController).initialise();
    ref.read(chatScreenController).resetCount();
    super.initState();
  }

  @override
  void deactivate() {
    ref.read(chatScreenController).disposeControllers();
    ref.read(chatScreenController).resetCount();
    super.deactivate();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF4F4F4),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              height: 60.h,
              decoration: BoxDecoration(
                color: const Color(0XFFF4F4F4),
                border: Border(
                  bottom: BorderSide(color: Colors.grey.withOpacity(0.4))
                )
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 230,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          borderRadius: BorderRadius.circular(25),
                          child: SizedBox(
                            width: 70,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.arrow_back,
                                  size: 25.sp,
                                  color: const Color(0XFF0BC4D9),
                                ),
                                Container(
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            image
                                        )
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 7.w,),
                        SizedBox(
                          width: 152.w,
                          child: Text(
                            widget.displayName,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 23.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    height: 35,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (BuildContext context) => const OutgoingCall())
                            );
                            // _manager.receiveCall(true);
                          },
                          child: Container(
                            width: 49,
                            height: 35,
                            decoration: const BoxDecoration(
                              color: Color(0XFFE8E8E8),
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(30)
                              )
                            ),
                            child: Center(
                              child: Icon(
                                Icons.phone,
                                size: 20.sp,
                                color: const Color(0XFF0BC4D9),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _manager.receiveCall(false);
                          },
                          child: Container(
                            width: 49,
                            height: 35,
                            decoration: const BoxDecoration(
                                color: Color(0XFFE8E8E8),
                                borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(30)
                                )
                            ),
                            child: Icon(
                              Icons.videocam,
                              size: 20.sp,
                              color: const Color(0XFF0BC4D9),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ref.watch(chatStream).when(
                error: (error, stacktrace) => Center(child: Text(error.toString()),),
                loading: () => const Center(child: Text('loading...'),),
                data: (chats) {
                  return CustomScrollView(
                    controller: ref.watch(chatScreenController).scrollController,
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final chat = chats[index];
                          DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(chat.deliveredTime!.millisecondsSinceEpoch);
                          if(chat.senderUid == widget.uid) {
                            return LeftMessage(
                              messageType: chat.messageType!,
                              message: chat.message!,
                              timeSent: dateTime,
                              isRightMessage: false,
                            );
                          }
                          return RightMessage(
                            messageType: chat.messageType!,
                            message: chat.message!,
                            timeSent: dateTime,
                            isRightMessage: true,
                          );
                        },
                        childCount: chats.length,
                        ),
                      )
                    ],
                  );
                }
              ),
            ),
            BottomChatField(
              onTap: () async {
                ref.read(chatScreenController).sendMessage(
                  message: ref.watch(chatScreenController).message.text.trim(),
                );
                setState(() {
                  ref.read(chatScreenController).clearText();
                });
              },
            )
          ],
        ),
      ),
    );
  }
}

//   https://firebasestorage.googleapis.com/v0/b/chat-app-96c03.appspot.com/o/images%2FtestImage?alt=media&token=338145f0-9d7d-43d5-9c1b-0e8dd2c949f0
//    https://firebasestorage.googleapis.com/v0/b/chat-app-96c03.appspot.com/o/images%2FtestImage1?alt=media&token=fedf53c3-491a-4600-8b3c-7b4f99a91511

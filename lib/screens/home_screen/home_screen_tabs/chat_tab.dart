import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:text_app/screens/home_screen/controller.dart';

import '../../../components/massage_tile.dart';
import '../../chat_screen/chat_screen.dart';
import '../../user_list_screen/users_list.dart';

class ChatsTabView extends ConsumerWidget {
  const ChatsTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: Stack(
        children: [
          ref.watch(dmStream).when(
            error: (error, stacktrace) => Center(child: Text(error.toString())),
            loading: () => const SizedBox(),
            data: (dms) {
              return CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final dm = dms[index];
                      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(dm.lastTime!.millisecondsSinceEpoch);
                      if(dms.isNotEmpty) {
                        return InkWell(
                          splashColor: Colors.transparent,
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (BuildContext context) => ChatScreen(
                                  uid: dm.receiverUid!,
                                  displayName: dm.receiverDisplayName!,
                                  profile: dm.receiverDp!,
                                )
                                )
                            );
                          },
                          child: MessageOverviewTile(
                            displayName: dm.receiverDisplayName!,
                            lastMsg: dm.lastMessage!,
                            lastTime: dateTime,
                            messageType: dm.messageType!,
                            messageCount: dm.messageCount!,
                          ),
                        );
                      }
                      return const Center(child: Text('NO DMS YET'));
                    },
                        childCount: dms.length
                    ),
                  )
                ],
              );
            }
          ),
          Positioned(
            bottom: 20.h,
            right: 15.w,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) => const UsersList()
                    )
                );
              },
              child: Container(
                height: 55.h,
                width: 55.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color(0XFF0BC4D9),
                ),
                child: const Center(
                  child: Icon(Icons.message, color: Color(0XFFF4F4F4),),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

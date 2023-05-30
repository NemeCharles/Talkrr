import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../components/user_tile.dart';
import 'controller.dart';

class UsersList extends ConsumerWidget {
  const UsersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0XFFF4F4F4),
      appBar: AppBar(
        elevation: 1,
        backgroundColor: const Color(0XFF0BC4D9),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            borderRadius: BorderRadius.circular(50),
            child: SizedBox(
              height: 40.h,
              width: 40.w,
              child: const Center(child: Icon(Icons.arrow_back_outlined),),
            ),
          ),
        ),
        title: Text(
            'Users',
          style: TextStyle(
            fontSize: 30.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0XFFF4F4F4)
          ),
        ),
        actions: [
          const Icon(
            Icons.search_sharp,
            size: 25,
            color: Color(0XFFF4F4F4),
          ),
          SizedBox(width: 15.w,),
          const Icon(
            Icons.more_vert,
            size: 25,
            color: Color(0XFFF4F4F4),
          ),
          SizedBox(width: 10.w,)
        ],
      ),
      body: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: ref.watch(userListProvider).when(
          error: (error, stacktrace) => Center(child: Text(error.toString())),
          loading: () => const SizedBox(),
          data: (users) {
            return CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final user = users[index];
                      return UserTile(
                        displayName: user.displayName!,
                        profilePic: user.profilePhoto!,
                        userId: user.uid!
                      );
                  },
                      childCount: users.length
                  ),
                )
              ],
            );
          }
        ),
      ),
    );
  }
}

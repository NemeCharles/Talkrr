import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: const Color(0XFFF4F4F4),
        body: NestedScrollView(
          headerSliverBuilder: (context, isScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                floating: true,
                elevation: 0,
                toolbarHeight: 50.h,
                backgroundColor: const Color(0XFF0BC4D9),
                expandedHeight: 120.h,
                title: Text(
                  'Talkrr',
                  style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0XFFF4F4F4)
                  ),
                ),
                centerTitle: false,
                actions: [
                  const Icon(
                    Icons.camera_alt_outlined,
                    size: 25,
                    color: Color(0XFFF4F4F4),
                  ),
                  SizedBox(width: 15.w),
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
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(49.h),
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: false,
                    indicatorWeight: 3,
                    indicatorColor: const Color(0XFFF4F4F4),
                    labelColor:  const Color(0XFFF4F4F4),
                    unselectedLabelColor: const Color(0XFFF4F4F4),
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp
                    ),
                    tabs: const [
                      Tab(
                        text: 'Chats',
                      ),
                      Tab(
                        text: 'Stories',
                      ),
                      Tab(
                          text: 'Calls'
                      )
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: const [
              Center(child: Text('Chats'),),
              Center(child: Text('Stories'),),
              Center(child: Text('Calls'),)
            ],
          ),
        )
      );
  }
}


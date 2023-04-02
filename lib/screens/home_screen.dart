import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../components/call_tile.dart';
import '../components/massage_tile.dart';

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
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                width: double.maxFinite,
                height: 120.h,
                decoration: const BoxDecoration(
                  color: Color(0XFF0BC4D9),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                            'Talkrr',
                          style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0XFFF4F4F4)
                          ),
                        ),
                        SizedBox(
                          width: 90.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Icon(
                                  Icons.camera_alt_outlined,
                                size: 25,
                                color: Color(0XFFF4F4F4),
                              ),
                              Icon(
                                  Icons.search_sharp,
                                size: 25,
                                color: Color(0XFFF4F4F4),
                              ),
                              Icon(
                                  Icons.more_vert,
                                size: 25,
                                color: Color(0XFFF4F4F4),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h,),
                    SizedBox(
                      width: double.maxFinite,
                      child: TabBar(
                        controller: _tabController,
                        isScrollable: false,
                        indicatorColor:  const Color(0XFFF4F4F4),
                        indicatorWeight: 3.0,
                        labelColor:  const Color(0XFFF4F4F4),
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15
                        ),
                        unselectedLabelColor: const Color(0XFFF4F4F4),
                        tabs: const [
                          Tab(text: 'Chat',),
                          Tab(text: 'Stories',),
                          Tab(text: 'Calls',),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 694.4.h,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: const [
                          MessageTile(),
                        ],
                      ),
                    ),
                    const Center(child: Text('No Status'),),
                    ListView(
                      children: const [
                        CallTile()
                      ],
                    ),
                  ],
                )
              )
            ],
          ),
        ),
      );
  }
}


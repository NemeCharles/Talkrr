import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:text_app/screens/home_screen/controller.dart';
import 'package:text_app/screens/home_screen/home_screen_tabs/chat_tab.dart';
import 'package:text_app/storage_services/hive_services.dart';
import '../../models/message_overview.dart';
import '../../services/auth.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController;
  final _hive = HiveServices();
  final FireAuth _auth = FireAuth();
  List<MsgOverviewModel> dms = [];

  void availableUser() async {
    final user = _hive.getUser();
    if(user == null) {
      print('NO USER AVAILABLE');
    } else {print('USER AVAILABLE');}
  }



  @override
  void initState() {
    ref.read(homeController).listenForCalls(context);
    _tabController = TabController(length: 3, vsync: this);
    ref.read(homeController).chatCount();
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
                automaticallyImplyLeading: false,
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
                    tabs:  [
                      Container(
                        height: 46.h,
                        alignment: Alignment.center,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Chats', style: TextStyle(fontSize: 17),),
                            SizedBox(width: 3.w,),
                            Consumer(builder: (BuildContext context, WidgetRef ref, _) {
                              return ref.watch(chatCountState) == 0 ? SizedBox(width: 18.w,) :
                              Container(
                                height: 18.h,
                                width: 18.w,
                                alignment: Alignment.center,
                                decoration:  const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white
                                ),
                                child: Text('${ref.watch(chatCountState)}',
                                  style: const TextStyle(
                                      color: Color(0XFF0BC4D9),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 46.h,
                        child: const Text('Stories', style: TextStyle(fontSize: 17),)
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 46.h,
                        child: const Text('Calls', style: TextStyle(fontSize: 17),)
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              const ChatsTabView(),
              GestureDetector(
                onTap: () async {
                  await _auth.signOut();
                  availableUser();
                },
                  child: Center(child: Text('Stories'),)
              ),
              GestureDetector(
                onTap: () async {
                   print('USERS LOADED');
                },
                  child: Center(
                    child: Text('Calls'),
                  )
              )
            ],
          ),
        )
      );
  }
}


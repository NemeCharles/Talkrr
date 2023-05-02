import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:text_app/screens/media_screen/media_view.dart';


class MediaScreen extends StatefulWidget {
  const MediaScreen({Key? key}) : super(key: key);

  @override
  State<MediaScreen> createState() => _MediaScreenState();
}

class _MediaScreenState extends State<MediaScreen> {

  int currentPage = 0;
  int pageSize = 30;
  int totalAssets = 0;
  List<AssetEntity> assets = [];

  void requestAssets() async {
    final PermissionState permission = await PhotoManager.requestPermissionExtend();
    if(!permission.isAuth) {
      await PhotoManager.openSetting();
    }
    final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
      onlyAll: true,
      type: RequestType.common
    );
    final assetNum = await paths[0].assetCountAsync;
    if(paths.isNotEmpty) {
      List<AssetEntity> entities = await paths[0].getAssetListPaged(
          page: 0,
          size: pageSize
      );
      setState(() {
        currentPage++;
        assets.addAll(entities);
        totalAssets = assetNum;
      });
    }

  }

  void loadMoreAssets() async {
    final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
        onlyAll: true,
        type: RequestType.image
    );
      List<AssetEntity> entities = await paths[0].getAssetListPaged(
          page: currentPage,
          size: pageSize
      );
      setState(() {
        assets.addAll(entities);
        currentPage++;
      });
  }

  @override
  void initState() {
    requestAssets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF4F4F4),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
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
              child: Center(child: Icon(Icons.arrow_back_outlined, color: Colors.black87.withOpacity(0.57),),),
            ),
          ),
        ),
        title: Text(
          'Recents',
          style: TextStyle(
              fontSize: 25.sp,
              fontWeight: FontWeight.w400,
            color: Colors.black87.withOpacity(0.57)
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemCount: assets.length,
          itemBuilder: (_, index) {
            if(assets[index].type == AssetType.image) {
              if(index + 1 == assets.length - 6 && assets.length != totalAssets) {
                loadMoreAssets();
              }
              return FutureBuilder(
                future: assets[index].file,
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    return InkWell(
                      onTap: () async {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) =>  MediaViewScreen(image: snapshot.data!,))
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(snapshot.data!),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              );
            }
            return const SizedBox();
          },
        ),
      )
    );
  }
}
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_manager/photo_manager.dart';


class MediaScreen extends StatefulWidget {
  const MediaScreen({Key? key}) : super(key: key);

  @override
  State<MediaScreen> createState() => _MediaScreenState();
}

class _MediaScreenState extends State<MediaScreen> {

  int currentPage = 0;
  late Future<List<Uint8List?>> photos;

  void loadPhotos() {
    photos = requestAssets();
  }

  Future<List<Uint8List?>> requestAssets() async {
    List<Uint8List?> thumbs = [];
    final PermissionState permission = await PhotoManager.requestPermissionExtend();
    if(!permission.isAuth) {
      await PhotoManager.openSetting();
    }
    final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
      onlyAll: true,
      type: RequestType.image
    );
    if(paths.isNotEmpty) {
      List<AssetEntity> pathImages = await paths[0].getAssetListPaged(
          page: currentPage,
          size: 30
      );
      for(AssetEntity image in pathImages) {
        final thumb = await image.thumbnailDataWithSize(const ThumbnailSize(200, 200));
        thumbs.add(thumb);
      }
    }
    return thumbs;
  }

  @override
  void initState() {
    loadPhotos();
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
      body: FutureBuilder(
        future: photos,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) {
                  return InkWell(
                    child: Container(
                      margin: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: MemoryImage(snapshot.data![index]!),
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return const SizedBox();
        },
      )
    );
  }
}
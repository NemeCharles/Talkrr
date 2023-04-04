import 'package:hive_flutter/hive_flutter.dart';
part 'user_info.g.dart';

@HiveType(typeId: 0)
class LoggedInUserData extends HiveObject{

  LoggedInUserData({
    required this.userName,
    required this.email,
    required this.uid,
    required this.profilePhoto
});

  @HiveField(0)
  String userName;

  @HiveField(1)
  String email;

  @HiveField(3)
  String uid;

  @HiveField(4)
  String profilePhoto;
}
import 'package:hive_flutter/hive_flutter.dart';
import 'package:text_app/storage_services/user_info/user_info.dart';

const String _userDataStorageKey = 'USER_DATA_STORAGE_KEY';
const String _boxName = 'USER_DATA';

class HiveServices {

  final _box = Hive.box<LoggedInUserData>(_boxName);

  static Future<void> initialiseBoxes() async {
    try{
      await Hive.initFlutter();
      Hive.registerAdapter(LoggedInUserDataAdapter());
      await Hive.openBox<LoggedInUserData>(_boxName);
    } catch(e) {
      print(e);
    }

  }

  Future<void> addUser(LoggedInUserData value) async {
    await _box.put(_userDataStorageKey, value);
  }

  Future<LoggedInUserData?> getUser() async {
    final user = _box.get(_userDataStorageKey);
    return user;
  }

  Future<void> deleteUser() async {
    await _box.delete(_userDataStorageKey);
  }

  Future<void> closeBox() async {
    await _box.close();
  }

  bool userLoggedIn() {
    final user =  _box.get(_userDataStorageKey);
    if(user == null) {
      return false;
    } else {return true;}
  }

}
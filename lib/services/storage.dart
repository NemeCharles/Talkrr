import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class Storage {

  final store = FirebaseStorage.instance.ref();

  Future<String> storeImage({required File file, required String reference}) async {
    String url = '';
    try{
      final imageRef = store.child('senderID/userID/images/gil');
      final UploadTask task = imageRef.putFile(file);
      await task.whenComplete((){});
      String downloadUrl = await imageRef.getDownloadURL();
      url = downloadUrl;
    } on FirebaseException catch (e) {
      print(e.toString());
    } catch (e) {
      print(e);
    }
    return url;

  }

  Future<String> uploadImage(File file) async {
    String url = '';
    try {
      final imageRef = store.child('senderID/userID/images/gil');
      final UploadTask task = imageRef.putFile(file);
      await task.whenComplete((){});
      String downloadUrl = await imageRef.getDownloadURL();
      url = downloadUrl;
    } on FirebaseException catch (e) {
      print(e.toString());
    } catch (e) {
      print(e);
    }

    return url;
  }
}
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final storagePod = Provider<Storage>((ref) => Storage());

class Storage {

  final store = FirebaseStorage.instance.ref();

  Future<String> storeFileToFirebase({required File file, required String reference}) async {
    String url = '';
    try{
      final imageRef = store.child(reference);
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
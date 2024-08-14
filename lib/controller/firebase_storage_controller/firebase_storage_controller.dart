import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';

class FirebaseStorageController extends ChangeNotifier {
  Reference get storageRef => FirebaseStorage.instance.ref();

  Future<String?> uploadProfilePic(File? imageFile, String userId) async {
    if (imageFile == null) {
      return null;
    }

    final folderRef = storageRef.child('user_files');
    final imageRef = folderRef.child('$userId.jpg');
    await imageRef.putFile(imageFile);
    log(await imageRef.getDownloadURL());
    return imageRef.getDownloadURL();
  }
}

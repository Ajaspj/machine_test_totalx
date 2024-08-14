import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:machine_test_totalx/controller/firebase_storage_controller/firebase_storage_controller.dart';
import 'package:machine_test_totalx/controller/firestore_controller/firestore_controller.dart';
import 'package:machine_test_totalx/model/add_usermodel/add_usermodel.dart';
import 'package:provider/provider.dart';

class UserController extends ChangeNotifier {
  bool addingUser = false;

  File? imageFile;
  final UserModel _userModel = UserModel();
  final ImagePicker _picker = ImagePicker();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  UserModel get userModel => _userModel;

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<bool> save(BuildContext context) async {
    addingUser = true;
    notifyListeners();
    try {
      var id = await context.read<FirestoreController>().addUser(
            UserModel(
              name: nameController.text,
              age: ageController.text,
            ),
          );
      var imageUrl = await context
          .read<FirebaseStorageController>()
          .uploadProfilePic(imageFile, id);
      await context.read<FirestoreController>().updateUser(
            UserModel(
              name: nameController.text,
              age: ageController.text,
              image: imageUrl,
            ),
            id,
          );
      addingUser = false;
      notifyListeners();

      return true;
    } catch (e) {
      log(e.toString());
    }
    addingUser = false;
    notifyListeners();
    return false;
  }
}

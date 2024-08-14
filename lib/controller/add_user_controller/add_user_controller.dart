import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:machine_test_totalx/model/add_usermodel/add_usermodel.dart';

class UserController extends ChangeNotifier {
  final UserModel _userModel = UserModel();
  final ImagePicker _picker = ImagePicker();

  UserModel get userModel => _userModel;

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _userModel.image = File(pickedFile.path);
      notifyListeners();
    }
  }

  void setName(String name) {
    _userModel.name = name;
    notifyListeners();
  }

  void setAge(String age) {
    _userModel.age = age;
    notifyListeners();
  }

  void save() {
    try {
      _userModel.save();
      // Optionally, handle navigation or state change after saving.
    } catch (e) {
      // Handle exception for validation failure.
    }
  }
}

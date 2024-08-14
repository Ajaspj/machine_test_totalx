import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../model/add_usermodel/add_usermodel.dart';

class FirestoreController extends ChangeNotifier {
  static const String _userDataCollectionName = 'users';

  FirebaseFirestore get db => FirebaseFirestore.instance;

  List<UserModel> users = [];

  FirestoreController() {
    _initUserDataListener();
  }

  _initUserDataListener() {
    db.collection(_userDataCollectionName).snapshots().listen((event) {
      log(users.length.toString());
      users = event.docs.map((e) => UserModel.fromMap(e.data())).toList();
      log(users.length.toString());
      notifyListeners();
    });
  }

  Future<String> addUser(UserModel user) async {
    return (await db.collection(_userDataCollectionName).add(user.toMap())).id;
  }

  Future<void> updateUser(UserModel user, String id) async {
    await db.collection(_userDataCollectionName).doc(id).update(user.toMap());
    log('updateProduct completed');
  }
}

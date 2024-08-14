import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:machine_test_totalx/model/home_user_model/home_user_model.dart';

class HomescreenController extends ChangeNotifier {
  final HomeUserModel _userModel = HomeUserModel();
  List<DocumentSnapshot> _users = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _documentLimit = 10;
  DocumentSnapshot? _lastDocument;
  String searchText = "";

  List<DocumentSnapshot> get users => _users;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  String _sortOption = 'all';
  String get sortOption => _sortOption;

  void setSortOption(String option) {
    _sortOption = option;
    notifyListeners();

    if (option == 'age_elder') {
      _users.sort((a, b) {
        int ageA = a['age'] ?? 0;
        int ageB = b['age'] ?? 0;
        return ageB.compareTo(ageA);
      });
    } else if (option == 'age_younger') {
      _users.sort((a, b) {
        int ageA = a['age'] ?? 0;
        int ageB = b['age'] ?? 0;
        return ageA.compareTo(ageB);
      });
    } else {
      _users.sort((a, b) => 0);
    }

    notifyListeners();
  }

  Future<void> loadMoreUsers() async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    List<DocumentSnapshot> newUsers = await _userModel.fetchUsers(
      lastDocument: _lastDocument,
      limit: _documentLimit,
    );

    if (newUsers.isNotEmpty) {
      _lastDocument = newUsers.last;
      _users.addAll(newUsers);
      if (newUsers.length < _documentLimit) {
        _hasMore = false;
      }
    } else {
      _hasMore = false;
    }

    _isLoading = false;
    notifyListeners();
  }

  void setSearchText(String text) {
    searchText = text.toLowerCase();
    notifyListeners();
  }
}

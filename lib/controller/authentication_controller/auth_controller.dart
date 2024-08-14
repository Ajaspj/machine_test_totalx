import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:machine_test_totalx/model/user_model/user_model.dart';

class Authcontroller extends ChangeNotifier {
  User? _user;
  String? _verificationId;

  User? get user => _user;

  final firebase_auth.FirebaseAuth _firebaseAuth =
      firebase_auth.FirebaseAuth.instance;

  Future<void> sendOtp(String phoneNumber) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted:
          (firebase_auth.PhoneAuthCredential credential) async {
        try {
          await _firebaseAuth.signInWithCredential(credential);
          _user = User(
            id: _firebaseAuth.currentUser!.uid,
            phoneNumber: _firebaseAuth.currentUser!.phoneNumber!,
          );
          notifyListeners();
        } catch (e) {
          print('Sign-in failed: $e');
          // Handle sign-in failure
        }
      },
      verificationFailed: (firebase_auth.FirebaseAuthException e) {
        print('Verification failed: ${e.message}');
        // Handle verification failure
        _showError('Verification failed. Please try again.');
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
        notifyListeners();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  Future<void> verifyOtp(String otp) async {
    if (_verificationId == null) {
      print('Verification ID is not available.');
      _showError('Verification ID is not available. Please try again.');
      return;
    }

    try {
      final credential = firebase_auth.PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp,
      );
      await _firebaseAuth.signInWithCredential(credential);
      _user = User(
        id: _firebaseAuth.currentUser!.uid,
        phoneNumber: _firebaseAuth.currentUser!.phoneNumber!,
      );
      notifyListeners();
    } catch (e) {
      print('OTP verification failed: $e');
      _showError('OTP verification failed. Please try again.');
    }
  }

  void logout() async {
    try {
      await _firebaseAuth.signOut();
      _user = null;
      notifyListeners();
    } catch (e) {
      print('Logout failed: $e');
      // Handle logout failure
    }
  }

  void _showError(String message) {
    // Implement a method to show error messages, e.g., using a Snackbar or Dialog
    print(message); // Replace this with actual UI feedback
  }
}

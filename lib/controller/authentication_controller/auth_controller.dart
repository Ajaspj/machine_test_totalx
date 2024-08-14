import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:machine_test_totalx/model/loginuser_model/loginuser_model.dart';

class AuthController extends ChangeNotifier {
  LoginUser? _user;
  String? _verificationId;
  String _errorMessage = '';
  final TextEditingController otpController = TextEditingController();

  LoginUser? get user => _user;
  String get errorMessage => _errorMessage;

  final firebase_auth.FirebaseAuth _firebaseAuth =
      firebase_auth.FirebaseAuth.instance;

  Future<void> sendOtp(String phoneNumber) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted:
            (firebase_auth.PhoneAuthCredential credential) async {
          await _signInWithCredential(credential);
        },
        verificationFailed: (firebase_auth.FirebaseAuthException e) {
          _setError('Verification failed: ${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          _setError('OTP sent to $phoneNumber');
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    } catch (e) {
      _setError('Failed to send OTP. Please try again.');
    }
  }

  Future<void> verifyOtp() async {
    if (_verificationId == null) {
      _setError('Verification ID is not available. Please try again.');
      return;
    }

    try {
      final credential = firebase_auth.PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otpController.text,
      );
      await _signInWithCredential(credential);
    } catch (e) {
      _setError('OTP verification failed. Please try again.');
    }
  }

  Future<void> resendOtp(String phoneNumber) async {
    await sendOtp(phoneNumber);
  }

  Future<void> _signInWithCredential(
      firebase_auth.PhoneAuthCredential credential) async {
    try {
      await _firebaseAuth.signInWithCredential(credential);
      _user = LoginUser(
        id: _firebaseAuth.currentUser!.uid,
        phoneNumber: _firebaseAuth.currentUser!.phoneNumber!,
      );
      _errorMessage = '';
      notifyListeners();
    } catch (e) {
      _setError('Sign-in failed. Please try again.');
    }
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
      _user = null;
      notifyListeners();
    } catch (e) {
      _setError('Logout failed. Please try again.');
    }
  }

  void updateOtp(String value) {
    otpController.text = value;
    _errorMessage = '';
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }
}

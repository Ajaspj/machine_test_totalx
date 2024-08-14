import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OtpVerificationController extends ChangeNotifier {
  final TextEditingController otpController = TextEditingController();
  String _errorMessage = '';
  String? _verificationId;

  String get errorMessage => _errorMessage;

  // Method to set the verification ID
  void setVerificationId(String verificationId) {
    _verificationId = verificationId;
  }

  void updateOtp(String value) {
    otpController.text = value;
    notifyListeners(); // Notify listeners when OTP is updated
  }

  Future<void> verifyOtp() async {
    if (_verificationId == null) {
      _errorMessage = 'Verification ID not set.';
      notifyListeners();
      return;
    }

    try {
      // Create a credential with the provided OTP and verification ID
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otpController.text,
      );

      // Sign in with the credential
      await FirebaseAuth.instance.signInWithCredential(credential);

      _errorMessage = '';
      notifyListeners(); // Notify listeners if the OTP verification succeeds
    } catch (e) {
      _errorMessage = 'Verification failed. Please try again.';
      notifyListeners(); // Notify listeners if there is an error
    }
  }

  Future<void> resendOtp(String phoneNumber) async {
    try {
      final PhoneVerificationCompleted verificationCompleted =
          (PhoneAuthCredential credential) async {
        // Automatically sign in the user on successful verification
        await FirebaseAuth.instance.signInWithCredential(credential);
      };

      final PhoneVerificationFailed verificationFailed =
          (FirebaseAuthException e) {
        _errorMessage = 'Verification failed: ${e.message}';
        notifyListeners(); // Notify listeners if there is an error
      };

      final PhoneCodeSent codeSent = (String verificationId, int? resendToken) {
        // Store the verification ID to use later
        setVerificationId(verificationId);
        _errorMessage = 'OTP sent to $phoneNumber';
        notifyListeners(); // Notify listeners that OTP was sent
      };

      final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
          (String verificationId) {
        setVerificationId(verificationId);
      };

      // Request a new OTP
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );

      _errorMessage = '';
    } catch (e) {
      _errorMessage = 'Failed to resend OTP. Please try again.';
      notifyListeners(); // Notify listeners if there is an error
    }
  }
}

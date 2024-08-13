import 'package:flutter/material.dart';
import 'package:machine_test_totalx/view/authentication/auth_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class LoginViewModel extends BaseViewModel {
  final TextEditingController phoneNumberController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void sendOtp(BuildContext context) {
    if (formKey.currentState!.validate()) {
      final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      // Prepend '+91' to the phone number
      final phoneNumber = '+91${phoneNumberController.text}';
      authViewModel.sendOtp(phoneNumber);
      Navigator.of(context).pushNamed('/otp');
    }
  }
}

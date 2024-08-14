import 'package:flutter/material.dart';
import 'package:machine_test_totalx/controller/authentication_controller/auth_controller.dart';
import 'package:machine_test_totalx/view/otp_input_screen/otp_screen.dart';
import 'package:provider/provider.dart';

class LoginController extends ChangeNotifier {
  final TextEditingController phoneNumberController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void sendOtp(BuildContext context) {
    if (formKey.currentState!.validate()) {
      final authViewModel = Provider.of<Authcontroller>(context, listen: false);
      final phoneNumber = '+91${phoneNumberController.text}';
      authViewModel.sendOtp(phoneNumber);
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => OtpVerificationScreen(
          phoneNumber: phoneNumber,
          verificationId: "",
        ),
      ));
    }
  }

  // Additional methods or properties to manage the state can be added here.
}

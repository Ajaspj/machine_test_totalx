import 'package:flutter/material.dart';
import 'package:machine_test_totalx/controller/authentication_controller/auth_viewmodel.dart';
import 'package:machine_test_totalx/view/homescreen/homescreen.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class OtpViewModel extends BaseViewModel {
  final TextEditingController otpController = TextEditingController();

  Future<void> verifyOtp(BuildContext context) async {
    final authViewModel = Provider.of<Authcontroller>(context, listen: false);
    setBusy(true);
    try {
      await authViewModel.verifyOtp(otpController.text);
      if (authViewModel.user != null) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ));
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ));
      }
    } catch (error) {
      _showErrorDialog(context, 'An error occurred: $error');
    } finally {
      setBusy(false);
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

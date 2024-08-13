import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:machine_test_totalx/view/login_screen/login_viewmodel.dart';
import 'package:stacked/stacked.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: viewModel.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/image.png"),
                  SizedBox(height: 20),
                  SizedBox(height: 10),
                  Text(
                    'Enter your phone number',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: viewModel.phoneNumberController,
                    decoration: InputDecoration(
                      labelText: 'Enter your phone number',
                      hintText: '0000000000', // Only the 10-digit number
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      // Validate 10-digit number
                      if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                        return 'Please enter a valid 10-digit phone number';
                      }
                      return null;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => viewModel.sendOtp(context),
                    child: Text('Get OTP'),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      textStyle: TextStyle(fontSize: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

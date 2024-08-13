import 'package:flutter/material.dart';
import 'package:machine_test_totalx/view/otp_input_screen/otp_viewmodel.dart';
import 'package:stacked/stacked.dart';

class OtpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OtpViewModel>.reactive(
      viewModelBuilder: () => OtpViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Enter OTP'),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/image2.png"),
              SizedBox(height: 20),
              Text(
                'Verification',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Enter the OTP sent to your phone number',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              TextField(
                controller: viewModel.otpController,
                decoration: InputDecoration(
                  labelText: 'OTP',
                  hintText: '123456',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: Icon(Icons.lock),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              viewModel.isBusy
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () => viewModel.verifyOtp(context),
                      child: Text('Verify OTP'),
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        textStyle: TextStyle(fontSize: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:machine_test_totalx/controller/authentication_controller/auth_controller.dart';
import 'package:machine_test_totalx/controller/firebase_storage_controller/firebase_storage_controller.dart';
import 'package:machine_test_totalx/controller/firestore_controller/firestore_controller.dart';
import 'package:machine_test_totalx/controller/login_controller/login_controller.dart';
import 'package:machine_test_totalx/firebase_options.dart';
import 'package:machine_test_totalx/view/otp_input_screen/otp_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthController()),
        ChangeNotifierProvider(create: (context) => LoginController()),
        ChangeNotifierProvider(create: (context) => FirestoreController()),
        ChangeNotifierProvider(
            create: (context) => FirebaseStorageController()),
      ],
      child: Consumer<AuthController>(
        builder: (context, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            home: OtpVerificationScreen(
              phoneNumber: '',
              verificationId: '',
            )

            // auth.user == null ? LoginScreen() : Homescreen(),
            ),
      ),
    );
  }
}

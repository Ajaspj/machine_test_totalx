import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:machine_test_totalx/controller/authentication_controller/auth_controller.dart';
import 'package:machine_test_totalx/controller/firebase_storage_controller/firebase_storage_controller.dart';
import 'package:machine_test_totalx/controller/firestore_controller/firestore_controller.dart';
import 'package:machine_test_totalx/controller/login_controller/login_controller.dart';
import 'package:machine_test_totalx/controller/otp_controller/otp_controller.dart';
import 'package:machine_test_totalx/firebase_options.dart';
import 'package:machine_test_totalx/view/homescreen/homescreen.dart';
import 'package:machine_test_totalx/view/login_screen/login_screen.dart';
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
        ChangeNotifierProvider(create: (context) => Authcontroller()),
        ChangeNotifierProvider(create: (context) => LoginController()),
        ChangeNotifierProvider(create: (context) => FirestoreController()),
        ChangeNotifierProvider(
            create: (context) => FirebaseStorageController()),
        ChangeNotifierProvider(
            create: (context) => OtpVerificationController()),
      ],
      child: Consumer<Authcontroller>(
        builder: (context, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: auth.user == null ? LoginScreen() : Homescreen(),
        ),
      ),
    );
  }
}

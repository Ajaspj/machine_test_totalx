import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:machine_test_totalx/view/authentication/auth_viewmodel.dart';
import 'package:machine_test_totalx/view/login_screen/login_view.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AuthViewModel()),
        ],
        child: Consumer<AuthViewModel>(
          builder: (context, auth, _) => MaterialApp(
            home: LoginScreen(),
          ),
        ));
  }
}

import 'package:firebase_auth/firebase_auth.dart';

class AuthResponse {
  final String token;
  final User user;

  AuthResponse({required this.token, required this.user});
}

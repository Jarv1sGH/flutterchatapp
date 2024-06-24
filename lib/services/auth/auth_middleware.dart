import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterchatapp/components/login_register.dart';
import 'package:flutterchatapp/screens/home_screen.dart';

class AuthMiddleware extends StatelessWidget {
  const AuthMiddleware({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const HomeScreen();
        } else {
          return const LoginOrRegister();
        }
      },
    );
  }
}

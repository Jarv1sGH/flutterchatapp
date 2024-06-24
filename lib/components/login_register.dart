import 'package:flutter/material.dart';
import 'package:flutterchatapp/screens/login_screen.dart';
import 'package:flutterchatapp/screens/register_screen.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginScreen = true;

  void screenSwitcher() {
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginScreen) {
      return LoginScreen(
        onTextTap: screenSwitcher,
      );
    } else {
      return RegisterScreen(onTextTap: screenSwitcher);
    }
  }
}

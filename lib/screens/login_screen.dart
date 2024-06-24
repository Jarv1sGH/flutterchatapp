import 'package:flutter/material.dart';
import 'package:flutterchatapp/services/auth/auth_service.dart';
import 'package:flutterchatapp/components/custom_button.dart';
import 'package:flutterchatapp/components/custom_text_field.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.onTextTap});
  final void Function() onTextTap;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  _loginUser() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      try {
        await authService.login(emailController.text, passwordController.text);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/messageLogo.png'),
                    const Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 0),
                      child: Text(
                        'Welcome Back',
                        style: TextStyle(fontSize: 32),
                      ),
                    ),
                    const Text(
                      'Please Login to continue',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextField(
                      keyboardType: TextInputType.emailAddress,
                      textController: emailController,
                      hintText: 'Enter your email*',
                      hideText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter your email!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      keyboardType: TextInputType.text,
                      textController: passwordController,
                      hintText: 'Enter your password*',
                      hideText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter your password!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(onButtonTap: _loginUser, buttonText: 'Login'),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account?'),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: widget.onTextTap,
                          child: const Text(
                            'Register here',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.purple),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

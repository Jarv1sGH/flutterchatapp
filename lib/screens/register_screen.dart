import 'package:flutter/material.dart';
import 'package:flutterchatapp/services/auth/auth_service.dart';
import 'package:flutterchatapp/components/custom_button.dart';
import 'package:flutterchatapp/components/custom_text_field.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.onTextTap});
  final void Function() onTextTap;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    final phoneRegex = RegExp(r'^\+?1?\d{9,15}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void _register() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      try {
        await authService.register(
            emailController.text,
            passwordController.text,
            usernameController.text,
            phoneController.text);
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
                        'Create an Account',
                        style: TextStyle(fontSize: 32),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 5),
                      child: CustomTextField(
                        textController: usernameController,
                        keyboardType: TextInputType.name,
                        hintText: 'Username*',
                        hideText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Username is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: CustomTextField(
                        keyboardType: TextInputType.number,
                        textController: phoneController,
                        hintText: 'Enter your mobile no.*',
                        hideText: false,
                        validator: _validatePhone,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: CustomTextField(
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'Enter your email*',
                        textController: emailController,
                        hideText: false,
                        validator: _validateEmail,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: CustomTextField(
                        keyboardType: TextInputType.text,
                        textController: passwordController,
                        hintText: 'Enter password* (min 8 characters)',
                        hideText: true,
                        validator: _validatePassword,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 20),
                      child: CustomTextField(
                        keyboardType: TextInputType.text,
                        textController: confirmPasswordController,
                        hintText: 'Confirm password*',
                        hideText: true,
                        validator: _validateConfirmPassword,
                      ),
                    ),
                    CustomButton(
                        onButtonTap: _register, buttonText: 'Register'),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?'),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: widget.onTextTap,
                          child: const Text(
                            'Login here',
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

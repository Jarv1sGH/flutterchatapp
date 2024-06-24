import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.textController,
    required this.hintText,
    required this.hideText,
    required this.keyboardType,
    this.validator,
  });

  final TextEditingController textController;
  final String hintText;
  final bool hideText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: textController,
      obscureText: hideText,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: const Color.fromARGB(97, 219, 219, 247),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.purple[900] ?? Colors.purple),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.purple[900] ?? Colors.purple),
        ),
      ),
      validator: validator,
    );
  }
}

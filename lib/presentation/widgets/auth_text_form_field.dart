import 'package:flutter/material.dart';

class AuthTextFormField extends StatelessWidget {
  final Icon fieldIcon;
  final String hint;
  final TextInputType inputType;
  final InkWell? suffixIcon;
  final bool isPassword;
  final Function(String?) onValidate;
  final TextEditingController controller;

  const AuthTextFormField(
      {Key? key,
      required this.fieldIcon,
      required this.hint,
      required this.inputType,
      this.suffixIcon,
      required this.controller,
      this.isPassword = false,
      required this.onValidate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        icon: fieldIcon,
        hintText: hint,
        suffixIcon: suffixIcon,
      ),
      keyboardType: inputType,
      obscureText: isPassword,
      validator: (value) => onValidate(value),
      controller: controller,
    );
  }
}

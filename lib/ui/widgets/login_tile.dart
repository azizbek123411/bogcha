import 'package:flutter/material.dart';

class LoginTile extends StatelessWidget {
  TextEditingController controller;
  String hintText;
  Widget? suffixIcon;
  bool obSecure;

  LoginTile(
      {super.key,
      required this.controller,
      required this.hintText,
      this.suffixIcon,
      required this.obSecure});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(
        fontSize: 20,
      ),
      obscureText: obSecure,
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 25,
        ),
      ),
    );
  }
}

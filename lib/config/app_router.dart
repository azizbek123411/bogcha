import 'package:flutter/material.dart';

class AppRouter {
  static void go(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static void id(BuildContext context, String id) {
    Navigator.pushReplacementNamed(context, id);
  }

  static void back(BuildContext context) {
    Navigator.pop(context);
  }
}

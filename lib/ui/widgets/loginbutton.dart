import 'package:flutter/material.dart';

class LogInButton extends StatelessWidget {
  double h;
  double w;
  String text;
  Color color;
  Color textColor;
  void Function() onTap;

  LogInButton({
    super.key,
    required this.onTap,
    required this.color,
    required this.w,
    required this.text,
    required this.h,
    required this.textColor
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: h,
        width: w,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

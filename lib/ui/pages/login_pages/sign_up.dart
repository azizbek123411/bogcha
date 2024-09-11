import 'dart:convert';
import 'dart:developer';

import 'package:bogcha/config/screen_utils.dart';
import 'package:flutter/material.dart';

import '../../../config/app_padding.dart';
import '../../../config/space.dart';
import '../../widgets/login_tile.dart';
import '../../widgets/loginbutton.dart';
import 'package:http/http.dart' as http;

import '../dashbord_pages/home_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController centerController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  bool isVisiblePass = true;
  bool isVisibleConPass = true;

  Future<void> signUp() async {
    final center = centerController.text;
    final username = usernameController.text;
    final password = passwordController.text;
    final confirm = confirmController.text;
    final phone = phoneController.text;
    final body = {
      'company': center,
      'username': username,
      'phone': phone,
      'password': password,
      'password_2': confirm,
    };
    const url = 'https://bw.net.uz/app/register/';
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );
    if (jsonDecode(response.body)['success'].toString()=='true') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePages(),
        ),
      );
      log(jsonDecode(response.body)['success'].toString());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            'Signed Up',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
    } else if(jsonDecode(response.body)['success'].toString()=='false') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "username band yoki parollar bir hil emas",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Error occured",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: Dis.only(lr: 25.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LoginTile(
              controller: centerController,
              hintText: 'Markaz Name',
              obSecure: false,
            ),
            HBox(10.h),
            LoginTile(
              obSecure: false,
              controller: usernameController,
              hintText: 'Username',
            ),
            HBox(10.h),
            LoginTile(
              controller: phoneController,
              hintText: 'Phone',
              obSecure: false,
            ),
            HBox(10.h),
            LoginTile(
              controller: passwordController,
              hintText: 'Password',
              obSecure: isVisiblePass,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isVisiblePass = !isVisiblePass;
                  });
                },
                icon: isVisiblePass
                    ? const Icon(
                        Icons.visibility,
                      )
                    : const Icon(
                        Icons.visibility_off,
                      ),
              ),
            ),
            HBox(10.h),
            LoginTile(
              controller: confirmController,
              hintText: 'Confirm password',
              obSecure: isVisibleConPass,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isVisibleConPass = !isVisibleConPass;
                  });
                },
                icon: isVisibleConPass
                    ? const Icon(
                        Icons.visibility,
                      )
                    : const Icon(
                        Icons.visibility_off,
                      ),
              ),
            ),
            HBox(10.h),
            LogInButton(
              onTap: () {
                signUp();
              },
              color: Colors.green,
              w: double.infinity,
              text: "Sign Up",
              h: 50.h,
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'dart:developer';

import 'package:bogcha/config/app_padding.dart';
import 'package:bogcha/config/screen_utils.dart';
import 'package:bogcha/config/space.dart';
import 'package:bogcha/ui/pages/dashbord_pages/home_page.dart';
import 'package:bogcha/ui/widgets/login_tile.dart';
import 'package:bogcha/ui/widgets/loginbutton.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isVisible = true;
  bool loggedIn = true;

  Future<void> signIn() async {
    final username = loginController.text;
    final password = passwordController.text;
    final body = {
      'username': username,
      'password': password,
    };
    const url = 'https://bw.net.uz/app/login/';
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
          builder: (context) => HomePages(),
        ),
      );
      log(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            'Signed In',
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
            'Error Occurred',
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
              controller: loginController,
              hintText: 'Login',
              obSecure: false,
            ),
            HBox(10.h),
            LoginTile(
              obSecure: isVisible,
              controller: passwordController,
              hintText: 'Password',
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
                icon: isVisible
                    ? const Icon(
                        Icons.visibility,
                      )
                    : const Icon(
                        Icons.visibility_off,
                      ),
              ),
            ),
            HBox(10.h),
            Row(
              children: [
                SizedBox(
                  height: 30.h,
                  width: 40.w,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Switch(
                        activeColor: Colors.green,
                        value: loggedIn,
                        onChanged: (logg) {
                          setState(() {
                            loggedIn = logg;
                          });
                        }),
                  ),
                ),
                Text('Keep me logged in')
              ],
            ),
            HBox(10.h),
            LogInButton(
              onTap: () {
                signIn();

              },
              color: Colors.green,
              w: double.infinity,
              text: "Login",
              h: 50.h,
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}

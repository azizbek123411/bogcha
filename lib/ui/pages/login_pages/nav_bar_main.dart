import 'package:bogcha/config/app_padding.dart';
import 'package:bogcha/config/screen_utils.dart';
import 'package:bogcha/ui/pages/login_pages/sign_up.dart';
import 'package:bogcha/ui/pages/login_pages/sing_in.dart';
import 'package:bogcha/ui/widgets/loginbutton.dart';
import 'package:flutter/material.dart';

class MainNavBar extends StatefulWidget {
  const MainNavBar({super.key});

  @override
  State<MainNavBar> createState() => _MainNavBarState();
}

class _MainNavBarState extends State<MainNavBar> {
  List pages = [
    const SignUp(),
    const SignIn(),
  ];
  int initialIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          pages[initialIndex],
        ],
      ),
      bottomNavigationBar: Container(
        padding: Dis.only(bottom: 15.h,lr: 25.w,),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            LogInButton(
              onTap: () {
                setState(() {
                  initialIndex=0;
                });
              },
              color:initialIndex==0?Colors.green:Colors.white,
              w: 150.w,
              text: 'Sing Up',
              h: 50.h,
              textColor: initialIndex==0?Colors.white:Colors.black,
            ),
            LogInButton(
              onTap: () {
                setState(() {
                  initialIndex=1;
                });
              },
              color: initialIndex==1?Colors.green:Colors.white,
              w: 150.w,
              text: 'Sign In',
              h: 50.h,
              textColor: initialIndex==1?Colors.white:Colors.black,
            ),
          ],
        ),
      ),

    );
  }
}

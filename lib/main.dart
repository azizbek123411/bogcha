import 'package:bogcha/ui/pages/dashbord_pages/home_page.dart';
import 'package:bogcha/ui/pages/login_pages/nav_bar_main.dart';
import 'package:bogcha/ui/pages/login_pages/sign_up.dart';
import 'package:bogcha/ui/pages/login_pages/sing_in.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  var box=await Hive.openBox('token');
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
var boxToken=Hive.box('token');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green,
        ),
        useMaterial3: true,
      ),
      home:  boxToken.isEmpty?const MainNavBar ():const HomePages(),
      routes: {
        HomePages.id:(context)=>const HomePages(),
        SignIn.id:(context)=>const SignIn(),
        SignUp.id:(context)=>const SignUp(),
      },
    );
  }
}



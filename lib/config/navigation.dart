
import 'package:flutter/cupertino.dart';
import 'package:heroes/view/screens/home_screen.dart';

class Navigation {
  static Map<String, Widget Function(BuildContext)> routes =   {
    '/' : (context) => HomeScreen(),
    // '/sign-in' : (context) => Login(),
    // '/home'  : (context) => HomePage()
  };
}
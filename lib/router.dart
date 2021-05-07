import 'package:flutter/material.dart';
import 'package:greenland_stock/screens/app/AuthPage.dart';
import 'package:greenland_stock/screens/app/LoginPage.dart';
import 'package:greenland_stock/screens/app/MobileSigninPage.dart';
import 'package:greenland_stock/screens/app/onboardscreen.dart';
import 'package:greenland_stock/screens/home/HomeScreen.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/auth':
        var data = settings.arguments as List<String>;
        return MaterialPageRoute(builder: (_) => AuthPage(data[0], data[1], data[2]));
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/register':
        return MaterialPageRoute(builder: (_) => MobileSignInPage());
      // case '/otp':
      // List<dynamic> args = settings.arguments;
      //   return MaterialPageRoute(builder: (_) => PhoneAuthVerify());
      case '/onboard':
        return MaterialPageRoute(builder: (_) => OnboardScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeScreen(0));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
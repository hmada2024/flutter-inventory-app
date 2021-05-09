import 'package:flutter/material.dart';
import 'package:greenland_stock/constants.dart';
import 'package:greenland_stock/db/products.dart';
import 'package:greenland_stock/screens/app/AuthPage.dart';
import 'package:greenland_stock/screens/app/LoginPage.dart';
import 'package:greenland_stock/screens/app/MobileSigninPage.dart';
import 'package:greenland_stock/screens/app/onboardscreen.dart';
import 'package:greenland_stock/screens/home/add_product.dart';
import 'package:greenland_stock/screens/home/edit_products.dart';
import 'package:greenland_stock/screens/home/home_screen.dart';
import 'package:greenland_stock/screens/settings/add_business.dart';
import 'package:greenland_stock/screens/settings/business_settings.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case authRoute:
        var data = settings.arguments as List<String>;
        return MaterialPageRoute(
            builder: (_) => AuthPage(data[0], data[1], data[2]));
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case registerRoute:
        return MaterialPageRoute(builder: (_) => MobileSignInPage());
      // case '/otp':
      // List<dynamic> args = settings.arguments;
      //   return MaterialPageRoute(builder: (_) => PhoneAuthVerify());
      case onboardRoute:
        return MaterialPageRoute(builder: (_) => OnboardScreen());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => HomeScreen(0));
      case addProductRoute:
        return MaterialPageRoute(builder: (_) => AddProduct());
      case editProductRoute:
        Products data = settings.arguments as Products;
        return MaterialPageRoute(builder: (_) => EditProduct(data));
      case businessSettingsRoute:
        return MaterialPageRoute(builder: (_) => BusinessSettings());
      case businessAddRoute:
        return MaterialPageRoute(builder: (_) => AddBusiness());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}

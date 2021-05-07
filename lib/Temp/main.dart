import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenland_stock/register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'forgetpass.dart';
import 'home.dart';
import 'login_screen.dart';
import 'onboardscreen.dart';
import 'otp.dart';

Future<void> main() async {
  var initialRoute = "/onboard-screen";
  WidgetsFlutterBinding.ensureInitialized();
  var prefs = await SharedPreferences.getInstance();
  try {
    var isOpened =
        prefs.get("opened") != null ? prefs.get("opened") ?? false : false;
    print(isOpened);
    if ((isOpened)) {
      initialRoute = '/home_screen';
    } else {
      initialRoute = "/onboard-screen";
    }

    /* --------------- Firebase token for push notifications --------------- */

  } catch (e) {
    initialRoute = '/onboard-screen';
  }
  runApp(MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      home: SplashScreen(
        seconds: 3,
        navigateAfterSeconds: MyApp(
          initialRoute: initialRoute,
        ),
        loaderColor: Colors.white,
        title: new Text(
          "GreenLand stock",
          textAlign: TextAlign.center,
          style: new TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
      )));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  MyApp({this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GreenLand Stock',
      initialRoute: initialRoute,
      routes: {
        '/login-screen': (context) => Login(),
        '/register-screen': (context) => Register(),
        '/onboard-screen': (context) => OnboardScreen(),
        '/home_screen': (context) => Home(),
        '/forget-pass': (context) => ForgetPass(),
        '/otp': (context) => PinCodeVerificationScreen(),
      },
    );
  }
}

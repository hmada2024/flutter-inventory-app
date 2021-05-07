import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greenland_stock/constants.dart';
import 'package:greenland_stock/router.dart' as r;
import 'package:greenland_stock/screens/app/AuthPage.dart';
import 'package:greenland_stock/screens/app/LoginPage.dart';
import 'package:greenland_stock/screens/app/onboardscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

Future<void> main() async {
  var initialRoute = "/onboard-screen";
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var isOpened =
      prefs.get("opened") != null ? prefs.get("opened") ?? false : false;

  String userID = prefs.getString('mobile_number') ?? "";
  String userName = prefs.getString('user_name') ?? "";
  String userImage = prefs.getString('user_profile_pic') ?? "";

  if (isOpened && userID.isNotEmpty) {
    initialRoute = '/home_screen';
  } else {
    initialRoute = "/onboard-screen";
  }

  runApp(MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      home: SplashScreen(
        seconds: 3,
        navigateAfterSeconds: MyApp(isOpened, userID, userName, userImage),
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
  MyApp(this.isOpened, this.userID, this.userName, this.userImage);

  final String userID;
  final String userName;
  final String userImage;
  final bool isOpened;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: app_name,
      theme: ThemeData(
          brightness: Brightness.light,
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          )),
      home: !isOpened
          ? OnboardScreen()
          : (userID.isNotEmpty)
              ? AuthPage(userID, userName, userImage)
              : LoginPage(),
      // initialRoute: initialRoute,
      onGenerateRoute: r.Router.generateRoute,
    );
  }
}

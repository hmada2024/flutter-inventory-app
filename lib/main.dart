import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greenland_stock/constants.dart';
import 'package:greenland_stock/router.dart' as r;
import 'package:greenland_stock/screens/app/AuthPage.dart';
import 'package:greenland_stock/screens/app/LoginPage.dart';
import 'package:greenland_stock/screens/app/onboardscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var isOpened =
      prefs.get("opened") != null ? prefs.get("opened") ?? false : false;

  String userID = prefs.getString('mobile_number') ?? "";
  String userName = prefs.getString('user_name') ?? "";
  String userImage = prefs.getString('user_profile_pic') ?? "";

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: SplashScreen(
        seconds: 3,
        navigateAfterSeconds: MyApp(isOpened, userID, userName, userImage),
        loaderColor: Colors.white,
        image: new Image.asset(
          "images/GreenlandLogo.png",
          height: 600.0,
          width: 600.0,
        ),
        photoSize: 100.0,
        backgroundColor: Colors.green,
      )));
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..customAnimation = CustomAnimation();
}

class CustomAnimation extends EasyLoadingAnimation {
  CustomAnimation();

  @override
  Widget buildWidget(
    Widget child,
    AnimationController controller,
    AlignmentGeometry alignment,
  ) {
    return Opacity(
      opacity: controller.value,
      child: RotationTransition(
        turns: controller,
        child: child,
      ),
    );
  }
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
          primarySwatch: Colors.green,
          brightness: Brightness.light,
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          )),
      home: !isOpened
          ? OnboardScreen()
          : (userID.isNotEmpty)
              ? AuthPage(userID, userName, userImage)
              : LoginPage(),
      onGenerateRoute: r.Router.generateRoute,
      builder: EasyLoading.init(),
    );
  }
}

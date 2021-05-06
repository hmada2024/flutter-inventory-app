import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greenland_stock/constants.dart';
import 'package:greenland_stock/screens/app/AuthPage.dart';
import 'package:greenland_stock/screens/app/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userID = prefs.getString('mobile_number') ?? "";
  String userName = prefs.getString('user_name') ?? "";
  String userImage = prefs.getString('user_profile_pic') ?? "";

  runApp(MyApp(userID, userName, userImage));
}

class MyApp extends StatefulWidget {
  MyApp(this.userID, this.userName, this.userImage);

  final String userID;
  final String userName;
  final String userImage;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

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
      home: (widget.userID.isNotEmpty)
          ? AuthPage(widget.userID, widget.userName, widget.userImage)
          : LoginPage(),
    );
  }
}

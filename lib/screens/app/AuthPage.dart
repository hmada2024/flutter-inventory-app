import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:greenland_stock/db/user.dart';
import 'package:greenland_stock/screens/app/ContactAndSupportWidget.dart';
import 'package:greenland_stock/screens/app/LoginPage.dart';
import 'package:greenland_stock/screens/app/MobileSigninPage.dart';
import 'package:greenland_stock/screens/home/HomeScreen.dart';
import 'package:greenland_stock/screens/utils/CustomColors.dart';
import 'package:greenland_stock/screens/utils/CustomDialogs.dart';
import 'package:greenland_stock/screens/utils/CustomSnackBar.dart';
import 'package:greenland_stock/screens/utils/hash_generator.dart';
import 'package:greenland_stock/screens/utils/url_launcher_utils.dart';
import 'package:greenland_stock/services/auth_service.dart';
import 'package:local_auth/local_auth.dart';

class AuthPage extends StatefulWidget {
  AuthPage(this.userID, this.userName, this.userImage);

  final String userImage;
  final String userName;
  final String userID;

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  TextEditingController _pController = TextEditingController();
  final AuthService _authController = AuthService();

  bool _passwordVisible = true;

  @override
  void initState() {
    super.initState();

    // biometric();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: CustomColors.lightGrey,
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "From ",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: CustomColors.black,
            ),
          ),
          InkWell(
            onTap: () {
              UrlLauncherUtils.launchURL('https://www.fourcup.com');
            },
            child: Text(
              " Fourcup Inc.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: CustomColors.blue,
              ),
            ),
          ),
        ],
      ),
      extendBody: true,
      body: SingleChildScrollView(
        primary: true,
        child: Container(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [CustomColors.green, CustomColors.lightGrey],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                child: Image.asset(
                  "images/logo.png",
                  height: 80,
                ),
              ),
              Column(
                children: [
                  Text(
                    "FC Mart",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "OLED",
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Shop Everything Online",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "WELCOME BACK !!",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
              Container(
                child: Flexible(
                  child: widget.userImage == ""
                      ? Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: CustomColors.alertRed,
                                style: BorderStyle.solid,
                                width: 2.0),
                          ),
                          child: Icon(
                            Icons.person,
                            size: 45.0,
                            color: CustomColors.lightGrey,
                          ),
                        )
                      : SizedBox(
                          width: 90.0,
                          height: 90.0,
                          child: Center(
                            child: CachedNetworkImage(
                              imageUrl: widget.userImage,
                              imageBuilder: (context, imageProvider) =>
                                  CircleAvatar(
                                radius: 45.0,
                                backgroundImage: imageProvider,
                                backgroundColor: Colors.transparent,
                              ),
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      CircularProgressIndicator(
                                          value: downloadProgress.progress),
                              errorWidget: (context, url, error) => Icon(
                                Icons.error,
                                size: 35,
                              ),
                              fadeOutDuration: Duration(seconds: 1),
                              fadeInDuration: Duration(seconds: 2),
                            ),
                          ),
                        ),
                ),
              ),
              Text(
                widget.userName,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: CustomColors.blue,
                ),
              ),
              Text(
                widget.userID,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: CustomColors.blue,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: CustomColors.grey,
                          blurRadius: 10.0,
                          spreadRadius: 0.5,
                        )
                      ]),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    obscureText: _passwordVisible,
                    autofocus: false,
                    controller: _pController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      prefixIcon: Icon(
                        FontAwesomeIcons.key,
                        color: CustomColors.grey,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: CustomColors.grey,
                          size: 30.0,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      hintText: "Password",
                      fillColor: CustomColors.lightGrey,
                      filled: true,
                      contentPadding: EdgeInsets.all(14),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      await biometric();
                    },
                    child: Text(
                      "Use Fingerprint",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: CustomColors.black,
                        fontSize: 11.0,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => LoginPage(),
                        ),
                      );
                    },
                    child: Text(
                      "Not YOU, Forgot Password?",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: CustomColors.black,
                        fontSize: 11.0,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 40,
                    width: 150,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: CustomColors.alertRed,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(5),
                          ),
                        ),
                      ),
                      onPressed: () {
                        _submit(widget.userID);
                      },
                      child: Center(
                        child: Text(
                          "LOGIN",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: CustomColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              TextButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    routeSettings: RouteSettings(name: "/home/help"),
                    builder: (context) {
                      return Center(
                        child: contactAndSupportDialog(context),
                      );
                    },
                  );
                },
                icon: Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: CustomColors.black),
                  ),
                  child: Icon(
                    Icons.headset_mic,
                    size: 13,
                    color: CustomColors.blue,
                  ),
                ),
                label: Text(
                  "Help & Support",
                  style: TextStyle(
                    color: CustomColors.blue,
                    fontSize: 14.0,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Text(
                        "New To FC Mart?",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: CustomColors.black,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                MobileSignInPage(),
                            settings: RouteSettings(name: '/signup'),
                          ),
                        );
                      },
                      child: Text(
                        "SIGN UP",
                        style: TextStyle(
                          fontSize: 22.0,
                          color: CustomColors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  biometric() async {
    final LocalAuthentication auth = LocalAuthentication();
    try {
      bool canCheckBiometrics = await auth.canCheckBiometrics;
      if (canCheckBiometrics) {
        List<BiometricType> availableBiometrics;
        availableBiometrics = await auth.getAvailableBiometrics();

        if (availableBiometrics.isNotEmpty) {
          bool authenticated = await auth.authenticate(
              biometricOnly: true,
              localizedReason: 'Touch your finger on the sensor to login',
              useErrorDialogs: true,
              sensitiveTransaction: true,
              stickyAuth: true);
          if (authenticated) {
            await login(widget.userID);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackBar.errorSnackBar("Not Authenticated!", 2),
            );
            return;
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackBar.errorSnackBar(
                "Unable to use FingerPrint Login. Please LOGIN using Password!",
                2),
          );
          return;
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar.errorSnackBar(
            "Unable to use FingerPrint Login. Please LOGIN using Password!", 2),
      );
    }
  }

  login(String _userID) async {
    CustomDialogs.showLoadingDialog(context, _keyLoader);

    var result = await _authController.signInWithMobileNumber(_userID);

    if (!result['is_success']) {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar.errorSnackBar(
          "Unable to Login, Something went wrong. Please try again Later!", 2));
      ScaffoldMessenger.of(context)
          .showSnackBar(CustomSnackBar.errorSnackBar(result['message'], 2));
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (BuildContext context) => HomeScreen(0),
        ),
        (Route<dynamic> route) => false,
      );
    }
  }

  void _submit(String _userID) async {
    if (_pController.text.length == 0) {
      ScaffoldMessenger.of(context)
          .showSnackBar(CustomSnackBar.errorSnackBar("Enter Your Password", 2));
      return;
    } else {
      try {
        Map<String, dynamic> _userData = await User().getByID(_userID);
        User _user = User.fromJson(_userData);

        String hashKey =
            HashGenerator.hmacGenerator(_pController.text, _user.getID());
        if (hashKey != _user.password) {
          ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackBar.errorSnackBar(
                  "Invalid Password. Please try again !!", 2));
          return;
        } else {
          await login(_userID);
        }
      } catch (err) {
        print(err);

        ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackBar.errorSnackBar("Sorry, Unable to Login now!", 2));
      }
    }
  }
}

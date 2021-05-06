import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenland_stock/constants.dart';
import 'package:greenland_stock/db/user.dart' as user;
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:greenland_stock/screens/app/ContactAndSupportWidget.dart';
import 'package:greenland_stock/screens/app/PhoneAuthVerify.dart';
import 'package:greenland_stock/screens/home/HomeScreen.dart';
import 'package:greenland_stock/screens/utils/CustomColors.dart';
import 'package:greenland_stock/screens/utils/CustomDialogs.dart';
import 'package:greenland_stock/screens/utils/CustomSnackBar.dart';
import 'package:greenland_stock/screens/utils/url_launcher_utils.dart';
import 'package:greenland_stock/services/auth_service.dart';
import 'package:greenland_stock/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MobileSignInPage extends StatefulWidget {
  @override
  _MobileSignInPageState createState() => _MobileSignInPageState();
}

class _MobileSignInPageState extends State<MobileSignInPage> {
  String number, _smsVerificationCode;
  int countryCode = 91;
  bool _passwordVisible = true;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _passKeyController = TextEditingController();
  final AuthService _authController = AuthService();

  int _forceResendingToken;

  @override
  void initState() {
    super.initState();
    _lastNameController.text = "";
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
        child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [CustomColors.green, CustomColors.lightGrey],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            height: MediaQuery.of(context).size.height,
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10),
            child: SingleChildScrollView(child: _getColumnBody())),
      ),
    );
  }

  Widget _getColumnBody() => Column(
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
          SizedBox(height: 10),
          Text(
            "REGISTER HERE !!",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    bottom: 5.0, top: 10, left: 20.0, right: 20.0),
                child: TextField(
                  controller: _phoneNumberController,
                  textAlign: TextAlign.left,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                  ],
                  decoration: InputDecoration(
                    prefix: Text('+91'),
                    prefixIcon: Icon(
                      Icons.phone,
                      color: CustomColors.grey,
                      size: 25.0,
                    ),
                    prefixIconConstraints: BoxConstraints(
                      minWidth: 60,
                    ),
                    fillColor: CustomColors.white,
                    hintText: "Mobile Number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    contentPadding: EdgeInsets.all(14),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Container(
                    child: Flexible(
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 20, right: 5.0, bottom: 5),
                        child: TextField(
                          controller: _nameController,
                          textAlign: TextAlign.left,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            fillColor: CustomColors.white,
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: CustomColors.grey,
                              size: 25.0,
                            ),
                            hintText: "First Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            filled: true,
                            contentPadding: EdgeInsets.all(14),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Flexible(
                      child: Padding(
                        padding:
                            EdgeInsets.only(right: 20, left: 5.0, bottom: 5),
                        child: TextField(
                          controller: _lastNameController,
                          textAlign: TextAlign.left,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            fillColor: CustomColors.white,
                            hintText: "Last Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            filled: true,
                            contentPadding: EdgeInsets.all(14),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Container(
                child: Padding(
                  padding:
                      EdgeInsets.only(bottom: 5.0, left: 20.0, right: 20.0),
                  child: TextField(
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.text,
                    controller: _passKeyController,
                    obscureText: _passwordVisible,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        FontAwesomeIcons.key,
                        size: 20.0,
                        color: CustomColors.grey,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: CustomColors.grey,
                          size: 25.0,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      prefixIconConstraints: BoxConstraints(
                        minWidth: 60,
                      ),
                      fillColor: CustomColors.white,
                      hintText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      contentPadding: EdgeInsets.all(14),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.info_outline,
                  color: CustomColors.alertRed, size: 20.0),
              SizedBox(width: 10.0),
              Flexible(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: "We will send",
                          style: TextStyle(
                              color: CustomColors.blue,
                              fontWeight: FontWeight.w400)),
                      TextSpan(
                          text: " OTP",
                          style: TextStyle(
                              color: CustomColors.alertRed,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700)),
                      TextSpan(
                          text: " to this Mobile Number",
                          style: TextStyle(
                              color: CustomColors.blue,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: () {
              UrlLauncherUtils.launchURL(terms_and_conditions_url);
            },
            child: Text(
              "On Registering, You accept our Terms of Services",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 40,
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 10.0,
                    primary: CustomColors.alertRed,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(5),
                      ),
                    ),
                  ),
                  onPressed: startPhoneAuth,
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      "Register",
                      style: TextStyle(
                        color: CustomColors.white,
                        fontSize: 18.0,
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
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 5.0),
                  child: Text(
                    "Already have an account?",
                    style: TextStyle(
                      fontSize: 14,
                      color: CustomColors.black,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Text(
                    "LOGIN",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 22,
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
      );

  startPhoneAuth() async {
    if (_phoneNumberController.text.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar.errorSnackBar("Oops! Number seems invalid", 2));
      return;
    } else if (_nameController.text.length <= 2) {
      ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar.errorSnackBar("Please Enter Your Name", 2));
      return;
    } else if (_passKeyController.text.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar.errorSnackBar(
          "Password must have minimum 4 digits", 2));
      return;
    } else {
      CustomDialogs.actionWaiting(context);
      this.number = _phoneNumberController.text;

      var data = await user.User().getByID(countryCode.toString() + number);
      if (data != null) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar.errorSnackBar(
            "Found an existing user for this mobile number", 2));
      } else {
        await _verifyPhoneNumber();
      }
    }
  }

  _verifyPhoneNumber() async {
    String phoneNumber = "+" + countryCode.toString() + number;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 0),
        verificationCompleted: (authCredential) =>
            _verificationComplete(authCredential, context),
        verificationFailed: (authException) =>
            _verificationFailed(authException, context),
        codeAutoRetrievalTimeout: (verificationId) =>
            _codeAutoRetrievalTimeout(verificationId),
        codeSent: (verificationId, [code]) =>
            _smsCodeSent(verificationId, [code]));
  }

  _verificationComplete(
      AuthCredential authCredential, BuildContext context) async {
    FirebaseAuth.instance
        .signInWithCredential(authCredential)
        .then((UserCredential authResult) async {
      dynamic result = await _authController.registerWithMobileNumber(
          int.parse(number),
          countryCode,
          _passKeyController.text,
          _nameController.text,
          _lastNameController.text,
          authResult.user.uid);
      if (!result['is_success']) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context)
            .showSnackBar(CustomSnackBar.errorSnackBar(result['message'], 5));
      } else {
        final SharedPreferences prefs = await _prefs;
        prefs.setString(
            "user_profile_pic", cachedLocalUser.getProfilePicPath());
        prefs.setString("user_name",
            cachedLocalUser.firstName + " " + cachedLocalUser.lastName ?? "");
        prefs.setString("mobile_number", cachedLocalUser.getID());

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen(0)
          ),
          (Route<dynamic> route) => false,
        );
      }
    }).catchError((error) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar.errorSnackBar(
          "Something has gone wrong, please try later", 2));
      ScaffoldMessenger.of(context)
          .showSnackBar(CustomSnackBar.errorSnackBar("${error.toString()}", 2));
    });
  }

  _smsCodeSent(String verificationId, [code]) {
    ScaffoldMessenger.of(context)
        .showSnackBar(CustomSnackBar.successSnackBar("OTP sent", 1));

    _smsVerificationCode = verificationId;
    _forceResendingToken = code;
    Navigator.pop(context);
    CustomDialogs.actionWaiting(context);
  }

  _verificationFailed(dynamic authException, BuildContext context) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar.errorSnackBar(
        "Verification Failed:" + authException.message.toString(), 2));
  }

  _codeAutoRetrievalTimeout(String verificationId) {
    _smsVerificationCode = verificationId;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => PhoneAuthVerify(
            true,
            number,
            countryCode,
            _passKeyController.text,
            _nameController.text,
            _lastNameController.text,
            _smsVerificationCode,
            _forceResendingToken),
      ),
    );
  }
}

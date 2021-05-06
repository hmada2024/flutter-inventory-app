import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:greenland_stock/constants.dart';
import 'package:greenland_stock/db/user.dart' as user;
import 'package:greenland_stock/screens/app/ContactAndSupportWidget.dart';
import 'package:greenland_stock/screens/app/MobileSigninPage.dart';
import 'package:greenland_stock/screens/app/PhoneAuthVerify.dart';
import 'package:greenland_stock/screens/home/HomeScreen.dart';
import 'package:greenland_stock/screens/utils/CustomColors.dart';
import 'package:greenland_stock/screens/utils/CustomDialogs.dart';
import 'package:greenland_stock/screens/utils/CustomSnackBar.dart';
import 'package:greenland_stock/screens/utils/url_launcher_utils.dart';
import 'package:greenland_stock/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ENTER MOBILE NUMBER TO SEND OTP to LOGIN SCREEN

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _nController = TextEditingController();
  AuthService _authController = AuthService();

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  user.User _user;

  String number = "";
  int countryCode = 91;
  String _smsVerificationCode;
  int _forceResendingToken;

  @override
  void initState() {
    super.initState();
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
        child: Container(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [CustomColors.green, CustomColors.lightGrey],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: _getBody(),
        ),
      ),
    );
  }

  Widget _getBody() {
    return Column(
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
        Padding(
          padding:
              EdgeInsets.only(top: 10, bottom: 15.0, left: 20.0, right: 20.0),
          child: TextFormField(
            textAlign: TextAlign.start,
            controller: _nController,
            autofocus: false,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10)
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
              hintText: "Mobile Number",
              fillColor: CustomColors.white,
              filled: true,
              contentPadding: EdgeInsets.all(14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: 5),
              Icon(
                Icons.info_outline,
                color: CustomColors.alertRed,
                size: 20.0,
              ),
              SizedBox(width: 5.0),
              Flexible(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "We will send",
                        style: TextStyle(
                            color: CustomColors.blue,
                            fontWeight: FontWeight.w400),
                      ),
                      TextSpan(
                        text: " OTP",
                        style: TextStyle(
                            color: CustomColors.alertRed,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700),
                      ),
                      TextSpan(
                        text: " to this Mobile Number",
                        style: TextStyle(
                            color: CustomColors.blue,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
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
                  _submit();
                },
                child: Text(
                  "Get OTP",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: CustomColors.white,
                    fontWeight: FontWeight.bold,
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
                padding: EdgeInsets.all(5.0),
                child: Text(
                  "Don't have an account?",
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
                      builder: (BuildContext context) => MobileSignInPage(),
                      settings: RouteSettings(name: '/signup'),
                    ),
                  );
                },
                child: Text(
                  "SIGN UP",
                  style: TextStyle(
                    color: CustomColors.black,
                    fontSize: 22.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _submit() async {
    if (_nController.text.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar.errorSnackBar("Enter valid Mobile Number", 2));
      return;
    } else {
      CustomDialogs.showLoadingDialog(context, _keyLoader);

      number = _nController.text;
      try {
        Map<String, dynamic> _uJSON =
            await user.User().getByID(countryCode.toString() + number);
        if (_uJSON == null) {
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackBar.errorSnackBar(
                  "No USER found for this Number, please 'SIGN UP'", 2));
          return;
        } else {
          this._user = user.User.fromJson(_uJSON);
          _verifyPhoneNumber();
        }
      } on PlatformException catch (err) {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar.errorSnackBar("Error while Login: " + err.message, 2),
        );
      } on Exception catch (err) {
        print(err);
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar.errorSnackBar(
              "Error while Login, please try later! ", 2),
        );
      }
    }
  }

  _verifyPhoneNumber() async {
    String phoneNumber = '+' + countryCode.toString() + number;
    final FirebaseAuth _auth = FirebaseAuth.instance;

    if (kIsWeb) {
      ConfirmationResult confirmationResult =
          await _auth.signInWithPhoneNumber(phoneNumber);

      // cachedLocalUser = _user;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => PhoneAuthVerify(
              false,
              _user.mobileNumber.toString(),
              _user.countryCode,
              _user.password,
              _user.firstName,
              _user.lastName,
              _smsVerificationCode,
              _forceResendingToken,
              confirmResult: confirmationResult),
        ),
      );
    } else {
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
  }

  _verificationComplete(
      AuthCredential authCredential, BuildContext context) async {
    FirebaseAuth.instance
        .signInWithCredential(authCredential)
        .then((UserCredential authResult) async {
      final SharedPreferences prefs = await _prefs;

      var result = await _authController.signInWithMobileNumber(_user.getID());

      if (!result['is_success']) {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar.errorSnackBar(
            "Unable to Login, Something went wrong. Please try again Later!",
            2));
        ScaffoldMessenger.of(context)
            .showSnackBar(CustomSnackBar.errorSnackBar(result['message'], 2));
      } else {
        prefs.setString("user_profile_pic", _user.getProfilePicPath());
        prefs.setString("user_name", _user.getFullName());
        prefs.setString("mobile_number", _user.getID());

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => HomeScreen(0)),
          (Route<dynamic> route) => false,
        );
      }
    }).catchError((error) {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar.errorSnackBar(
          "Something has gone wrong, please try later", 2));
    });
  }

  _smsCodeSent(String verificationId, [code]) {
    ScaffoldMessenger.of(context)
        .showSnackBar(CustomSnackBar.successSnackBar("OTP sent", 1));

    _smsVerificationCode = verificationId;
    _forceResendingToken = code;
    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
    CustomDialogs.showLoadingDialog(context, _keyLoader);
  }

  _verificationFailed(dynamic authException, BuildContext context) {
    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
    ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar.errorSnackBar(
        "Verification Failed: " + authException.message.toString(), 2));
  }

  _codeAutoRetrievalTimeout(String verificationId) {
    _smsVerificationCode = verificationId;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => PhoneAuthVerify(
            false,
            _user.mobileNumber.toString(),
            _user.countryCode,
            _user.password,
            _user.firstName,
            _user.lastName,
            _smsVerificationCode,
            _forceResendingToken),
      ),
    );
  }
}

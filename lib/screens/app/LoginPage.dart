import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:greenland_stock/constants.dart';
import 'package:greenland_stock/db/user.dart' as user;
import 'package:greenland_stock/screens/app/PhoneAuthVerify.dart';
import 'package:greenland_stock/screens/utils/CustomDialogs.dart';
import 'package:greenland_stock/screens/utils/CustomSnackBar.dart';
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
  TextEditingController _number = TextEditingController();
  AuthService _authController = AuthService();

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  user.User _user;

  String number = "";
  int countryCode = 91;
  String _smsVerificationCode;
  int _forceResendingToken;

  bool _validate = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("GreenLand Stock"),
        leading: InkWell(
          child: Icon(Icons.arrow_back_ios),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Column(
                children: [
                  Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 18, right: 25, left: 25),
                    child: Divider(
                      height: 1,
                      color: Colors.black45,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "Login with Mobile OTP",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black38),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.10,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 8, bottom: 8),
                          child: TextFormField(
                            controller: _number,
                            decoration: InputDecoration(
                                errorText: _validate
                                    ? 'Please enter the Mobile Number'
                                    : null,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.0)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 2.0),
                                ),
                                labelText: 'Mobile Number',
                                hintText: 'Enter registered Mobile Number'),
                          ),
                        ),
                        SizedBox(height: 20),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(28),
                          child: ButtonTheme(
                            minWidth: 200.0,
                            height: 57.0,
                            child: RaisedButton(
                              child: Text('Get OTP'),
                              color: Colors.green,
                              textColor: Colors.white,
                              onPressed: () {
                                setState(() {
                                  _number.text.isEmpty
                                      ? _validate = true
                                      : _validate = false;
                                });

                                if (_validate == false) {
                                  _submit();
                                }
                              },
                            ),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 20, bottom: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: new Container(
                                      margin: const EdgeInsets.only(
                                          left: 35.0, right: 10.0),
                                      child: Divider(
                                        color: Colors.black54,
                                        height: 36,
                                      )),
                                ),
                                Text(
                                  "OR",
                                ),
                                Expanded(
                                  child: new Container(
                                      margin: const EdgeInsets.only(
                                          left: 10.0, right: 35.0),
                                      child: Divider(
                                        color: Colors.black54,
                                        height: 36,
                                      )),
                                ),
                                //Text(
                                //'(or)',
                                //style: styles.ThemeText.defaultBtnTextBlack,
                                //)
                              ],
                            )),
                        InkWell(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: const Text.rich(
                              TextSpan(
                                text: 'Don\'t have an account? ',
                                children: [
                                  TextSpan(
                                      text: 'Register!',
                                      style: TextStyle(
                                        color: Colors.green,
                                      )),
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, registerRoute);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submit() async {
    if (_number.text.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar.errorSnackBar("Enter valid Mobile Number", 2));
      return;
    } else {
      CustomDialogs.showLoadingDialog(context, _keyLoader);

      number = _number.text;
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

        Navigator.of(context).pushNamedAndRemoveUntil(
          homeRoute,
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

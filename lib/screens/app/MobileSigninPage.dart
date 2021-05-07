import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenland_stock/constants.dart';
import 'package:greenland_stock/db/user.dart' as user;
import 'package:flutter/services.dart';
import 'package:greenland_stock/screens/app/PhoneAuthVerify.dart';
import 'package:greenland_stock/screens/utils/CustomDialogs.dart';
import 'package:greenland_stock/screens/utils/CustomSnackBar.dart';
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

  bool _validate = false;
  bool _validate2 = false;
  bool _validate3 = false;

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
      body: SingleChildScrollView(
        child: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Column(
                  children: [
                    Text(
                      "REGISTR HERE!!",
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
                        "Get started with your name",
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
                            height: MediaQuery.of(context).size.height * 0.08,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5, bottom: 5),
                            child: TextFormField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                  errorText: _validate
                                      ? 'Please enter the name'
                                      : null,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 2.0),
                                  ),
                                  labelText: 'Name',
                                  hintText: 'Enter your name'),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5, bottom: 5),
                            child: TextFormField(
                              controller: _phoneNumberController,
                              decoration: InputDecoration(
                                  errorText: _validate2
                                      ? 'Please enter the phone number'
                                      : null,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 2.0),
                                  ),
                                  labelText: 'Phone Number',
                                  hintText: 'Enter your phone number'),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5, bottom: 5),
                            child: TextFormField(
                              // keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.send,
                              autocorrect: true,
                              obscureText: _passwordVisible,
                              controller: _passKeyController,
                              decoration: InputDecoration(
                                  suffixIcon: GestureDetector(
                                      onTap: _viewpass,
                                      child: _passwordVisible
                                          ? Icon(Icons.visibility_sharp,
                                              color: Colors.grey)
                                          : Icon(Icons.visibility_off_rounded,
                                              color: Colors.grey)),
                                  errorText: _validate3
                                      ? 'Please enter the password'
                                      : null,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.0)),
                                    borderSide: BorderSide(
                                        color: Colors.blue[200], width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 2.0),
                                  ),
                                  labelText: 'Password',
                                  hintText: 'Enter a strong password'),
                            ),
                          ),
                          SizedBox(height: 20),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(28),
                            child: ButtonTheme(
                              minWidth: 200.0,
                              height: 57.0,
                              child: RaisedButton(
                                child: Text('Continue'),
                                color: Colors.green,
                                textColor: Colors.white,
                                onPressed: () {
                                  setState(() {
                                    _passKeyController.text.isEmpty
                                        ? _validate3 = true
                                        : _validate3 = false;
                                    _nameController.text.isEmpty
                                        ? _validate = true
                                        : _validate = false;
                                    _phoneNumberController.text.isEmpty
                                        ? _validate2 = true
                                        : _validate2 = false;
                                  });

                                  if (_validate == false &&
                                      _validate2 == false &&
                                      _validate3 == false) {
                                    startPhoneAuth();
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
                          GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: const Text.rich(
                                TextSpan(
                                  text: 'Already have an account? ',
                                  children: [
                                    TextSpan(
                                        text: 'Sign in.',
                                        style: TextStyle(
                                          color: Colors.green,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, loginRoute);
                            },
                          ),
                          SizedBox(height: 20)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _viewpass() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

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

        Navigator.of(context).pushNamedAndRemoveUntil(
          homeRoute,
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

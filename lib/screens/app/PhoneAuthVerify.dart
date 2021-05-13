import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:greenland_stock/constants.dart';
import 'package:greenland_stock/screens/utils/CustomColors.dart';
import 'package:greenland_stock/screens/utils/CustomSnackBar.dart';
import 'package:greenland_stock/services/auth_service.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhoneAuthVerify extends StatefulWidget {
  PhoneAuthVerify(this.isRegister, this.number, this.countryCode, this.passKey,
      this.name, this.lastName, this.verificationID, this.forceResendingToken,
      {this.confirmResult});

  final bool isRegister;
  final String number;
  final int countryCode;
  final String passKey;
  final String name;
  final String lastName;
  final String verificationID;
  final forceResendingToken;

  final ConfirmationResult confirmResult;

  @override
  _PhoneAuthVerifyState createState() => _PhoneAuthVerifyState();
}

class _PhoneAuthVerifyState extends State<PhoneAuthVerify> {
  TextEditingController textEditingController = TextEditingController();
  String currentText = "";
  StreamController<ErrorAnimationType> errorController;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final AuthService _authController = AuthService();

  @override
  void initState() {
    super.initState();
    startTimer();

    errorController = StreamController<ErrorAnimationType>();
  }

  @override
  void deactivate() {
    EasyLoading.dismiss();
    super.deactivate();
  }

  int resendSMSCount = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Timer _timer;
  int _start = 30;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();

    errorController.close();
    super.dispose();
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Text(
              "OTP Verification",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            _getPinFields(),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.green,
              margin:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
              child: ButtonTheme(
                minWidth: 100.0,
                height: 40.0,
                child: TextButton(
                  onPressed: signIn,
                  child: Center(
                      child: Text(
                    "Verify",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getPinFields() => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
            child: RichText(
              text: TextSpan(
                text: "Enter the code sent to ",
                children: [
                  TextSpan(
                    text: '+91 ${widget.number}',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ],
                style: TextStyle(color: Colors.black54, fontSize: 15),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.10,
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 30),
            child: PinCodeTextField(
              appContext: context,
              pastedTextStyle: TextStyle(
                color: Colors.green.shade600,
                fontWeight: FontWeight.bold,
              ),
              length: 6,
              obscureText: false,
              obscuringCharacter: '*',
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(10),
                  fieldHeight: 45,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                  selectedFillColor: Colors.white,
                  inactiveFillColor: Colors.grey[300]),
              cursorColor: Colors.black,
              animationDuration: Duration(milliseconds: 300),
              errorAnimationController: errorController,
              textStyle: TextStyle(fontSize: 17, height: 1.6),
              enableActiveFill: true,
              backgroundColor: Colors.transparent,
              controller: textEditingController,
              keyboardType: TextInputType.number,
              boxShadows: [
                BoxShadow(
                  offset: Offset(0, 1),
                  color: Colors.black12,
                  blurRadius: 10,
                )
              ],
              onChanged: (value) {
                setState(() {
                  currentText = value;
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: 16.0),
              _start != 0
                  ? Text("Resend OTP in $_start sec")
                  : resendSMSCount < 1
                      ? Flexible(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Didn't receive the code?, ",
                                  style: TextStyle(
                                      color: CustomColors.black,
                                      fontWeight: FontWeight.w400),
                                ),
                                TextSpan(
                                  text: 'RESEND',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      _verifyPhoneNumber();
                                    },
                                  style: TextStyle(
                                      color: CustomColors.alertRed,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(),
              SizedBox(width: 16.0),
            ],
          ),
          SizedBox(height: 20.0),
        ],
      );

  _verifyPhoneNumber() async {
    String phoneNumber = '+' + widget.countryCode.toString() + widget.number;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.verifyPhoneNumber(
        forceResendingToken: widget.forceResendingToken,
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
      final SharedPreferences prefs = await _prefs;

      var result = await _authController.signInWithMobileNumber(
          widget.countryCode.toString() + widget.number);

      if (!result['is_success']) {
        EasyLoading.dismiss();
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar.errorSnackBar(
            "Unable to Login, Something went wrong. Please try again Later!",
            2));
      } else {
        prefs.setString("user_name", widget.name + " " + widget.lastName ?? "");
        prefs.setString(
            "mobile_number", widget.countryCode.toString() + widget.number);

        EasyLoading.dismiss();
        Navigator.of(context).pushNamedAndRemoveUntil(
          homeRoute,
          (Route<dynamic> route) => false,
        );
      }
    }).catchError((error) {
      EasyLoading.dismiss();
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar.errorSnackBar(
          "Something has gone wrong, please try later", 2));
    });
  }

  _smsCodeSent(String verificationId, [code]) {
    ScaffoldMessenger.of(context)
        .showSnackBar(CustomSnackBar.successSnackBar("OTP sent", 1));
    setState(() {
      resendSMSCount = resendSMSCount + 1;
    });
    EasyLoading.dismiss();
    EasyLoading.show(status: 'loading...');
  }

  _verificationFailed(dynamic authException, BuildContext context) {
    EasyLoading.dismiss();
    ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar.errorSnackBar(
        "Verification Failed:" + authException.message.toString(), 2));
  }

  _codeAutoRetrievalTimeout(String verificationId) {
    EasyLoading.dismiss();
  }

  signIn() async {
    if (currentText.trim().length != 6) {
      ScaffoldMessenger.of(context)
          .showSnackBar(CustomSnackBar.errorSnackBar("Invalid OTP", 2));
      errorController.add(ErrorAnimationType.shake);
    } else {
      EasyLoading.show(status: 'loading...');

      if (kIsWeb) {
        await widget.confirmResult.confirm(currentText.trim());
        await _success();
      } else {
        verifyOTPAndLogin(currentText.trim());
      }
    }
  }

  void verifyOTPAndLogin(String smsCode) async {
    AuthCredential _authCredential = PhoneAuthProvider.credential(
        verificationId: widget.verificationID, smsCode: smsCode);

    FirebaseAuth.instance
        .signInWithCredential(_authCredential)
        .then((UserCredential authResult) async {
      if (widget.isRegister) {
        dynamic result = await _authController.registerWithMobileNumber(
            int.parse(widget.number),
            widget.countryCode,
            widget.passKey,
            widget.name,
            widget.lastName,
            authResult.user.uid);
        if (!result['is_success']) {
          EasyLoading.dismiss();
          ScaffoldMessenger.of(context)
              .showSnackBar(CustomSnackBar.errorSnackBar(result['message'], 5));
        } else {
          await _success();
        }
      } else {
        dynamic result = await _authController.signInWithMobileNumber(
            widget.countryCode.toString() + widget.number);
        if (!result['is_success']) {
          EasyLoading.dismiss();
          ScaffoldMessenger.of(context)
              .showSnackBar(CustomSnackBar.errorSnackBar(result['message'], 5));
        } else {
          try {
            await _success();
          } catch (err) {
            EasyLoading.dismiss();
            ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar.errorSnackBar(
                "Unable to Login, Something went wrong. Please try again Later!",
                2));
            return;
          }
        }
      }
    }).catchError((error) {
      EasyLoading.dismiss();
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar.errorSnackBar(
          "Something has gone wrong, please try later", 2));
    });
  }

  _success() async {
    final SharedPreferences prefs = await _prefs;

    prefs.setString("user_name", widget.name + " " + widget.lastName ?? "");
    prefs.setString(
        "mobile_number", widget.countryCode.toString() + widget.number);

    EasyLoading.dismiss();
    Navigator.of(context).pushNamedAndRemoveUntil(
      homeRoute,
      (Route<dynamic> route) => false,
    );
  }
}

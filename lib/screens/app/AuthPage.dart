import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:greenland_stock/constants.dart';
import 'package:greenland_stock/db/user.dart';
import 'package:greenland_stock/screens/utils/CustomColors.dart';
import 'package:greenland_stock/screens/utils/CustomSnackBar.dart';
import 'package:greenland_stock/screens/utils/hash_generator.dart';
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
  TextEditingController _passwd = TextEditingController();
  TextEditingController _userID = TextEditingController();
  final AuthService _authController = AuthService();

  bool _validate = false;
  bool _validate2 = false;

  bool _passwordVisible = true;

  @override
  void initState() {
    super.initState();

    _userID.text = widget.userID;

    if (!kIsWeb) biometric();
  }

  @override
  void deactivate() {
    EasyLoading.dismiss();
    super.deactivate();
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
                    "Sign in",
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
                      "Login with Mobile Number & Password",
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
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 8, bottom: 8),
                          child: TextFormField(
                            controller: _userID,
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
                        Container(
                          margin: const EdgeInsets.only(top: 8, bottom: 8),
                          child: TextFormField(
                            // keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.send,
                            autocorrect: true,
                            obscureText: _passwordVisible,
                            controller: _passwd,
                            decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                    onTap: _viewpass,
                                    child: _passwordVisible
                                        ? Icon(Icons.visibility_sharp,
                                            color: Colors.grey)
                                        : Icon(Icons.visibility_off_rounded,
                                            color: Colors.grey)),
                                errorText: _validate2
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
                                hintText: 'Enter your password'),
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(right: 8, bottom: 8),
                          child: Container(
                            alignment: Alignment(1.0, 0.0),
                            child: Text.rich(
                              TextSpan(
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () =>
                                      Navigator.pushNamed(context, loginRoute),
                                text: "Forget Password?",
                                style: TextStyle(color: CustomColors.alertRed),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(28),
                          child: ElevatedButton(
                            child: Text(
                              'Continue',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all<Size>(
                                  Size(200, 57)),
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                      EdgeInsets.all(5.0)),
                              elevation: MaterialStateProperty.all<double>(5),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green),
                            ),
                            onPressed: () async {
                              setState(() {
                                _userID.text.isEmpty
                                    ? _validate = true
                                    : _validate = false;
                                _passwd.text.isEmpty
                                    ? _validate2 = true
                                    : _validate2 = false;
                              });

                              _submit(_userID.text);
                            },
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 20, bottom: 5),
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
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text.rich(
                            TextSpan(
                              text: 'Don\'t have an account? ',
                              children: [
                                TextSpan(
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () => Navigator.pushNamed(
                                        context, registerRoute),
                                  text: ' Register!',
                                  style: TextStyle(
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
    );
  }

  void _viewpass() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  biometric() async {
    final LocalAuthentication auth = LocalAuthentication();
    try {
      bool canCheckBiometrics = await auth.canCheckBiometrics;
      bool isBiometricSupported = await auth.isDeviceSupported();
      if (isBiometricSupported && canCheckBiometrics) {
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
    EasyLoading.show(status: 'loading...');

    var result = await _authController.signInWithMobileNumber(_userID);

    if (!result['is_success']) {
      EasyLoading.dismiss();
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar.errorSnackBar(
          "Unable to Login, Something went wrong. Please try again Later!", 2));
    } else {
      EasyLoading.dismiss();
      Navigator.pushNamedAndRemoveUntil(
          context, homeRoute, (Route<dynamic> route) => false);
    }
  }

  void _submit(String _userID) async {
    try {
      Map<String, dynamic> _userData = await User().getByID(_userID);
      User _user = User.fromJson(_userData);

      String hashKey = HashGenerator.hmacGenerator(_passwd.text, _user.getID());
      if (hashKey != _user.password) {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar.errorSnackBar(
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

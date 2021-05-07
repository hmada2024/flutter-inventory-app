import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:password_validator/password_validator.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final _text = TextEditingController();
  final _pass = TextEditingController();
  bool _validate = false;
  bool _validate2 = false;
  bool IsPasswordHidden = true;
  bool emailValid = true;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
    _pass.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
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
                      "Get started with your Email",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black38),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.20,
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 8, bottom: 8),
                              child: TextFormField(
                                controller: _text,
                                decoration: InputDecoration(
                                    errorText: _validate
                                        ? 'Please enter the E-mail'
                                        : null,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.0)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 2.0),
                                    ),
                                    labelText: 'Email',
                                    hintText: 'Enter registered e-mail'),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 8, bottom: 8),
                              child: TextFormField(
                                // keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.send,
                                autocorrect: true,
                                obscureText: IsPasswordHidden,
                                controller: _pass,
                                decoration: InputDecoration(
                                    suffixIcon: GestureDetector(
                                        onTap: _viewpass,
                                        child: IsPasswordHidden
                                            ? Icon(Icons.visibility_sharp,
                                                color: Colors.grey)
                                            : Icon(Icons.visibility_off_rounded,
                                                color: Colors.grey)),
                                    errorText: _validate2
                                        ? 'Please enter the password'
                                        : null,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.0)),
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
                              padding:
                                  const EdgeInsets.only(right: 8, bottom: 8),
                              child: Container(
                                alignment: Alignment(1.0, 0.0),
                                child: GestureDetector(
                                  child: Text(
                                    "Forget Password?",
                                  ),
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/forget-pass');
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
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
                                      _text.text.isEmpty
                                          ? _validate = true
                                          : _validate = false;
                                      _pass.text.isEmpty
                                          ? _validate2 = true
                                          : _validate2 = false;
                                    });

                                    if (_validate == false &&
                                        _validate2 == false) {
                                      Navigator.pushNamed(
                                          context, '/home_screen');
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
                                    text: 'Don\'t have an account? ',
                                    children: [
                                      TextSpan(
                                          text: 'Sign up.',
                                          style: TextStyle(
                                            color: Colors.green,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, '/register-screen');
                              },
                            ),
                            SizedBox(height: 20)
                          ],
                        )),
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
    if (IsPasswordHidden == true) {
      IsPasswordHidden = false;
    } else {
      IsPasswordHidden = true;
    }
    setState(() {});
  }
}

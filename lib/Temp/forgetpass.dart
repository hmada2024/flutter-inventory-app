import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgetPass extends StatefulWidget {
  @override
  _ForgetPassState createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  bool isLoading = false;
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final _text = TextEditingController();

  bool _validate = false;

  @override
  void dispose() {
    _text.dispose();
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
                    "Forget Password",
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
                      "Enter Email to restore account",
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
                        autovalidate: true,
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
                                      _text.text.isEmpty
                                          ? _validate = true
                                          : _validate = false;
                                    });

                                    if (_validate == false) {
                                      // Navigator.pushNamed(
                                      //     context, '/home_screen');
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
                                    text: 'Remember password? ',
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
                                Navigator.pushNamed(context, '/login-screen');
                              },
                            ),
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
}

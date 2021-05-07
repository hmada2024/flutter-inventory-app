import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isLoading = false;
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phno = TextEditingController();
  final _pass = TextEditingController();
  bool _validate = false;
  bool _validate1 = false;
  bool _validate2 = false;
  bool _validate3 = false;
  bool IsPasswordHidden = true;
  bool emailValid = true;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
    _pass.dispose();
    super.dispose();
    _phno.dispose();
    super.dispose();
    _email.dispose();
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
                    "Sign up",
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
                    child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.10,
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 8, bottom: 8),
                              child: TextFormField(
                                controller: _name,
                                decoration: InputDecoration(
                                    errorText: _validate
                                        ? 'Please enter the name'
                                        : null,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.0)),
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
                              margin: const EdgeInsets.only(top: 8, bottom: 8),
                              child: TextFormField(
                                controller: _email,
                                decoration: InputDecoration(
                                    errorText: _validate1
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
                                    hintText: 'Enter your e-mail'),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 8, bottom: 8),
                              child: TextFormField(
                                controller: _phno,
                                decoration: InputDecoration(
                                    errorText: _validate2
                                        ? 'Please enter the phone number'
                                        : null,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.0)),
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
                                    errorText: _validate3
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
                                      _email.text.isEmpty
                                          ? _validate1 = true
                                          : _validate1 = false;
                                      _pass.text.isEmpty
                                          ? _validate3 = true
                                          : _validate3 = false;
                                      _name.text.isEmpty
                                          ? _validate = true
                                          : _validate = false;
                                      _phno.text.isEmpty
                                          ? _validate2 = true
                                          : _validate2 = false;
                                    });

                                    if (_validate == false &&
                                        _validate1 == false &&
                                        _validate2 == false &&
                                        _validate3 == false) {
                                      Navigator.pushNamed(context, '/otp');
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
                                Navigator.pushNamed(context, '/login-screen');
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

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ENTER MOBILE NUMBER TO SEND OTP to LOGIN SCREEN

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _number = TextEditingController();
  TextEditingController _number1 = TextEditingController();
  TextEditingController _number2 = TextEditingController();

  bool _validate = false;
  bool _validate1 = false;
  bool _validate2 = false;

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
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "Add new products here",
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
                                errorText:
                                    _validate ? 'This field is required' : null,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.0)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 2.0),
                                ),
                                labelText: 'Enter Product name',
                                hintText: 'Enter the Product name here'),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 8, bottom: 8),
                          child: TextFormField(
                            controller: _number1,
                            decoration: InputDecoration(
                                errorText: _validate1
                                    ? 'This field is required'
                                    : null,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.0)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 2.0),
                                ),
                                labelText: 'Enter Product description',
                                hintText: 'Enter the Product description here'),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 8, bottom: 8),
                          child: TextFormField(
                            controller: _number2,
                            decoration: InputDecoration(
                                errorText: _validate2
                                    ? 'This field is required'
                                    : null,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.0)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 2.0),
                                ),
                                labelText: 'Enter Product quantity',
                                hintText: 'Enter the Product quantity here'),
                          ),
                        ),
                        SizedBox(height: 20),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(28),
                          child: ButtonTheme(
                            minWidth: 200.0,
                            height: 57.0,
                            child: RaisedButton(
                              child: Text('Add Product'),
                              color: Colors.green,
                              textColor: Colors.white,
                              onPressed: () {
                                setState(() {
                                  _number.text.isEmpty
                                      ? _validate = true
                                      : _validate = false;
                                  _number1.text.isEmpty
                                      ? _validate1 = true
                                      : _validate1 = false;
                                  _number2.text.isEmpty
                                      ? _validate2 = true
                                      : _validate2 = false;
                                });

                                if (_validate == false &&
                                    _validate1 == false &&
                                    _validate2 == false) {
                                  // _submit();
                                }
                              },
                            ),
                          ),
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
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:greenland_stock/db/address.dart';
import 'package:greenland_stock/db/business.dart';
import 'package:greenland_stock/screens/utils/CustomColors.dart';
import 'package:greenland_stock/screens/utils/CustomSnackBar.dart';
import 'package:greenland_stock/services/user_service.dart';

class AddBusiness extends StatefulWidget {
  @override
  _AddBusinessState createState() => _AddBusinessState();
}

class _AddBusinessState extends State<AddBusiness> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Address updatedAddress = Address();

  String sName = "";
  String oName = "";

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
        title: Text("Add Store"),
        leading: InkWell(
          child: Icon(Icons.arrow_back_ios),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: SafeArea(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 5, bottom: 5),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.0)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 2.0),
                                    ),
                                    labelText: 'Name',
                                    hintText: 'Enter your Store name'),
                                validator: (name) {
                                  if (name.isEmpty) {
                                    return "Must not be empty";
                                  } else {
                                    this.sName = name;
                                    return null;
                                  }
                                },
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5, bottom: 5),
                              child: TextFormField(
                                initialValue: cachedLocalUser.getFullName(),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.0)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 2.0),
                                    ),
                                    labelText: 'Owned By',
                                    hintText: 'Owner Name'),
                                validator: (oName) {
                                  if (oName.isEmpty) {
                                    return "Must not be empty";
                                  } else {
                                    this.oName = oName;
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 40,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Address",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: TextFormField(
                                        initialValue: updatedAddress.street,
                                        textAlign: TextAlign.center,
                                        maxLines: 3,
                                        decoration: InputDecoration(
                                          labelText: 'Building & Street',
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          labelStyle: TextStyle(
                                            fontSize: 12.0,
                                            color: CustomColors.black,
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 10.0),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                      CustomColors.lightGreen)),
                                          fillColor: CustomColors.white,
                                          filled: true,
                                        ),
                                        validator: (street) {
                                          if (street.trim().isEmpty) {
                                            return "Enter your Street";
                                          } else {
                                            updatedAddress.street =
                                                street.trim();
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: TextFormField(
                                        initialValue: updatedAddress.landmark,
                                        textAlign: TextAlign.start,
                                        decoration: InputDecoration(
                                          labelText: "Landmark",
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          labelStyle: TextStyle(
                                            fontSize: 12.0,
                                            color: CustomColors.black,
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 3.0, horizontal: 10.0),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                      CustomColors.lightGreen)),
                                          fillColor: CustomColors.white,
                                          filled: true,
                                        ),
                                        validator: (landmark) {
                                          if (landmark.trim() != "") {
                                            updatedAddress.landmark =
                                                landmark.trim();
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: TextFormField(
                                        initialValue: updatedAddress.city,
                                        textAlign: TextAlign.start,
                                        decoration: InputDecoration(
                                          labelText: 'City',
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          labelStyle: TextStyle(
                                            fontSize: 12.0,
                                            color: CustomColors.black,
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 3.0, horizontal: 10.0),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                      CustomColors.lightGreen)),
                                          fillColor: CustomColors.white,
                                          filled: true,
                                        ),
                                        validator: (city) {
                                          if (city.trim().isEmpty) {
                                            return "Enter your City";
                                          } else {
                                            updatedAddress.city = city.trim();
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.only(left: 5)),
                                    Flexible(
                                      child: TextFormField(
                                        initialValue: updatedAddress.state,
                                        textAlign: TextAlign.start,
                                        decoration: InputDecoration(
                                          labelText: 'State',
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          labelStyle: TextStyle(
                                            fontSize: 12.0,
                                            color: CustomColors.black,
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 3.0, horizontal: 10.0),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                      CustomColors.lightGreen)),
                                          fillColor: CustomColors.white,
                                          filled: true,
                                        ),
                                        validator: (state) {
                                          if (state.trim().isEmpty) {
                                            return "Enter Your State";
                                          } else {
                                            updatedAddress.state = state.trim();
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: TextFormField(
                                        initialValue: updatedAddress.pincode,
                                        textAlign: TextAlign.start,
                                        decoration: InputDecoration(
                                          labelText: 'Pincode',
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          labelStyle: TextStyle(
                                            fontSize: 12.0,
                                            color: CustomColors.black,
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 3.0, horizontal: 10.0),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                      CustomColors.lightGreen)),
                                          fillColor: CustomColors.white,
                                          filled: true,
                                        ),
                                        validator: (pinCode) {
                                          if (pinCode.trim().isEmpty) {
                                            return "Enter Your Pincode";
                                          } else {
                                            updatedAddress.pincode =
                                                pinCode.trim();

                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: TextFormField(
                                        initialValue:
                                            updatedAddress.country ?? "India",
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.start,
                                        decoration: InputDecoration(
                                          labelText: "Country / Region",
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          labelStyle: TextStyle(
                                            fontSize: 12.0,
                                            color: CustomColors.black,
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 3.0, horizontal: 10.0),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                      CustomColors.lightGreen)),
                                          fillColor: CustomColors.white,
                                          filled: true,
                                        ),
                                        validator: (country) {
                                          if (country.trim().isEmpty) {
                                            updatedAddress.country = "India";
                                          } else {
                                            updatedAddress.country =
                                                country.trim();
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ElevatedButton(
                        child: Text('Create'),
                        onPressed: () async {
                          await _submit();
                        },
                      ),
                      SizedBox(height: 20)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _submit() async {
    try {
      final FormState form = _formKey.currentState;

      if (form.validate()) {
        Business _b = Business();

        _b.name = this.sName;
        _b.ownedBy = this.oName;
        _b.address = this.updatedAddress;

        EasyLoading.show(status: 'loading...');
        await _b.create();
        EasyLoading.dismiss();
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackBar.errorSnackBar("Fill Required fields", 2));
      }
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar.errorSnackBar("Unable to create now! Try later!", 2),
      );
    }
  }
}

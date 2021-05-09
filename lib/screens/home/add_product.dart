import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenland_stock/db/products.dart';
import 'package:greenland_stock/screens/utils/CustomDialogs.dart';
import 'package:greenland_stock/screens/utils/CustomSnackBar.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String pName = "";
  String gName = "";
  double qty = 0.0;
  double minQty = 0.0;

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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Column(
                      children: [
                        Text(
                          "Add Product",
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 18, right: 25, left: 25),
                          child: Divider(
                            height: 1,
                            color: Colors.black45,
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
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 5, bottom: 5),
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
                                      hintText: 'Enter your name'),
                                  validator: (name) {
                                    if (name.isEmpty) {
                                      return "Must not be empty";
                                    } else {
                                      this.pName = name;
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 5, bottom: 5),
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
                                      labelText: 'Quantity',
                                      hintText: 'Available Quantity'),
                                  validator: (quantity) {
                                    if (quantity.isEmpty) {
                                      qty = double.parse('0');
                                    } else {
                                      qty = double.parse(quantity);
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 5, bottom: 5),
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
                                      labelText: 'Min Quantity',
                                      hintText: 'Alert Quantity'),
                                  validator: (quantity) {
                                    if (quantity.isEmpty) {
                                      minQty = double.parse('0');
                                    } else {
                                      minQty = double.parse(quantity);
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(28),
                                child: ButtonTheme(
                                  minWidth: 200.0,
                                  height: 57.0,
                                  child: ElevatedButton(
                                    child: Text('Create'),
                                    onPressed: () async {
                                      await _submit();
                                    },
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
          ),
        ),
      ),
    );
  }

  _submit() async {
    try {
      final FormState form = _formKey.currentState;

      if (form.validate()) {
        Products _p = Products();

        _p.name = this.pName;
        _p.quantity = this.qty;
        _p.minQuantity = this.minQty;

        CustomDialogs.actionWaiting(context);
        await _p.create();
        Navigator.pop(context);
        // Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackBar.errorSnackBar("Fill Required fields", 2));
      }
    } catch (err) {
      print(err);
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar.errorSnackBar("Unable to create now! Try later!", 2),
      );
    }
  }
}

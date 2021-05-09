import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenland_stock/db/products.dart';
import 'package:greenland_stock/screens/utils/CustomColors.dart';
import 'package:greenland_stock/screens/utils/CustomDialogs.dart';
import 'package:greenland_stock/screens/utils/CustomSnackBar.dart';

class EditProduct extends StatefulWidget {
  EditProduct(this.product);

  final Products product;
  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
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
        title: Text("Edit Product"),
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
                          top: 10,
                          left: 20,
                          right: 20,
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(
                                Icons.store,
                                size: 35,
                                color: CustomColors.black,
                              ),
                              title: Container(
                                child: TextFormField(
                                  initialValue: widget.product.businessName,
                                  textAlign: TextAlign.end,
                                  autofocus: false,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    fillColor: CustomColors.white,
                                    filled: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 1.0, horizontal: 5.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                            color: CustomColors.grey)),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 5, bottom: 5),
                              child: TextFormField(
                                initialValue: widget.product.name,
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
                                initialValue:
                                    widget.product.quantity.toString(),
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
                                initialValue:
                                    widget.product.minQuantity.toString(),
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
                            SizedBox(height: 20),
                            ElevatedButton(
                              child: Text('Update'),
                              onPressed: () async {
                                await _submit();
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
      ),
    );
  }

  _submit() async {
    try {
      final FormState form = _formKey.currentState;

      if (form.validate()) {
        Products _p = widget.product;

        _p.name = this.pName;
        _p.quantity = this.qty;
        _p.minQuantity = this.minQty;
        _p.searchKeys =
            this.pName.split(" ").map((e) => e.toLowerCase()).toList();

        CustomDialogs.actionWaiting(context);
        await _p.update(_p.toJson());
        Navigator.pop(context);
        // Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackBar.errorSnackBar("Fill Required fields", 2));
      }
    } catch (err) {
      print(err);
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar.errorSnackBar("Unable to Update now! Try later!", 2),
      );
    }
  }
}

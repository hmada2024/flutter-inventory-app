import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:greenland_stock/db/products.dart';
import 'package:greenland_stock/screens/utils/CustomColors.dart';
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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String pName = "";
  String gName = "";
  double qty = 0.0;
  double minQty = 0.0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: SingleChildScrollView(
        child: Container(
          height: 350,
          width: MediaQuery.of(context).size.width * 0.7,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
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
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        BorderSide(color: CustomColors.grey)),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5, bottom: 5),
                          child: TextFormField(
                            initialValue: widget.product.name,
                            decoration: InputDecoration(
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
                          margin: const EdgeInsets.only(top: 5, bottom: 5),
                          child: TextFormField(
                            initialValue: widget.product.quantity.toString(),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.0)),
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
                          margin: const EdgeInsets.only(top: 5, bottom: 5),
                          child: TextFormField(
                            initialValue: widget.product.minQuantity.toString(),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.0)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 2.0),
                                ),
                                labelText: 'Alert Quantity',
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

  _submit() async {
    try {
      final FormState form = _formKey.currentState;

      if (form.validate()) {
        double change = this.qty - widget.product.quantity;

        int type = change > 0
            ? 1
            : change < 0
                ? 2
                : 3;
        Products _p = widget.product;

        _p.name = this.pName;
        _p.quantity = this.qty;
        _p.minQuantity = this.minQty;
        _p.searchKeys =
            this.pName.split(" ").map((e) => e.toLowerCase()).toList();

        EasyLoading.show(status: 'loading...');
        await _p.updateProduct(type, change);
        EasyLoading.dismiss();
        Navigator.pop(context);
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

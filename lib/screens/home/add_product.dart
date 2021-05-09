import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenland_stock/db/business.dart';
import 'package:greenland_stock/db/products.dart';
import 'package:greenland_stock/screens/utils/CustomColors.dart';
import 'package:greenland_stock/screens/utils/CustomDialogs.dart';
import 'package:greenland_stock/screens/utils/CustomSnackBar.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> _stores = {"0": "Choose your Store"};
  String _selectedStore = "0";

  String pName = "";
  String gName = "";
  double qty = 0.0;
  double minQty = 0.0;

  @override
  void initState() {
    super.initState();

    loadStores();
  }

  loadStores() async {
    List<Business> stores = await Business().getStoresForUser();
    Map<String, String> storeList = Map();
    if (stores.length > 0) {
      stores.forEach(
        (b) {
          storeList[b.uuid] = b.name;
        },
      );

      setState(
        () {
          _stores = _stores..addAll(storeList);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Add Product"),
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
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: ListTile(
                                leading: Icon(
                                  Icons.store,
                                  size: 35,
                                  color: CustomColors.black,
                                ),
                                title: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(10.0),
                                      border: Border.all()),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      items: _stores.entries.map(
                                        (f) {
                                          return DropdownMenuItem<String>(
                                            value: f.key,
                                            child: Text(f.value),
                                          );
                                        },
                                      ).toList(),
                                      onChanged: (uuid) {
                                        setState(
                                          () {
                                            _selectedStore = uuid;
                                          },
                                        );
                                      },
                                      value: _selectedStore,
                                    ),
                                  ),
                                ),
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
      if (_selectedStore == "0") {
        ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar.errorSnackBar("Please select your Business!", 2),
        );
        return;
      }

      final FormState form = _formKey.currentState;

      if (form.validate()) {
        Products _p = Products();

        _p.name = this.pName;
        _p.quantity = this.qty;
        _p.minQuantity = this.minQty;
        _p.businessID = _selectedStore;
        _p.businessName = _stores[_selectedStore];

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

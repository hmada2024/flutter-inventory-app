import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:greenland_stock/constants.dart';
import 'package:greenland_stock/db/products.dart';
import 'package:greenland_stock/screens/app/appBar.dart';
import 'package:greenland_stock/screens/home/edit_products.dart';
import 'package:greenland_stock/screens/settings/SettingsHome.dart';
import 'package:greenland_stock/screens/utils/AsyncWidgets.dart';
import 'package:greenland_stock/screens/utils/CustomColors.dart';
import 'package:greenland_stock/screens/utils/CustomSnackBar.dart';
import 'package:greenland_stock/services/user_service.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen(this.index);

  final int index;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _searchController = TextEditingController();

  int backPressCounter = 0;
  int _selectedIndex = 0;

  bool isSearchTriggered;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.index;
    isSearchTriggered = false;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _submit(String key) {
    setState(() {
      isSearchTriggered = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: appBar(context),
        resizeToAvoidBottomInset: false,
        backgroundColor: CustomColors.lightGrey,
        floatingActionButton: _selectedIndex == 0
            ? FloatingActionButton(
                onPressed: () {
                  if (cachedLocalUser.primaryBusiness == null ||
                      cachedLocalUser.primaryBusiness.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      CustomSnackBar.errorSnackBar(
                          "No Primary Store Found! Please ADD a Store!", 3),
                    );
                    return;
                  }

                  Navigator.pushNamed(context, addProductRoute);
                },
                child: Icon(Icons.add),
                tooltip: 'Add Items',
              )
            : Container(),
        body: SingleChildScrollView(
          child: _selectedIndex == 0
              ? Container(
                  child: Column(children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _searchController,
                        onChanged: (searchKey) {
                          if (searchKey.trim().isNotEmpty &&
                              searchKey.trim().length >= 3) {
                            _submit(searchKey);
                          }
                        },
                        autocorrect: true,
                        decoration: InputDecoration(
                          hintText: 'Search Product..',
                          prefixIcon: Icon(Icons.search),
                          suffixIcon: isSearchTriggered
                              ? InkWell(
                                  onTap: () {
                                    if (isSearchTriggered) {
                                      _searchController.text = '';
                                      setState(() {
                                        isSearchTriggered = false;
                                      });
                                    }
                                  },
                                  child: Icon(Icons.clear),
                                )
                              : SizedBox(),
                          filled: true,
                          fillColor: Colors.grey[200],
                          contentPadding: const EdgeInsets.all(5.0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            borderSide:
                                BorderSide(color: Color(0xFFC1C1C1), width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            borderSide:
                                BorderSide(color: Color(0xFFC1C1C1), width: 1),
                          ),
                        ),
                      ),
                    ),
                    (cachedLocalUser.primaryBusiness == null ||
                            cachedLocalUser.primaryBusiness.isEmpty ||
                            cachedLocalUser.business.isEmpty)
                        ? _noProducts()
                        : !isSearchTriggered
                            ? _getProducts()
                            : _getSearchProducts(),
                  ]),
                )
              : SettingsHome(),
        ),
        bottomNavigationBar: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                onTap: () {
                  _searchController.text = '';
                  isSearchTriggered = false;
                  _onItemTapped(0);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.home,
                      size: 25.0,
                      color: Colors.green,
                    ),
                    Text(
                      "Home",
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  _onItemTapped(1);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.settings,
                      size: 22.0,
                      color: Colors.green,
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "Settings",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> onWillPop() {
    if (backPressCounter < 1) {
      backPressCounter++;
      Fluttertoast.showToast(msg: "Press again to exit !!");
      Future.delayed(Duration(seconds: 2, milliseconds: 0), () {
        backPressCounter--;
      });
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  Widget _getProducts() {
    return StreamBuilder(
      stream: Products().streamAllProducts(),
      builder: (context, snapshot) {
        Widget child;

        if (snapshot.hasData) {
          if (snapshot.data.docs.length == 0) {
            child = _noProducts();
          } else {
            child = Container(
              padding: EdgeInsets.all(8.0),
              child: _productsList(snapshot.data.docs),
            );
          }
        } else if (snapshot.hasError) {
          child = Center(
            child: Column(
              children: AsyncWidgets.asyncError(),
            ),
          );
        } else {
          child = Center(
            child: Column(
              children: AsyncWidgets.asyncWaiting(),
            ),
          );
        }
        return child;
      },
    );
  }

  Widget _noProducts() {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.sentiment_neutral,
              size: 40,
              color: CustomColors.black,
            ),
            SizedBox(height: 20),
            Text(
              "No Products Found!",
              style: TextStyle(
                color: CustomColors.alertRed,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _productsList(List<QueryDocumentSnapshot> docs) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: docs.length,
      itemBuilder: (BuildContext context, int index) {
        Products _p = Products.fromJson(docs[index].data());

        return kIsWeb
            ? StoreTile(product: _p)
            : getSlidableProductWidget(_p, context);
      },
    );
  }

  Slidable getSlidableProductWidget(Products _p, BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.20,
      child: StoreTile(product: _p),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Edit',
          color: Colors.indigo,
          icon: Icons.edit,
          onTap: () {
            showDialog(
                context: context,
                // barrierDismissible: true,
                builder: (BuildContext context) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.20,
                        ),
                        SingleChildScrollView(
                          child: EditProduct(_p),
                        ),
                      ],
                    ),
                  );
                });
          },
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
            caption: 'Remove',
            color: Colors.red[400],
            icon: Icons.delete_forever,
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  // return object of type Dialog
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    title: Text(
                      "${_p.name}",
                      textAlign: TextAlign.center,
                    ),
                    content: Text(
                      "Do you want to remove this product?",
                      style: TextStyle(color: Colors.grey, height: 1.5),
                    ),
                    actions: <Widget>[
                      // usually buttons at the bottom of the dialog
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.green),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.redAccent),
                        ),
                        onPressed: () async {
                          Navigator.pop(context);
                          EasyLoading.show(status: 'Removing...');
                          await _p.remove();
                          EasyLoading.showSuccess(
                            'Success',
                            duration: Duration(seconds: 2),
                          );
                        },
                        child: Text(
                          "Remove",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  );
                },
              );
            }),
      ],
    );
  }

  Widget _getSearchProducts() {
    return StreamBuilder(
      stream: Products().searchByKeys(_searchController.text),
      builder: (context, snapshot) {
        Widget child;

        if (snapshot.hasData) {
          if (snapshot.data.length == 0) {
            child = Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.sentiment_neutral,
                      size: 40,
                      color: CustomColors.black,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "No Products Found!",
                      style: TextStyle(
                        color: CustomColors.alertRed,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            );
          } else {
            child = Container(
              padding: EdgeInsets.all(8.0),
              child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  print(snapshot.data[index].docs);

                  return _productsList(snapshot.data[index].docs);
                },
              ),
            );
          }
        } else if (snapshot.hasError) {
          child = Center(
            child: Column(
              children: AsyncWidgets.asyncError(),
            ),
          );
        } else {
          child = Center(
            child: Column(
              children: AsyncWidgets.asyncWaiting(),
            ),
          );
        }
        return child;
      },
    );
  }
}

class StoreTile extends StatelessWidget {
  final Products product;

  const StoreTile({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: product.isLow
                ? Colors.redAccent.withOpacity(0.5)
                : Colors.white.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(1, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 20),
              SvgPicture.asset(
                'images/store.svg',
                height: 35.0,
                width: 35.0,
                allowDrawingOutsideViewBox: true,
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Flexible(
                      child: Text(product.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          )),
                    ),
                    SizedBox(height: 7),
                    Flexible(
                      child: Text(product.businessName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12.0,
                          )),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 20),
                child: Text(
                  product.quantity.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: product.isLow ? Colors.white : Colors.grey,
                    fontSize: 14.0,
                  ),
                ),
              ),
              kIsWeb
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Divider(
                          thickness: 1,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.20,
                                          ),
                                          SingleChildScrollView(
                                            child: EditProduct(product),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            },
                            child: Column(
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                Text(
                                  'Edit',
                                  style: TextStyle(color: Colors.black),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  // return object of type Dialog
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0))),
                                    title: Text(
                                      "${product.name}",
                                      textAlign: TextAlign.center,
                                    ),
                                    content: Text(
                                      "Do you want to remove this product?",
                                      style: TextStyle(
                                          color: Colors.grey, height: 1.5),
                                    ),
                                    actions: <Widget>[
                                      // usually buttons at the bottom of the dialog
                                      TextButton(
                                        style: ButtonStyle(
                                          padding: MaterialStateProperty.all<
                                              EdgeInsetsGeometry>(
                                            EdgeInsets.symmetric(horizontal: 5),
                                          ),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.green),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      TextButton(
                                        style: ButtonStyle(
                                          padding: MaterialStateProperty.all<
                                              EdgeInsetsGeometry>(
                                            EdgeInsets.symmetric(horizontal: 5),
                                          ),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.redAccent),
                                        ),
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          EasyLoading.show(
                                              status: 'Removing...');
                                          await product.remove();
                                          EasyLoading.showSuccess(
                                            'Success',
                                            duration: Duration(seconds: 2),
                                          );
                                        },
                                        child: Text(
                                          "Remove",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Column(
                              children: [
                                Icon(
                                  Icons.delete_forever,
                                  color: Colors.red,
                                ),
                                Text(
                                  'Remove',
                                  style: TextStyle(color: Colors.black),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  : Container()
            ],
          ),
          SizedBox(height: 10),
          Divider(
            height: 1,
          )
        ],
      ),
    );
  }
}

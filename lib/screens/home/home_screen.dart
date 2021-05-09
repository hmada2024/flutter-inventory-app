import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greenland_stock/constants.dart';
import 'package:greenland_stock/db/products.dart';
import 'package:greenland_stock/screens/app/appBar.dart';
import 'package:greenland_stock/screens/home/edit_products.dart';
import 'package:greenland_stock/screens/settings/SettingsHome.dart';
import 'package:greenland_stock/screens/utils/AsyncWidgets.dart';
import 'package:greenland_stock/screens/utils/CustomColors.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen(this.index);

  final int index;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _searchController = TextEditingController();

  Stream<QuerySnapshot> _pStream;

  int backPressCounter = 0;
  int _selectedIndex = 0;

  bool isSearchTriggered;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.index;
    isSearchTriggered = false;

    _pStream = Products().streamAllProducts();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _submit(String key) {
    isSearchTriggered = true;
    setState(() {
      _pStream = Products().searchByKeys(key);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = Size((MediaQuery.of(context).size.width / 2), 100);

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: appBar(context),
        backgroundColor: CustomColors.lightGrey,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, addProductRoute);
          },
          label: Text("ADD"),
          icon: Icon(Icons.add),
        ),
        body: SingleChildScrollView(
          child: _selectedIndex == 0
              ? Container(
                  child: Column(children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width - 30,
                        decoration: BoxDecoration(
                            color: CustomColors.lightGrey,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: CustomColors.grey,
                                blurRadius: 10.0,
                                spreadRadius: 1.0,
                              )
                            ]),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: InkWell(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => SearchAppBar(2, ''),
                              //     settings: RouteSettings(name: '/search/product'),
                              //   ),
                              // );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(3.0),
                                  decoration: BoxDecoration(
                                      color: CustomColors.black,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: CustomColors.black)),
                                  child: Icon(
                                    Icons.search,
                                    size: 15,
                                    color: CustomColors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: _searchController,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.search,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    style: TextStyle(
                                      color: CustomColors.black,
                                    ),
                                    onChanged: (searchKey) {
                                      if (searchKey.trim().isNotEmpty &&
                                          searchKey.trim().length >= 3) {
                                        _submit(searchKey);
                                      }
                                    },
                                    onFieldSubmitted: (searchKey) {
                                      if (searchKey.trim().isNotEmpty) {
                                        _submit(searchKey);
                                      }
                                    },
                                    decoration: InputDecoration(
                                      suffixIcon: InkWell(
                                        onTap: () {
                                          if (isSearchTriggered) {
                                            _searchController.text = '';
                                            isSearchTriggered = false;
                                            setState(() {
                                              _pStream = Products()
                                                  .streamAllProducts();
                                            });
                                          }
                                        },
                                        child: Icon(Icons.clear),
                                      ),
                                      border: InputBorder.none,
                                      hintText: "Search for Products",
                                      hintStyle:
                                          TextStyle(color: CustomColors.grey),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    _getProducts(),
                  ]),
                )
              : SettingsHome(),
        ),
        bottomNavigationBar: Container(
          height: 60,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [CustomColors.white, CustomColors.green],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox.fromSize(
                size: size,
                child: InkWell(
                  onTap: () {
                    _pStream = Products().streamAllProducts();
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
                        color: CustomColors.black,
                      ),
                      Text("Home", style: GoogleFonts.orienta()),
                    ],
                  ),
                ),
              ),
              SizedBox.fromSize(
                size: size,
                child: InkWell(
                  onTap: () {
                    _onItemTapped(4);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.settings,
                        size: 22.0,
                        color: CustomColors.black,
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        "Settings",
                        style: GoogleFonts.orienta(),
                      ),
                    ],
                  ),
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
      stream: _pStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        Widget child;

        if (snapshot.hasData) {
          if (snapshot.data.docs.length == 0) {
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
              child: ListView.separated(
                shrinkWrap: true,
                primary: false,
                itemCount: snapshot.data.docs.length,
                separatorBuilder: (BuildContext context, int index) => Divider(
                  color: CustomColors.black,
                ),
                itemBuilder: (BuildContext context, int index) {
                  Products _p =
                      Products.fromJson(snapshot.data.docs[index].data());

                  return Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    child: _getProductBody(_p),
                    actions: <Widget>[
                      IconSlideAction(
                        caption: 'Edit',
                        color: Colors.indigo,
                        icon: Icons.edit,
                        onTap: () => Navigator.pushNamed(
                            context, editProductRoute,
                            arguments: _p),
                      ),
                    ],
                    secondaryActions: <Widget>[
                      IconSlideAction(
                          caption: 'Remove',
                          color: Colors.red[400],
                          icon: Icons.delete_forever,
                          onTap: () async {
                            await _p.remove();
                          }),
                    ],
                  );
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

  Widget _getProductBody(Products _p) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 5, 10, 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              _p.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: CustomColors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 2.0),
          _p.businessName.isNotEmpty
              ? Text(
                  _p.businessName ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: CustomColors.black,
                    fontSize: 12.0,
                  ),
                )
              : Container(),
          Text(
            'Quantity :  ${_p.quantity}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: CustomColors.black,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}

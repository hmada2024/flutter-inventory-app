import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greenland_stock/screens/app/appBar.dart';
import 'package:greenland_stock/screens/settings/SettingsHome.dart';
import 'package:greenland_stock/screens/utils/CustomColors.dart';

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

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.index;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _submit(String key) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = Size((MediaQuery.of(context).size.width / 2), 100);

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: appBar(context),
        backgroundColor: CustomColors.lightGrey,
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
                                    onFieldSubmitted: (searchKey) {
                                      if (searchKey.trim().isNotEmpty) {
                                        _submit(searchKey);
                                      }
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Search for Products",
                                      hintStyle:
                                          TextStyle(color: CustomColors.grey),
                                    ),
                                  ),
                                )
                                // Text(
                                //   "Search for Products",
                                //   style:
                                //       TextStyle(fontSize: 16, color: Colors.grey),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
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
}

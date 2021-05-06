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
              ? Container()
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

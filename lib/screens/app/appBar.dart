import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:greenland_stock/screens/utils/CustomColors.dart';

Widget appBar(BuildContext context) {
  return PreferredSize(
    child: Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Builder(
                      builder: (context) => InkWell(
                        onTap: () => Scaffold.of(context).openDrawer(),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8.0, top: 2),
                          child: Container(
                            padding: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color: CustomColors.black,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.menu,
                              size: 15.0,
                              color: CustomColors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            "FC Mart",
                            style: TextStyle(
                                fontFamily: "OLED",
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      child: Padding(
                        padding: EdgeInsets.only(right: 13.0, left: 8, top: 5),
                        child: Icon(
                          FontAwesomeIcons.shoppingCart,
                          size: 20.0,
                          color: CustomColors.black,
                        ),
                      ),
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => ShoppingCartScreen(),
                        //     settings: RouteSettings(name: '/cart'),
                        //   ),
                        // );
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
          Positioned(
              left: 20,
              bottom: 10,
              child: Container(
                height: 45,
                width: MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                    color: CustomColors.lightGrey,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      bottomLeft: Radius.circular(15.0),
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
                              border: Border.all(color: CustomColors.black)),
                          child: Icon(
                            Icons.search,
                            size: 15,
                            color: CustomColors.white,
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          "Search for Products",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ))
        ],
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [CustomColors.green, CustomColors.lightGrey],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    ),
    preferredSize: Size(MediaQuery.of(context).size.width, 100.0),
  );
}

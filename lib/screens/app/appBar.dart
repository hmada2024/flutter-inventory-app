import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:greenland_stock/screens/utils/CustomColors.dart';

Widget appBar(BuildContext context) {
  return PreferredSize(
    child: Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10),
      child: Padding(
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
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: CustomColors.lightGrey,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(
                          Icons.person,
                          size: 25.0,
                          color: CustomColors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "FC Stock",
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
                      Icons.notifications_active,
                      size: 25.0,
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
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [CustomColors.green, CustomColors.lightGrey],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    ),
    preferredSize: Size(MediaQuery.of(context).size.width, 50.0),
  );
}

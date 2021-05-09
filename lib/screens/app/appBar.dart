import 'package:flutter/material.dart';
import 'package:greenland_stock/constants.dart';

Widget appBar(BuildContext context) {
  return AppBar(
    title: Text(app_name),
    actions: <Widget>[
      IconButton(
        icon: Icon(
          Icons.notifications_active,
          color: Colors.white,
        ),
        tooltip: 'Notification',
        onPressed: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => Noti()),
          // );
        },
      )
    ],
  );
}

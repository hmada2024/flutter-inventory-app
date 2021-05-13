import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenland_stock/constants.dart';
import 'package:greenland_stock/screens/utils/CustomColors.dart';

class SettingsHome extends StatefulWidget {
  @override
  _SettingsHomeState createState() => _SettingsHomeState();
}

class _SettingsHomeState extends State<SettingsHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          InkWell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: CustomColors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Icon(
                          Icons.person,
                          size: 35,
                          color: CustomColors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Profile Settings",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: CustomColors.black,
                    ),
                  ),
                ),
              ],
            ),
            onTap: () async {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => UserSetting(),
              //     settings: RouteSettings(name: '/settings/profile'),
              //   ),
              // );
            },
          ),
          SizedBox(height: 20.0),
          InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: SizedBox(
                      width: 60,
                      height: 60,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: SvgPicture.asset(
                          'images/store.svg',
                          height: 35.0,
                          width: 35.0,
                          allowDrawingOutsideViewBox: true,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Store Settings",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: CustomColors.black,
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () => Navigator.pushNamed(context, businessSettingsRoute)),
        ],
      ),
    );
  }
}

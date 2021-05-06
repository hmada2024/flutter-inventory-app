import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:greenland_stock/constants.dart';
import 'package:greenland_stock/screens/utils/CustomColors.dart';
import 'package:greenland_stock/screens/utils/url_launcher_utils.dart';

class SettingsHome extends StatefulWidget {
  @override
  _SettingsHomeState createState() => _SettingsHomeState();
}

class _SettingsHomeState extends State<SettingsHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(top: 10),
          child: ListView(
            children: <Widget>[
              Divider(
                color: CustomColors.green,
                thickness: 2.0,
                height: 1,
              ),
              InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: 85,
                            height: 80,
                            decoration: BoxDecoration(
                                color: CustomColors.green,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(40),
                                    bottomRight: Radius.circular(40))),
                          ),
                          Positioned(
                            top: 10,
                            left: 10,
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
                        ],
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
              Divider(
                color: CustomColors.green,
                thickness: 2.0,
                height: 1,
              ),
              InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: 85,
                            height: 80,
                            decoration: BoxDecoration(
                                color: CustomColors.green,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(40),
                                    bottomRight: Radius.circular(40))),
                          ),
                          Positioned(
                            top: 10,
                            left: 10,
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
                                    Icons.account_balance_wallet,
                                    size: 35,
                                    color: CustomColors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "User Wallet",
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
                  //     builder: (context) => WalletHome(),
                  //     settings: RouteSettings(name: '/settings/wallet'),
                  //   ),
                  // );
                },
              ),
              Divider(
                color: CustomColors.green,
                thickness: 2.0,
                height: 1,
              ),
              InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: 85,
                            height: 80,
                            decoration: BoxDecoration(
                                color: CustomColors.green,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(40),
                                    bottomRight: Radius.circular(40))),
                          ),
                          Positioned(
                            top: 10,
                            left: 10,
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
                                  child: ClipRRect(
                                    child: Image.asset(
                                      "images/logo.png",
                                      height: 50,
                                      width: 50,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        app_name,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: CustomColors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: () async {
                  UrlLauncherUtils.launchURL(chipchop_website);
                },
              ),
              Divider(
                color: CustomColors.green,
                thickness: 2.0,
                height: 1,
              ),
              InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: 85,
                            height: 80,
                            decoration: BoxDecoration(
                              color: CustomColors.green,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(40),
                                bottomRight: Radius.circular(40),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            left: 10,
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
                                    FontAwesomeIcons.infoCircle,
                                    size: 35,
                                    color: CustomColors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "FAQs",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: CustomColors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: () async {
                  UrlLauncherUtils.launchURL(chipchop_faq_url);
                },
              ),
              Divider(
                color: CustomColors.green,
                thickness: 2.0,
                height: 1,
              ),
            ],
          ),
    );
  }
}

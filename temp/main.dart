import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'addproduct.dart';
import 'noti.dart';

// void main() {
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'GreenLand Stock'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.index}) : super(key: key);
  final String title;

  final int index;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications_none,
              color: Colors.white,
            ),
            tooltip: 'Notification',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Noti()),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _selectedIndex == 0 ? HomeContent() : Profile(),
            ],
          ),
        ),
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddProduct()),
                );
              },
              tooltip: 'Add Items',
              child: Icon(Icons.add),
            )
          : SizedBox(),

      bottomNavigationBar: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.50,
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
                      color: Colors.green,
                    ),
                    Text(
                      "Home",
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.50,
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
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class StoreTile extends StatelessWidget {
  final Function onTap;
  final String name;
  final String desc;
  final String quantity;

  const StoreTile({Key key, this.onTap, this.name, this.desc, this.quantity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(1, 1),
            ),
          ],
        ),
        child: ListTile(
            title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/store.svg',
                      height: 35.0,
                      width: 35.0,
                      allowDrawingOutsideViewBox: true,
                    ),
                    SizedBox(width: 22),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    child: Text(name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 18.0,
                                        )),
                                  ),
                                  SizedBox(height: 7),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    child: Text(desc,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 15.0,
                                        )),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ]),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.20,
                  child: Text(quantity,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                      )),
                ),
              ],
            ),
            SizedBox(height: 10),
            Divider(
              height: 1,
            )
          ],
        )),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StoreTile(
              name: 'Rice',
              desc: 'description',
              quantity: '100',
            ),
            StoreTile(
              name: 'Rice',
              desc: 'description',
              quantity: '100',
            ),
            StoreTile(
              name: 'Rice',
              desc: 'description',
              quantity: '100',
            ),
            StoreTile(
              name: 'Rice',
              desc: 'description',
              quantity: '100',
            ),
            StoreTile(
              name: 'Rice',
              desc: 'description',
              quantity: '100',
            ),
            StoreTile(
              name: 'Rice',
              desc: 'description',
              quantity: '100',
            ),
            StoreTile(
              name: 'Rice',
              desc: 'description',
              quantity: '100',
            ),
            StoreTile(
              name: 'Rice',
              desc: 'description',
              quantity: '100',
            ),
            StoreTile(
              name: 'Rice',
              desc: 'description',
              quantity: '100',
            ),
            StoreTile(
              name: 'Rice',
              desc: 'description',
              quantity: '100',
            ),
            StoreTile(
              name: 'Rice',
              desc: 'description',
              quantity: '100',
            ),
            StoreTile(
              name: 'Rice',
              desc: 'description',
              quantity: '100',
            ),
          ],
        ),
      ),
    );
  }
}

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Profile"),
            SizedBox(
              height: 20,
            ),
            ListTile(
                title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.35,
                                        child: Text("Name",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 18.0,
                                            )),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ]),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.20,
                      child: Text("FC Stock",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.0,
                          )),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Divider(
                  height: 1,
                )
              ],
            )),
            ListTile(
                title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.35,
                                        child: Text("Phone Number",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 18.0,
                                            )),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ]),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.20,
                      child: Text("1234567890",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.0,
                          )),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Divider(
                  height: 1,
                )
              ],
            )),
            ListTile(
                title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.35,
                                        child: Text("Logout",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 18.0,
                                            )),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ]),
                      ],
                    ),
                  ],
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}

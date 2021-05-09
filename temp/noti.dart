import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Noti extends StatefulWidget {
  @override
  _NotiState createState() => _NotiState();
}

class _NotiState extends State<Noti> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("GreenLand Stock"),
        leading: InkWell(
          child: Icon(Icons.arrow_back_ios),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0, bottom: 20),
                    child: Text(
                      "Notification",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black38),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: Column(
                      children: [
                        StoreTile(
                          name: 'Rice',
                          desc: 'description',
                        ),
                        StoreTile(
                          name: 'Rice',
                          desc: 'description',
                        ),
                        StoreTile(
                          name: 'Rice',
                          desc: 'description',
                        ),
                        StoreTile(
                          name: 'Rice',
                          desc: 'description',
                        ),
                        StoreTile(
                          name: 'Rice',
                          desc: 'description',
                        ),
                        StoreTile(
                          name: 'Rice',
                          desc: 'description',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Text(name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                    )),
                              ),
                            ],
                          ),
                        ]),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.20,
                  child: Text("Out of stock",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.red,
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

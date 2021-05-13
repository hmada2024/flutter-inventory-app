import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenland_stock/db/business.dart';
import 'package:greenland_stock/screens/app/appBar.dart';
import 'package:greenland_stock/screens/utils/AddBusinessWidget.dart';
import 'package:greenland_stock/screens/utils/AsyncWidgets.dart';
import 'package:greenland_stock/screens/utils/CustomColors.dart';
import 'package:greenland_stock/services/user_service.dart';

class BusinessSettings extends StatefulWidget {
  @override
  _BusinessSettingsState createState() => _BusinessSettingsState();
}

class _BusinessSettingsState extends State<BusinessSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      floatingActionButton: AddBusinessWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
          child: Container(
        child: getStores(context),
      )),
    );
  }

  Widget getStores(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Business().streamForUser(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        Widget children;

        if (snapshot.hasData) {
          if (snapshot.data.docs.isNotEmpty) {
            children = ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              primary: false,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int index) {
                Business store =
                    Business.fromJson(snapshot.data.docs[index].data());
                return Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.20,
                  child: Container(
                    height: 100,
                    child: _getBusinessBody(store),
                  ),
                  actions: <Widget>[
                    IconSlideAction(
                        caption: 'Edit',
                        color: Colors.blue,
                        icon: Icons.edit,
                        onTap: () {}),
                  ],
                  secondaryActions: <Widget>[
                    IconSlideAction(
                        caption: 'Remove',
                        color: Colors.red,
                        icon: Icons.delete_forever,
                        onTap: () {}),
                  ],
                );
              },
            );
          } else {
            children = Center(
              child: Container(
                height: 90,
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Text(
                      "Hey, Yet No Business has been Added !!",
                      style: TextStyle(
                        color: CustomColors.alertRed,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    Text(
                      "Add your Business Now!",
                      style: TextStyle(
                        color: CustomColors.blue,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Spacer(),
                  ],
                ),
              ),
            );
          }
        } else if (snapshot.hasError) {
          children = Center(
            child: Column(
              children: AsyncWidgets.asyncError(),
            ),
          );
        } else {
          children = Center(
            child: Column(
              children: AsyncWidgets.asyncWaiting(),
            ),
          );
        }

        return children;
      },
    );
  }

  Widget _getBusinessBody(Business store) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 5),
            SvgPicture.asset(
              'images/store.svg',
              height: 35.0,
              width: 35.0,
              allowDrawingOutsideViewBox: true,
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      store.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: CustomColors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          "${store.ownedBy}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: CustomColors.black,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          await cachedLocalUser.updatePrimary(store.uuid);

                          setState(() {});
                        },
                        child: Text(
                          cachedLocalUser.primaryBusiness == store.uuid
                              ? "Primary Store"
                              : "Set As Primary",
                          style: TextStyle(
                            color: cachedLocalUser.primaryBusiness == store.uuid
                                ? Colors.green
                                : CustomColors.blue,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

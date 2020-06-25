import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gmfashions/layouts/profile/settings_screen.dart';
import 'package:gmfashions/profile_screen.dart';
import 'package:gmfashions/utils/colors.dart';
import 'package:gmfashions/utils/styles.dart';
import 'package:gmfashions/utils/utils.dart';
import 'package:gmfashions/utils/scale_aware/flutter_scale_aware.dart';

import 'dashboard_drawer_activity.dart';

class DashboardDrawer extends StatefulWidget {
  final bool isUserNull;

  DashboardDrawer({Key key, this.isUserNull}) : super(key: key);

  @override
  _DashboardDrawerState createState() => _DashboardDrawerState();
}

class _DashboardDrawerState extends DrawerActivity {
  @override
  void initState() {
    onInitState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
//        color: white,
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: Container(
                  height: context.scale(100),
                  child: Image.asset('images/final_logo.png')),
              decoration: BoxDecoration(color: white),
              accountName: widget.isUserNull
                  ? Text(
                      'Login / Register',
                      style: headingTxt(16, context, color: black),
                    )
                  : StreamBuilder<String>(
                    stream: usernameCntlr.stream,
                    initialData: '',
                    builder: (context, snapshot) {
                      return Text(
                          'Hi, ${snapshot.data}' ?? '',
                          style: headingTxt(16, context, color: red1),
                        );
                    }
                  ),
              accountEmail: widget.isUserNull
                  ? Text('')
                  :StreamBuilder<String>(
                  stream: emailCntlr.stream,
                  initialData: '',
                  builder: (context, snapshot) {
                    return Text(
                      '${snapshot.data}' ?? '',
                      style: headingTxt(14, context, color: black),
                    );
                  }
              )

            ),
            drawerListTile(Icons.home, 'Home', () {
              Navigator.pop(context);
            }),
            drawerListTile(Icons.local_offer, 'Shop by Category', () {
              Navigator.pop(context);
              navigateCategory(context);
            }),
         widget.isUserNull?Container():   Divider(
              thickness: 2,
            ),
            widget.isUserNull
                ? Container()
                : drawerListTile(Icons.map, 'Address', () {
                    Navigator.pop(context);
                    navigateAddressScreen(context);
                  }),
//            widget.isUserNull
//                ? Container()
//                : drawerListTile(Icons.person_outline, 'Profile', () {}),
            widget.isUserNull?Container(): Divider(
              thickness: 2,
            ),
            widget.isUserNull
                ? Container()
                : drawerListTile(Icons.shopping_cart, 'Your Cart', () {
                    Navigator.pop(context);
                    navigateCartScreen(context);
                  }),
            Divider(
              thickness: 2,
            ),
            widget.isUserNull
                ? Container()
                : drawerListTile(Icons.local_shipping, 'Your Orders', () {
                    Navigator.pop(context);
                    navigateOrderHistory(context);
                  }),
            drawerListTile(Icons.refresh, 'Return History', () {}),
            drawerListTile(Icons.payment, 'Your Transactions', () {}),
            Divider(
              thickness: 2,
            ),
            widget.isUserNull
                ? Container()
                : drawerListTile(Icons.settings, 'Settings', () {
                    Navigator.pop(context);
                    navigateProfile(context);
                  }),
//                        widget.isUserNull
//                            ? Container()
//                            : drawerListTile(Icons.power_settings_new, 'Logout',
//                                () {
//                                Navigator.pop(context);
//                                logoutCustomer(context);
//                              }),
          ],
        ),
      ),
    );
  }

// dashboard drawer list tile

  ListTile drawerListTile(IconData iconData, String title, onTap) {
    return ListTile(
        leading: Icon(iconData, size: 21, color: Colors.black54),
        title: Text(title,
            style: TextStyle(
              fontSize: 16,
            )),
        onTap: onTap);
  }
}

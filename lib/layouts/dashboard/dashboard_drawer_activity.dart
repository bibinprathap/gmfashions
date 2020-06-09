import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gmfashions/layouts/address_list/address_list_screen.dart';
import 'package:gmfashions/layouts/cart_list/cart_list_screen.dart';
import 'package:gmfashions/layouts/category_list_view/category_list_view_screen.dart';
import 'package:gmfashions/layouts/order_list/order_list_screen.dart';
import 'package:gmfashions/layouts/profile/profile_screen.dart';
import 'package:gmfashions/utils/sp_keys.dart';
import 'package:gmfashions/utils/styles.dart';
import 'package:gmfashions/utils/utils.dart';

import '../../main.dart';
import 'dashboard_drawer.dart';

abstract class DrawerActivity extends State<DashboardDrawer> {
  String username,email;

  final usernameCntlr = StreamController<String>();
  final emailCntlr = StreamController<String>();

  onInitState()async{
     username = await Keys.storage.read(key: Keys.fName);
     email = await Keys.storage.read(key: Keys.emailID);
     print('name - $username , email - $email');
     usernameCntlr.add(username);
     emailCntlr.add(email);

  }

  logoutCustomer(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return showCustomDialog(
            context: context,
            title: 'Warning!',
            content: 'Are you sure want to Logout?',
            onPressed: () {
              Keys.clearAll();
              Navigator.pop(context);
              //  push(context: context, pushReplacement: true, toWidget: MyApp());
              RestartWidget.restartApp(context);
            },
          );
        });
  }

  navigateOrderHistory(BuildContext context) {
    push(context: context, pushReplacement: false, toWidget: OrderListScreen());
  }

  navigateCategory(BuildContext context) {
    push(context: context, pushReplacement: false, toWidget: CategoryListViewScreen(isUserNull: widget.isUserNull,));
  }

  navigateCartScreen(BuildContext context){
    push(
        context: context,
        pushReplacement: false,
        toWidget: CartListScreen());

  }

  void navigateAddressScreen(BuildContext context) {

    push(context: context, pushReplacement: false, toWidget: AddressListScreen(isDrawer: true,));
  }


  void navigateProfile(BuildContext context) {
    push(context: context, pushReplacement: false, toWidget: ProfileScreen());
  }


}

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmfashions/layouts/changepassword/change_password_screen.dart';
import 'package:gmfashions/layouts/editprofile/edit_profile_screen.dart';
import 'package:gmfashions/layouts/profile/settings_screen.dart';
import 'package:gmfashions/utils/sp_keys.dart';
import 'package:gmfashions/utils/utils.dart';

import '../../main.dart';

enum ProfilePageState{IDLE,LOADING}

abstract class SettingsScreenActivity extends State<SettingsScreen> {

  StreamController<ProfilePageState> profileCtr = StreamController<ProfilePageState>();

  logoutCustomer(BuildContext context) async {
    showDialog(
        barrierDismissible: false,
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


  void navigateEditProfile(BuildContext context) {
    push(
        context: context,
        pushReplacement: false,
        toWidget: EditProfileScreen());
  }

  void navigateChangePass(BuildContext context) {
    push(
        context: context,
        pushReplacement: false,
        toWidget: ChangePasswordScreen());
  }

}

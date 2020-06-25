import 'package:flutter/material.dart';
import 'package:gmfashions/layouts/changepassword/change_password_screen.dart';
import 'package:gmfashions/layouts/editprofile/edit_profile_screen.dart';
import 'package:gmfashions/layouts/profile/settings_screen_activity.dart';
import 'package:gmfashions/utils/colors.dart';
import 'package:gmfashions/utils/styles.dart';
import 'package:gmfashions/utils/utils.dart';
import 'package:gmfashions/utils/scale_aware/flutter_scale_aware.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends SettingsScreenActivity {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        elevation: 0,
        backgroundColor: white,
        title: Text(
          'Settings',
          style: TextStyle(color: black, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            profileListTile(Icons.perm_identity, 'Edit Profile', () {
              navigateEditProfile(context);
            }),
            Divider(),
            profileListTile(Icons.vpn_key, 'Change Password', () {
              navigateChangePass(context);
            }),
            Divider(),
            profileListTile(Icons.power_settings_new, 'Logout', () {
              logoutCustomer(context);
            }),
          ],
        ),
        width: double.infinity,
      ),
    );
  }

  Container profileImageRow(BuildContext context) {
    return Container(
        child: Row(
      children: <Widget>[
        CircleAvatar(
          backgroundImage: AssetImage('images/profile.jpeg'),
          radius: 40,
        ),
        SizedBox(
          width: context.scale(20),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Sigma',
              style: TextStyle(
                  fontSize: context.fontScale(16), fontWeight: FontWeight.bold),
            ),
            Text(
              'sigma@gmail.com',
              style: TextStyle(fontSize: context.fontScale(14), color: grey),
            ),
          ],
        ),
      ],
    ));
  }

  ListTile profileListTile(IconData iconData, String title, onTapped) {
    return ListTile(
      onTap: onTapped,
      leading: Icon(iconData),
      title: Text(title,
          style: TextStyle(
            fontSize: 16,
          )),
      trailing: Icon(Icons.chevron_right),
    );
  }
}

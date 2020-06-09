import 'package:flutter/material.dart';
import 'package:gmfashions/utils/colors.dart';
import 'package:gmfashions/utils/styles.dart';
import 'package:gmfashions/utils/utils.dart';

import 'change_password_activity.dart';
import 'package:gmfashions/utils/scale_aware/flutter_scale_aware.dart';

class ChangePasswordScreen extends StatefulWidget {
  ChangePasswordScreen({Key key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ChangePasswordActivity {
  @override
  void initState() {
    onInitState();
    super.initState();
  }

  @override
  void dispose() {
    onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        elevation: 0,
        backgroundColor: white,
//        title: Text(
//          'Change Password',
//          style: TextStyle(color: black, fontSize: 18),
//        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 18, right: 18),
        height: context.scale(600),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Change Password',
                    style: headingTxt(
                      22,
                      context,
                      fontWeight: FontWeight.w700,
                    )),
                SizedBox(
                  height: context.scale(5),
                ),
                passwordContainer(),
                newPasswordContainer(),
                confirmPasswordContainer(),
                SizedBox(
                  height: context.scale(20),
                ),
                changePassBtn(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // change password btn

  SizedBox changePassBtn() {
    return SizedBox(
        width: double.infinity,
        child: RaisedButton(
            elevation: 3,
            onPressed: () {
              changePassword();
            },
            child: Text(
              'Change Password',
              style: btnTxt,
            ),
            color: orange,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))));
  }

// TextFields for passwords

  Container passwordContainer() {
    return Container(
      margin: EdgeInsets.only(top: 13),
      child: StreamBuilder<bool>(
          initialData: true,
          stream: oldPassCntlr.stream,
          builder: (context, snapshot) {
            return TextFormField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: snapshot.data,
              validator: (val) {
                if (val.isEmpty) {
                  return 'Please Enter Your Old Password';
                }
                return null;
              },
              onSaved: (val) {
                oldPasswordCtr.text = val;
              },
              style: inputFieldPasswordTextStyle,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    toggleOldPassword(snapshot.data);
                  },
                  icon: snapshot.data
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                ),
                hintText: 'Old Password',
                hintStyle: inputFieldHintPaswordTextStyle,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              ),
            );
          }),
    );
  }

  Widget newPasswordContainer() {
    return StreamBuilder<bool>(
        stream: newPassCntlr.stream,
        initialData: true,
        builder: (context, snapshot) {
          return Container(
            margin: EdgeInsets.only(top: 13),
            child: TextFormField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: snapshot.data,
              validator: (val) {
                if (val.isEmpty) {
                  return 'Please Enter Your New Password';
                } else if (passwordCtr.text != confirmPasswordCtr.text) {
                  return 'Password Doesn\'t Match';
                }
                return null;
              },
              onSaved: (val) {
                passwordCtr.text = val;
              },
              style: inputFieldPasswordTextStyle,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    toggleNewPassword(snapshot.data);
                  },
                  icon: snapshot.data
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                ),
                hintText: 'New Password',
                hintStyle: inputFieldHintPaswordTextStyle,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              ),
            ),
          );
        });
  }

  Widget confirmPasswordContainer() {
    return StreamBuilder<bool>(
        stream: confirmPassCntlr.stream,
        initialData: true,
        builder: (context, snapshot) {
          return Container(
            margin: EdgeInsets.only(top: 13),
            child: TextFormField(
              keyboardType: TextInputType.visiblePassword,
              validator: (val) {
                if (val.isEmpty) {
                  return 'Please Enter Your Confirm Password';
                } else if (passwordCtr.text != confirmPasswordCtr.text) {
                  return 'Password Doesn\'t Match';
                }
                return null;
              },
              onSaved: (val) {
                confirmPasswordCtr.text = val;
              },
              style: inputFieldPasswordTextStyle,
              obscureText: snapshot.data,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    toggleConfirmPassword(snapshot.data);
                  },
                  icon:
                      snapshot.data ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                ),
                hintText: 'Confirm Password',
                hintStyle: inputFieldHintPaswordTextStyle,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              ),
            ),
          );
        });
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmfashions/layouts/dashboard/dashboard_screen.dart';
import 'package:gmfashions/utils/colors.dart';
import 'package:gmfashions/utils/styles.dart';
import 'package:gmfashions/utils/utils.dart';
import 'package:gmfashions/utils/scale_aware/flutter_scale_aware.dart';
import 'package:gmfashions/layouts/register/register_screen.dart';
import 'package:gmfashions/widgets/server_error_widget.dart';

import 'login_activity.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends LoginActivity {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      key:  scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: white,
          actions: <Widget>[
            FlatButton(
              onPressed: () {
               navigateRegister(context);
              },
              child: Text(
                'Sign Up',
//                style: contrastText,
              ),
            )
          ],
        ),
        body: StreamBuilder<LoginPageState>(
          stream: loginController.stream,
          initialData: LoginPageState.IDLE,
          builder: (context, snapshot) {
            switch(snapshot.data){
              case LoginPageState.IDLE:
                return loginPageIdleState(context);
                break;
              case LoginPageState.LOADING:
                return loadingPageState();
                break;
//              case LoginPageState.SUCCESS:
//                return AlertDialog(title: Text(''),)
//                break;
              case LoginPageState.ERROR:
               return ServerErrorWidget();
                break;
              default :
                return loadingPageState();
                break;
            }

          }
        ));
  }


// submit btn

  Widget loginBtn(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: RaisedButton(
          elevation: 3,
          onPressed: () {
            signIn(context);
          },
          child: Text(
            'Log in',
            style: btnTxt,
          ),
          color: orange,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ));
  }
// loading state

  Center loadingPageState() {
    return Center(child: CircularProgressIndicator(),);
  }
// idle state

  Widget loginPageIdleState(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        padding: EdgeInsets.only(left: 18, right: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Welcome Back!',
                style: headingTxt(
                  22,
                  context,
                  fontWeight: FontWeight.w700,
                )),
            SizedBox(
              height: context.scale(5),
            ),
            Text('Log back into your account', style: headingTxt(14, context,color: Colors.black87)),
            SizedBox(
              height: context.scale(15),
            ),
            emailField(),
            passwordField(),
            SizedBox(
              height: context.scale(10),
            ),
            switcherRow(context),
            loginBtn(context)
          ],
        ),
        height: context.scale(600),
        width: double.infinity,
      ),
    );
  }

// Switcher

  Widget switcherRow(BuildContext context) {
    return Row(
      children: <Widget>[
        CupertinoSwitch(
          activeColor: orange,
          onChanged: (val) {
            switcherChange(val);
          },
          value: isChange,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          'Show Password',
          style: headingTxt(14, context),
        ),
        Spacer(),
        FlatButton(child: Text('Forgot?',style: headingTxt(14, context)),onPressed: (){},)
      ],
    );
  }

  //password

  Widget passwordField() {
    return StreamBuilder<bool>(
      stream: obscureCntlr.stream,
      initialData: true,
      builder: (context, snapshot) {
        return Container(
          margin: EdgeInsets.only(top: 13),
          child: TextFormField(
            keyboardType: TextInputType.visiblePassword,
            obscureText: snapshot.data,
            validator: (val) {
              if (val.isEmpty) {
                return 'Please Enter Your Password';
              }
              return null;
            },
            onSaved: (val) {
              password = val;
              print('$password');
            },
            style: inputFieldPasswordTextStyle,
            decoration: InputDecoration(
              hintText: 'Password',
              suffixIcon: IconButton(
                onPressed: (){
                  togglePassword(snapshot.data);

                },
                icon: snapshot.data ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
              ),
              hintStyle: inputFieldHintPaswordTextStyle,
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            ),
          ),
        );
      }
    );
  }

// Email
  Container emailField() {
    return Container(
      margin: EdgeInsets.only(top: 13),
      child: TextFormField(
        validator: (val) {
          if (val.isEmpty) {
            return 'Please Enter Your Email';
          }
          return null;
        },
        onSaved: (val) {
          email = val;
          print('$email');
        },
        style: inputFieldPasswordTextStyle,
        decoration: InputDecoration(
          hintText: 'Your Email',
          hintStyle: inputFieldHintTextStyle,
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        ),
      ),
    );
  }
}

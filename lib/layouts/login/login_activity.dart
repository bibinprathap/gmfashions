import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gmfashions/api/models/login_response_model.dart';
import 'package:gmfashions/api/repository.dart';
import 'package:gmfashions/layouts/dashboard/dashboard_screen.dart';
import 'package:gmfashions/layouts/register/register_screen.dart';
import 'package:gmfashions/main.dart';
import 'package:gmfashions/utils/colors.dart';
import 'package:gmfashions/utils/sp_keys.dart';
import 'package:gmfashions/utils/utils.dart';
import 'package:gmfashions/utils/scale_aware/flutter_scale_aware.dart';


import 'login_screen.dart';

enum LoginPageState { IDLE, LOADING, SUCCESS, ERROR }

enum SwitcherChangeState { IDLE, LOADING }

abstract class LoginActivity extends State<LoginScreen> {
  String email, password;

  bool isChange = false;


  // formKey

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final storage = FlutterSecureStorage();

  StreamController<LoginPageState> loginController =
      StreamController<LoginPageState>.broadcast();
  final obscureCntlr = StreamController<bool>.broadcast();

//  StreamController<SwitcherChangeState> switchCtr = StreamController<SwitcherChangeState>();
  void navigateRegister(BuildContext context) {
    pushPageTransition(context: context, pushReplacement: true, toWidget: RegisterScreen());
  }

// switch change

  switcherChange(bool val) {
    //switchCtr.add(SwitcherChangeState.LOADING);
    isChange = val;
    print('isChange - $isChange');
    loginController.add(LoginPageState.IDLE);
  }

  // sign in

  signIn(BuildContext context) async {
    loginController.add(LoginPageState.LOADING);
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      LoginResponseModel model = await doLogin(email, password);
      if (model == null) {
        print('Api Error');
        loginController.add(LoginPageState.ERROR);
      } else {
        if (model.success == 1) {
          print('succees');
          String customerId = model.response[0].customerId;
          String name = model.response[0].firstname;
          print(name);
          String emailId = model.response[0].email;
          String addressId = model.response[0].addressId;
          String mobile = model.response[0].telephone;
          String password =  model.response[0].password;
          print('mobile - $mobile');
          print('addressId - $addressId');
          print('email - $emailId');
          print('id - $customerId');
          await Keys.storage.write(key: Keys.customerID, value: customerId);
          await Keys.storage.write(key: Keys.emailID, value: emailId);
          await Keys.storage.write(key: Keys.addressID, value: addressId);
          await Keys.storage.write(key: Keys.fName, value: name);
          await Keys.storage.write(key: Keys.phoneNumber, value: mobile);
          await Keys.storage.write(key: Keys.pass, value: password);
          // pushPageTransition(context: context, pushReplacement: true, toWidget: MyApp());
          RestartWidget.restartApp(context);
          loginController.add(LoginPageState.IDLE);
        } else {
          print('Invalid username & password');
          // showFlushBar(scaffoldKey.currentContext,red, 'Invalid Username & Password!',Icons.warning);
          showDialog(
              context: context,
              builder: (context) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SimpleDialog(
                      elevation: 0,
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                     // title: Text('Oops!'),
                      title: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text('Oops!',style: TextStyle(fontSize: 20),),
                          SizedBox(height: context.scale(10),),
                          Text(
                            'Sorry, that \'s not the right username & password.',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      children: <Widget>[
                        Divider(thickness: 2,),
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK',style: TextStyle(fontSize: 16),),
                          textColor: red,
                        )
                      ],
                    ),
                  ));

          loginController.add(LoginPageState.ERROR);
        }
      }
    }
    loginController.add(LoginPageState.IDLE);
  }

  togglePassword(bool val){
    val =!val;
    obscureCntlr.add(val);

  }

  submit(){

  }

}



import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmfashions/api/models/add_to_Cart_res_model.dart';
import 'package:gmfashions/api/repository.dart';
import 'package:gmfashions/layouts/register/register_screen.dart';
import 'package:gmfashions/utils/utils.dart';
import 'package:gmfashions/layouts/register/add_new_address.dart';

enum RegisterPageState{IDLE,LOADING}

abstract class RegisterActivity extends State<RegisterScreen>{
  String email,password,confirmPassword;
  bool isObscure = true;
  bool isObscure1 = true;

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  // formKey

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  StreamController<RegisterPageState> registerController = StreamController<RegisterPageState>.broadcast();

  onInitState(){

  }

  onDisposeMethod(){
    passwordController.dispose();
    confirmPassController.dispose();
  }

checkEmailID() async{
  registerController.add(RegisterPageState.LOADING);
  if(formKey.currentState.validate()){
    formKey.currentState.save();
    AddToCartResponseModel model = await checkMail(email);
    if(model != null){
      if(model.response == true){
        print('email already registered');
       scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('E-Mail Already Registered!'),));
       registerController.add(RegisterPageState.IDLE);
      }else{
        print('Add address');
       push(context: context, pushReplacement: true, toWidget: AddNewAddress(email: email,password: confirmPassController.text,));
       registerController.add(RegisterPageState.IDLE);

      }
    }else{
      print('json error');
      registerController.add(RegisterPageState.IDLE);

    }
  }
  registerController.add(RegisterPageState.IDLE);
}

  void changeObscure() {
    isObscure = !isObscure;
    registerController.add(RegisterPageState.IDLE);

  }

  void changeConfirmPasswordObscure() {
    isObscure1= !isObscure1;
    registerController.add(RegisterPageState.IDLE);

  }



}

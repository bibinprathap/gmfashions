import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'change_password_screen.dart';

enum ChangePasswordState { IDLE, LOADING, ERROR, SUCCESS }

abstract class ChangePasswordActivity extends State<ChangePasswordScreen> {
//  String oldPass = '',newPass = '',confirmPass = '';
//  bool isObscure1 = true, isObscure2 = true, isObscure3 = true;

  TextEditingController passwordCtr;
  TextEditingController oldPasswordCtr;
  TextEditingController confirmPasswordCtr;

  onInitState() {
    passwordCtr = TextEditingController();
    confirmPasswordCtr = TextEditingController();
    oldPasswordCtr = TextEditingController();
  }

  onDispose() {
    passwordCtr.dispose();
    confirmPasswordCtr.dispose();
    oldPasswordCtr.dispose();
  }

  // formKey

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  StreamController<ChangePasswordState> changePassBtnCtl =
      StreamController<ChangePasswordState>();
//  final changePassCtl = StreamController<bool>.broadcast();
  final oldPassCntlr = StreamController<bool>.broadcast();
  final newPassCntlr = StreamController<bool>.broadcast();
  final confirmPassCntlr = StreamController<bool>.broadcast();


  changePassword() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
    }
  }

  toggleOldPassword(bool val){
    val = !val;
    oldPassCntlr.add(val);
  }
  toggleNewPassword(bool val){
    val = !val;
    newPassCntlr.add(val);
  }
  toggleConfirmPassword(bool val){
    val = !val;
    confirmPassCntlr.add(val);
  }
//  oldPass() {
//    isObscure1 = !isObscure1;
//    changePassCtl.add(false);
//  }

//  newPass() {
//    isObscure2 = !isObscure2;
//    changePassCtl.add(false);
//  }

//  confirmPass() {
//    isObscure3 = !isObscure3;
//    changePassCtl.add(false);
//  }
}

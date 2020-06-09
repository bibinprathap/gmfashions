import 'package:flutter/material.dart';
import 'package:gmfashions/layouts/login/login_screen.dart';
import 'package:gmfashions/layouts/register/register_activity.dart';
import 'package:gmfashions/utils/colors.dart';
import 'package:gmfashions/utils/styles.dart';
import 'package:gmfashions/utils/scale_aware/flutter_scale_aware.dart';
import 'package:gmfashions/utils/utils.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends RegisterActivity {
@override
  void initState() {
  onInitState();
    super.initState();
  }

  @override
  void dispose() {
     onDisposeMethod();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        key: scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: white,
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                pushPageTransition(
                    context: context,
                    pushReplacement: true,
                    toWidget: LoginScreen());
              },
              child: Text(
                'Sign In',
//                style: contrastText,
              ),
            )
          ],
        ),
        body: StreamBuilder<RegisterPageState>(
            stream: registerController.stream,
            initialData: RegisterPageState.IDLE,
            builder: (context, snapshot) {
              return SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Container(
                    padding: EdgeInsets.only(left: 18, right: 18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Create account',
                            style: headingTxt(
                              22,
                              context,
                              fontWeight: FontWeight.w700,
                            )),
                        SizedBox(
                          height: context.scale(5),
                        ),
                        Text('Sign up and start shopping', style: headingTxt(14, context,color: Colors.black87)),
                        SizedBox(
                          height: context.scale(15),
                        ),
                        emailField(),
                        passwordField(),
                        confirmPasswordField(),
                        SizedBox(
                          height: context.scale(10),
                        ),
                        registerBtn()
                      ],
                    ),
                    height: context.scale(600),
                    width: double.infinity,
                  ),
                ),
              );
            }));
  }

  Widget registerBtn() {
    return StreamBuilder<RegisterPageState>(
      stream: registerController.stream,
      initialData: RegisterPageState.IDLE,
      builder: (context, snapshot) {
        switch(snapshot.data){
          case RegisterPageState.IDLE:
            return SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  elevation: 3,
                  onPressed: checkEmailID,
                  child: Text(
                    'Add Address',
                    style: btnTxt,
                  ),
                  color: orange,
                  shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ));
            break;
          case RegisterPageState.LOADING:
            return Center(child: CircularProgressIndicator(),);
            break;
          default:
            return Center(child: CircularProgressIndicator(),);

        }

      }
    );
  }

  //password

  Container passwordField() {
    return Container(
      margin: EdgeInsets.only(top: 13),
      child: TextFormField(
        controller: passwordController,
        keyboardType: TextInputType.visiblePassword,
        obscureText: isObscure,
        validator: (val) {
          if (val.isEmpty) {
            return 'Please Enter Your Password';
          }else if(passwordController.text != confirmPassController.text){
            return 'Password Doesn\'t Match';
          }
          return null;
        },
        onSaved: (val) {
          passwordController.text = val;
          print('$password');
        },
        style: inputFieldPasswordTextStyle,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(isObscure ? Icons.lock : Icons.lock_open,size: context.scale(20),),
            onPressed: (){
            changeObscure();
          },),
          hintText: 'Password',
          hintStyle: inputFieldHintPaswordTextStyle,
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        ),
      ),
    );
  }

  // confirm Password

  Container confirmPasswordField() {
    return Container(
      margin: EdgeInsets.only(top: 13),
      child: TextFormField(
        controller: confirmPassController,
        obscureText: isObscure1,
        keyboardType: TextInputType.visiblePassword,
        validator: (val) {
          if (val.isEmpty) {
            return 'Please Enter Your Confirm Password';
          }else if(passwordController.text != confirmPassController.text){
            return 'Password Doesn\'t Match';
          }
          return null;
        },
        onSaved: (val) {
          confirmPassController.text = val;
          print('$confirmPassword');
        },
        style: inputFieldPasswordTextStyle,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(isObscure1 ? Icons.lock : Icons.lock_open,size: context.scale(20),),
            onPressed: (){
              changeConfirmPasswordObscure();
            },),
          hintText: 'Confirm Password',
          hintStyle: inputFieldHintPaswordTextStyle,
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        ),
      ),
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

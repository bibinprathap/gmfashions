import 'package:flutter/material.dart';
import 'package:gmfashions/utils/colors.dart';
import 'package:gmfashions/utils/styles.dart';
import 'package:gmfashions/utils/utils.dart';

import 'edit_profile_activity.dart';
import 'package:gmfashions/utils/scale_aware/flutter_scale_aware.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends EditProfileActivity {
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
        title: Text(
          'Edit Profile',
          style: TextStyle(color: black, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<EditProfilePageState>(
          stream: editController.stream,
          initialData: EditProfilePageState.IDLE,
          builder: (context, snapshot) {
            switch (snapshot.data) {
              case EditProfilePageState.IDLE:
                return editProfileTextFields(context);
                break;
              case EditProfilePageState.LOADING:
                return Center(
                  child: CircularProgressIndicator(),
                );
                break;
              case EditProfilePageState.SUCCESS:
                return Text('success');
                break;
              case EditProfilePageState.ERROR:
                return Center(
                  child: Text('Something Wrong'),
                );
                break;
              default:
                return Text('default');
                break;
            }
          }),
    );
  }

//  common textfields
  Widget editProfileTextFields(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              initialValue: 'Sigma',
//              keyboardType: type,
              validator: (val) {
                if (val.isEmpty) {
                  return 'Please Enter Your Name';
                }
                return null;
              },
              onSaved: (val) {
                usernameCntlr.text = val;
              },
              style: inputFieldPasswordTextStyle,
              decoration: InputDecoration(
                hintText: 'Enter Name',
                hintStyle: inputFieldHintPaswordTextStyle,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              ),
            ),
            TextFormField(
              initialValue: 'sigma@gmail.com',
              keyboardType: TextInputType.emailAddress,
              validator: (val) {
                if (val.isEmpty) {
                  return 'Please Enter Your E-mail';
                }
                return null;
              },
              onSaved: (val) {
                emailCntlr.text = val;
              },
              style: inputFieldPasswordTextStyle,
              decoration: InputDecoration(
                hintText: 'Enter E-mail',
                hintStyle: inputFieldHintPaswordTextStyle,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              ),
            ),
            TextFormField(
              initialValue: '12344567',
              keyboardType: TextInputType.phone,
              validator: (val) {
                if (val.isEmpty) {
                  return 'Please Enter Your Mobile';
                }
                return null;
              },
              onSaved: (val) {
                phoneCntlr.text = val;
              },
              style: inputFieldPasswordTextStyle,
              decoration: InputDecoration(
                hintText: 'Enter Mobile',
                hintStyle: inputFieldHintPaswordTextStyle,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              ),
            ),
            TextFormField(
              initialValue: 'Salem',
              validator: (val) {
                if (val.isEmpty) {
                  return 'Please Enter Your Address';
                }
                return null;
              },
              onSaved: (val) {
                addressCntlr.text = val;
              },
              style: inputFieldPasswordTextStyle,
              decoration: InputDecoration(
                hintText: 'Enter Address',
                hintStyle: inputFieldHintPaswordTextStyle,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              ),
            ),

            SizedBox(
              height: 30,
            ),

//            Spacer(),
            submitBtn(),
            SizedBox(
              height: context.scale(10),
            )
          ],
        ),
      ),
    );
  }

// submit button for post details

  SizedBox submitBtn() {
    return SizedBox(
        width: double.infinity,
        child: RaisedButton(
          elevation: 3,
          onPressed: () {
            postEditProfile();
          },
          child: Text(
            'Save Changes',
          ),
          color: orange,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ));
  }

// profile img container

  StreamBuilder<ChangeImageState> imgPickerStreamBuilder() {
    return StreamBuilder<ChangeImageState>(
        stream: changeImgCtr.stream,
        initialData: ChangeImageState.IDLE,
        builder: (context, snapshot) {
          switch (snapshot.data) {
            case ChangeImageState.IDLE:
              return profileContainer(context);
              break;
            case ChangeImageState.LOADING:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            default:
              return Text('default');
              break;
          }
        });
  }

// profile image
  Container profileContainer(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      child: Column(
        children: <Widget>[
          Center(
            child: CircleAvatar(
              radius: img == null ? 50 : 45,
              child: img == null
                  ? Icon(Icons.photo_camera)
                  : ClipOval(child: Image(image: FileImage(img))),
            ),
          ),
          choseImageDialog(context)
        ],
      ),
    );
  }

// choose img dialog

  FlatButton choseImageDialog(BuildContext context) {
    return FlatButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  title: Text(
                    'Choose Options',
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.photo_camera),
                        title: Text('Take Photo'),
                        onTap: () {
                          Navigator.pop(context);
                          openImagePicker(true);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.image),
                        title: Text('Select from Gallery'),
                        onTap: () {
                          Navigator.pop(context);
                          openImagePicker(false);
                        },
                      ),
                    ],
                  ),
                ));
      },
      child: Text('Change Profile'),
      textColor: grey,
    );
  }

  // Textformfield

  Widget textFields(
    String hintTxt,
    String initialValue, {
    TextInputType type,
  }) {
    return SizedBox(
      width: context.scale(400),
      child: TextFormField(
        initialValue: initialValue,
        keyboardType: type,
        validator: (val) {
          if (val.isEmpty) {
            return 'Please Enter Your $hintTxt';
          }
          return null;
        },
        onSaved: (val) {
          switch (hintTxt) {
            case 'Name':
              username = val;
              print('$username');
              break;
            case 'E-mail':
              email = val;
              break;
            case 'Mobile':
              phone = val;
              break;
            case 'Address':
              address = val;
              break;
            default:
              print('default');
              break;
          }
        },
        style: inputFieldPasswordTextStyle,
        decoration: InputDecoration(
          hintText: '$hintTxt',
          hintStyle: inputFieldHintPaswordTextStyle,
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        ),
      ),
    );
  }
}

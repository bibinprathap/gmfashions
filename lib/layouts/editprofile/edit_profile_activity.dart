import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:gmfashions/utils/colors.dart';
import 'package:gmfashions/utils/utils.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'edit_profile_screen.dart';

enum EditProfilePageState { IDLE, LOADING, SUCCESS, ERROR }

enum ChangeImageState { IDLE, LOADING }

abstract class EditProfileActivity extends State<EditProfileScreen> {
  String username, email, phone, address, base64Img = '';

  TextEditingController usernameCntlr = TextEditingController();
  TextEditingController emailCntlr = TextEditingController();
  TextEditingController phoneCntlr = TextEditingController();
  TextEditingController addressCntlr = TextEditingController();

  int selectOption;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  File img;

  // edit controller

  StreamController<EditProfilePageState> editController =
      StreamController<EditProfilePageState>.broadcast();

  // image controller

  StreamController<ChangeImageState> changeImgCtr =
      StreamController<ChangeImageState>.broadcast();

  onDispose(){
    usernameCntlr.dispose();
    emailCntlr.dispose();
    phoneCntlr.dispose();
    addressCntlr.dispose();

  }



  // Image picker & cropper

  void openImagePicker(bool takePhoto) async {
    changeImgCtr.add(ChangeImageState.LOADING);
    var image = await ImagePicker.pickImage(
        source: takePhoto ? ImageSource.camera : ImageSource.gallery);
    changeImgCtr.add(ChangeImageState.IDLE);
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        cropStyle: CropStyle.circle,
        aspectRatioPresets: [CropAspectRatioPreset.square],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: orange,
            toolbarWidgetColor: white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    //  cropImage(image);
    img = croppedFile;
    changeImgCtr.add(ChangeImageState.IDLE);
    List<int> imageBytes = await img.readAsBytesSync();

    base64Img = base64Encode(imageBytes);
    changeImgCtr.add(ChangeImageState.IDLE);
  }

// Post Profile Details

  postEditProfile() {
    editController.add(EditProfilePageState.LOADING);
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      editController.add(EditProfilePageState.IDLE);
    }
    editController.add(EditProfilePageState.IDLE);
  }

// Select Radio btn option

  void selectRadioBtn(int val) {
    selectOption = val;
    changeImgCtr.add(ChangeImageState.IDLE);
  }
}

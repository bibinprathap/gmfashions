import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gmfashions/layouts/dashboard/dashboard_screen.dart';
import 'package:gmfashions/layouts/loading/loading_screen.dart';
import 'package:gmfashions/layouts/login/login_screen.dart';
import 'package:gmfashions/utils/sp_keys.dart';
import 'package:gmfashions/utils/utils.dart';

enum LoadingPageState{LOADING,ERROR}

abstract class LoadingActivity extends State<LoadingScreen>{


  StreamController<LoadingPageState> loadingCtr = StreamController<LoadingPageState>();


  final storage = FlutterSecureStorage();

  checkUser() async {
    loadingCtr.add(LoadingPageState.LOADING);
    String cId =  await storage.read(key:  Keys.customerID);
    print('cId - $cId');
    push(
        context: context,
        pushReplacement: true,
        toWidget: Dashboard(isUserNull: cId == null || cId.isEmpty));

  }


}
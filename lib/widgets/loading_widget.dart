import 'package:flutter/material.dart';
import 'package:gmfashions/utils/colors.dart';
import 'package:gmfashions/utils/scale_aware/flutter_scale_aware.dart';
import 'package:gmfashions/utils/utils.dart';

class LoadingWidget extends StatefulWidget {
  LoadingWidget({Key key}) : super(key: key);

  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'images/gm_logo.jpg',
//              height: context.scale(300),
            ),
            SizedBox(
              height: context.scale(20),
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
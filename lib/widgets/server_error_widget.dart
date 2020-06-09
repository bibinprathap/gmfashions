import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gmfashions/main.dart';
import 'package:gmfashions/utils/colors.dart';
import 'package:gmfashions/utils/sp_keys.dart';
import 'package:gmfashions/utils/utils.dart';

class ServerErrorWidget extends StatefulWidget {
  @override
  _ServerErrorWidgetState createState() => _ServerErrorWidgetState();
}

class _ServerErrorWidgetState extends State<ServerErrorWidget> {
  static final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: Text(
        'Something went Wrong!',
        textAlign: TextAlign.center,
      //  style: TextStyle(fontSize: 20),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Sorry, We\ ve had a server error. Please Try again.'),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                  textColor: black,
                  onPressed: () => SystemNavigator.pop(),
                  child: Text('Exit App')
              ),
              FlatButton(
                  textColor: red1,
                  onPressed: () => exitApp(context), child: Text('Try Again')
              ),
            ],
          )
        ],
      ),
//      actions: <Widget>[
//        FlatButton(
//            textColor: grey,
//            onPressed: () => SystemNavigator.pop(),
//            child: Text('Exit App')
//        ),
//        FlatButton(
//            textColor: grey,
//            onPressed: () => restartApp(context), child: Text('Try Again')
//        ),
//      ],
    );
  }

  void exitApp(BuildContext context) async {
//    Keys.clearAll();
    RestartWidget.restartApp(context);
  }
}

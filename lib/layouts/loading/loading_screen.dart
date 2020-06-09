import 'package:flutter/material.dart';
import 'package:gmfashions/layouts/loading/loading_activity.dart';
import 'package:gmfashions/layouts/login/login_activity.dart';
import 'package:gmfashions/widgets/server_error_widget.dart';

class LoadingScreen extends StatefulWidget {
  LoadingScreen({Key key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends LoadingActivity {
  @override
  void initState() {
    checkUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<LoadingPageState>(
          stream: loadingCtr.stream,
          initialData: LoadingPageState.LOADING,
          builder: (context, snapshot) {
            print('snap - ${snapshot.data}');
            switch (snapshot.data) {
              case LoadingPageState.LOADING:
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset(
                        'images/gm_logo.jpg',
                        height: 300,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      CircularProgressIndicator(),
                    ],
                  ),
                );
                break;
//              case LoadingPageState.ERROR:
//                return ServerErrorWidget();
//                break;
              default:
                return Center(
                  child: CircularProgressIndicator(),
                );
            }
          }),
    );
  }
}

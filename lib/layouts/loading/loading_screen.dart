import 'package:flutter/material.dart';
import 'package:gmfashions/layouts/loading/loading_activity.dart';
import 'package:gmfashions/layouts/login/login_activity.dart';
import 'package:gmfashions/utils/colors.dart';
import 'package:gmfashions/widgets/server_error_widget.dart';
import 'package:url_launcher/url_launcher.dart';

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
                return Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        colors: [red1, red],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )),
                      height: double.infinity,
                      child: Align(
                        child: sigmaText(),
                        alignment: Alignment.bottomCenter,
                      ),

                    ),
                    Positioned.fill(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 1,
                                      color: white,
                                      spreadRadius: 2


                                    ),
                                  ],
                                  shape: BoxShape.circle,
                                ),
                                child: CircleAvatar(
                                  backgroundColor: white,
                                  child: Image.asset('images/final_logo.png',width: 130,),
                                  radius: 100,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Loading... Please Wait...',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        )
                    )
,
                  ],
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
  sigmaText() {
    return GestureDetector(
      onTap: () {
        launch('http://www.sigmacomputers.in');
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RichText(
              text: TextSpan(
                  text: 'Developed by ',
                  style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
                  children: [
                    TextSpan(
                        text: ' SIGMA,Salem',
                        style: TextStyle(
                            color: Colors.blue[800],
                            fontWeight: FontWeight.bold,
                            fontSize: 16))
                  ]),
            ),
            SizedBox(width: 5,),
            Image.asset('images/sigma_logo.png',height: 30,)
          ],
        ),
      ),
    );
  }

}

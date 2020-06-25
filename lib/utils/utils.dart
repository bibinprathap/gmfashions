import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gmfashions/api/urls.dart';
import 'package:gmfashions/layouts/cart_list/cart_list_screen.dart';
import 'package:gmfashions/layouts/login/login_screen.dart';
import 'package:gmfashions/utils/colors.dart';
import 'package:gmfashions/utils/styles.dart';
import 'package:page_transition/page_transition.dart';
import 'package:gmfashions/utils/scale_aware/flutter_scale_aware.dart';

// navigate to another screen

void push(
    {@required BuildContext context,
    @required bool pushReplacement,
    @required Widget toWidget}) {
  if (pushReplacement) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => toWidget));
  } else {
    Navigator.push(context, MaterialPageRoute(builder: (context) => toWidget));
  }
}
// pagetransition

pushPageTransition(
    {@required BuildContext context,
    @required bool pushReplacement,
    @required Widget toWidget}) {
  if (pushReplacement) {
    Navigator.pushReplacement(context,
        PageTransition(type: PageTransitionType.rightToLeft, child: toWidget));
  } else {
    Navigator.push(context,
        PageTransition(type: PageTransitionType.rightToLeft, child: toWidget));
  }
}

// appbar

//AppBar appbar(BuildContext context,
//    {Widget flexibleSpace, bool visibleCart = true, String title}) {
//  return AppBar(
//    iconTheme: IconThemeData(color: black),
//    elevation: 0,
//    backgroundColor: white,
//    title: Text(
//      title,
//      style: TextStyle(color: black, fontSize: 18),
//    ),
//    centerTitle: true,
//    actions: <Widget>[
//      visibleCart
//          ? IconButton(
//              onPressed: () {
//                push(
//                    context: context,
//                    pushReplacement: false,
//                    toWidget: CartListScreen());
//              },
//              icon: Icon(
//                Icons.shopping_cart,
//                size: context.scale(25),
//              ),
//            )
//          : Container(),
////      IconButton(
////        onPressed: () {},
////        icon: Icon(Icons.menu, size: context.scale(25)),
////      )
//    ],
//    flexibleSpace: flexibleSpace,
//  );
//}

//  Image widget
Widget imageWidget(
    {String imageURL,
    double height,
    double width,
    BoxFit boxFit = BoxFit.fitWidth}) {
  return CachedNetworkImage(
    height: height,
    width: width,
    fit: boxFit,
    placeholder: (context,url)=>Center(child: CircularProgressIndicator()),
    errorWidget: (context, url, error) => Image.asset('images/gm_logo.jpg',height: 100,),
    imageUrl: imageBaseURL + imageURL,

  );
//  return ExtendedImage.network(
//    imageBaseURL + imageURL,
////        imageURL,
//    height: height,
//    fit: BoxFit.cover,
//    borderRadius: BorderRadius.circular(20),
//    loadStateChanged: (state) {
//      if (state.extendedImageLoadState == LoadState.loading) {
//        return Center(child: CircularProgressIndicator());
//      } else if (state.extendedImageLoadState == LoadState.completed) {
//        return ExtendedRawImage(
//          image: state.extendedImageInfo?.image,
//          fit: boxFit,
//        );
//      } else {
//        return Image.asset(
//          'images/gm_logo.jpg',
////          fit: BoxFit.fitWidth,
//        height: 100,
//        );
//      }
//    },
//  );
}
Column loadingWidget(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Center(child: Image.asset('images/gm_logo.jpg',width: context.scale(100),)),
      SizedBox(
        height: context.scale(10),
      ),
      Center(child: CircularProgressIndicator()),
    ],
  );
}
//Widget imageWidget({
//  String imageURL,
//  double height,
//  double width,
//}){
//  return ExtendedImage.network(
//    imageBaseURL + imageURL,
////        imageURL,
//    height: height,
//    fit: BoxFit.cover,
//    borderRadius: BorderRadius.circular(20),
//    loadStateChanged: (state) {
//      if (state.extendedImageLoadState == LoadState.loading) {
//        return Center(child: CircularProgressIndicator());
//      } else if (state.extendedImageLoadState == LoadState.completed) {
//        return ExtendedRawImage(
//          image: state.extendedImageInfo?.image,
//          fit: BoxFit.fill,
//        );
//      } else {
//        return Image.asset(
//          'images/gm_logo.jpg',
//          fit: BoxFit.contain,
//        );
//      }
//    },
//  );
//}

// flushbar

showFlushBar(BuildContext context, Color color, String title, IconData iconData,
    {Widget button}) {
  return Flushbar(
    //isDismissible: false,
    backgroundColor: color,
    flushbarPosition: FlushbarPosition.BOTTOM,
    flushbarStyle: FlushbarStyle.FLOATING,
    icon: Icon(
      iconData,
      color: white,
      size: 18,
    ),
    message: title,
    mainButton: button,
    // reverseAnimationCurve: Curves.bounceOut,
    //forwardAnimationCurve: Curves.easeInCubic,
    borderRadius: 8,
    margin: EdgeInsets.all(8),
    duration: Duration(seconds: 3),
  )..show(context);
}

// Show Dialog

Widget showCustomDialog(
    {BuildContext context, String title, String content = '', onPressed}) {
  return AlertDialog(
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),

    title: Text(
      title,
      textAlign: TextAlign.center,
      //  style: TextStyle(fontSize: 20),
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          content,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FlatButton(
                textColor: black,
                onPressed: () {
                  return Navigator.pop(context);
                },
                child: Text(
                  'No',
                  style: TextStyle(fontSize: 16),
                )),
            FlatButton(
                textColor: red1,
                onPressed: onPressed,
                child: Text('Yes', style: TextStyle(fontSize: 16))
            ),
            //          IconButton(
//            onPressed: ()=> Navigator.pop(context),
//            icon: Icon(Icons.close,color: red1,),
//          ),
//            IconButton(
//              onPressed: ()=> onPressed,
//              icon: Icon(Icons.check,color: Colors.green,),
//            ),
          ],
        ),
      ],
    ),
  );
}

Future userNullLoginDialog(BuildContext context) {
  return showDialog(
      context: context,
      barrierDismissible: false,

      builder: (context) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: SimpleDialog(
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              title: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Warning!',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: context.scale(10),
                  ),
                  Text(
                    'Please Login or Create an Account to Continue.',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              children: <Widget>[
                Divider(
                  thickness: 2,
                ),
                FlatButton(
                  textColor: red1,
                  onPressed: () {
                    Navigator.pop(context);
                    push(
                        context: context,
                        pushReplacement: false,
                        toWidget: LoginScreen());
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 16),
                  ),
                )
              ],
            ),
          ));
//  return showDialog(
//      context: context,
//      builder: (context) {
//        return showCustomDialog(
//            title: 'Warning!',
//            content:
//            'Please Login or Create an Account to Continue',
//            action: [
//              RaisedButton(
//                color: red1,
//                onPressed: () {
//                  Navigator.pop(context);
//                  push(
//                      context: context,
//                      pushReplacement: false,
//                      toWidget: LoginScreen());
//                },
//                child: Text('Login'),
//              )
//            ]);
//      });
}

//
//void draggableBottomSheet() {
//  Container(
//    child: DraggableScrollableSheet(
//      initialChildSize: 0.3,
//      minChildSize: 0.1,
//      maxChildSize: 0.8,
//      builder: (BuildContext context, myscrollController) {
//        return Container(
//          color: Colors.tealAccent[200],
//          child: ListView.builder(
//            controller: myscrollController,
//            itemCount: 25,
//            itemBuilder: (BuildContext context, int index) {
//              return ListTile(
//                  title: Text(
//                    'Dish $index',
//                    style: TextStyle(color: Colors.black54),
//                  ));
//            },
//          ),
//        );
//      },
//    ),
//  );
//}

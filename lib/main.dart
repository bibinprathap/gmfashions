import 'package:flutter/material.dart';
import 'package:gmfashions/layouts/addaddress/add_address_activity.dart';
import 'package:gmfashions/layouts/addaddress/add_address_screen.dart';
import 'package:gmfashions/layouts/cart_list/cart_list_screen.dart';
import 'package:gmfashions/layouts/changepassword/change_password_screen.dart';
import 'package:gmfashions/layouts/dashboard/dashboard_screen.dart';
import 'package:gmfashions/layouts/editAddress/edit_address_screen.dart';
import 'package:gmfashions/layouts/loading/loading_screen.dart';
import 'package:gmfashions/layouts/login/login_screen.dart';
import 'package:gmfashions/layouts/product_details/product_details.dart';
import 'package:gmfashions/layouts/product_details/product_details_activity.dart';
import 'package:gmfashions/layouts/profile/profile_screen.dart';
import 'package:gmfashions/layouts/register/register_screen.dart';
import 'package:gmfashions/layouts/sub_category/sub_category_screen.dart';
import 'package:gmfashions/profile_screen.dart';
import 'package:gmfashions/user_profile_screen.dart';
import 'package:gmfashions/utils/colors.dart';
import 'package:gmfashions/utils/scale_aware/flutter_scale_aware.dart';
import 'package:gmfashions/utils/utils.dart';
import 'package:gmfashions/widgets/draggable_bottom_sheet_widget.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(RestartWidget(child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaleAware(
      config: ScaleConfig(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: AppBarTheme(textTheme: GoogleFonts.latoTextTheme()),
            primarySwatch: red, textTheme: GoogleFonts.latoTextTheme()),
        home: LoadingScreen(),
//      home: ProfileScreen()
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(),
    );
  }
}

class RestartWidget extends StatefulWidget {
  RestartWidget({this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>().restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}

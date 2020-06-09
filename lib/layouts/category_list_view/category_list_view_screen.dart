import 'package:flutter/material.dart';
import 'package:gmfashions/layouts/cart_list/cart_list_screen.dart';
import 'package:gmfashions/layouts/dashboard/dashboard_drawer.dart';
import 'package:gmfashions/layouts/sub_category/sub_category_screen.dart';
import 'package:gmfashions/utils/colors.dart';
import 'package:gmfashions/utils/styles.dart';
import 'package:gmfashions/utils/utils.dart';
import 'package:gmfashions/utils/scale_aware/flutter_scale_aware.dart';
import 'package:gmfashions/widgets/server_error_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import 'category_list_activity.dart';

class CategoryListViewScreen extends StatefulWidget {
  final bool isUserNull;
  CategoryListViewScreen({Key key,this.isUserNull}) : super(key: key);

  @override
  _CategoryListViewScreenState createState() => _CategoryListViewScreenState();
}

class _CategoryListViewScreenState extends CategoriesActivity {
  @override
  void initState() {
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: white,
      endDrawer: DashboardDrawer(isUserNull: widget.isUserNull,),
      appBar: AppBar(
        backgroundColor: red1,
        centerTitle: true,
        title: Text('Categories',style: logoWhiteStyle(context),),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              push(
                  context: context,
                  pushReplacement: false,
                  toWidget: CartListScreen());
            },
            icon: Icon(
              Icons.shopping_cart,
              color: white,
              // size: context.scale(18),
            ),
          ),
          IconButton(
            onPressed: () {
              scaffoldKey.currentState.openEndDrawer();
            },
            icon: Icon(
              Icons.menu,
              // size: context.scale(18),
              color: white,
            ),
          ),
        ],
      ),
      body: StreamBuilder<CategoriesState>(
          stream: categoryController.stream,
          initialData: CategoriesState.LOADING,
          builder: (context, snapshot) {
            switch (snapshot.data) {
              case CategoriesState.IDLE:
                return categoryIdleState();
                break;
              case CategoriesState.LOADING:
               return loadingWidget(context);
                break;
              case CategoriesState.EMPTY:
                return Text('List Empty');
                break;
              case CategoriesState.ERROR:
                return ServerErrorWidget();
                break;
              default:
                return Center(
                  child: CircularProgressIndicator(),
                );
                break;
            }
          }),
    );
  }

  // category Idle State

  Widget categoryIdleState() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: categoryList.length,
          separatorBuilder: (context,index) => Divider(thickness: 1,),
          itemBuilder: (context, index) {
        String img = categoryList[index].image;
        String category = categoryList[index].name;
        String categoryId = categoryList[index].categoryId;
        int parent = categoryList[index].parent;
        return categoryListTileItem(context, img, category,categoryId,parent);
      }),
    );
  }

// List Tile Item

  ListTile categoryListTileItem(
      BuildContext context, String img, String category,String id,int parent) {
    return ListTile(
      trailing:  Icon(Icons.keyboard_arrow_right,color: red1,),
      onTap: () {
       navigateToSubCategory(id, category,parent);
      },
      leading: SizedBox(
          height: context.scale(80), width: context.scale(80),
        child: imageWidget(
            imageURL: img, height: context.scale(80), width: context.scale(80)),
      ),
      title: Text(
        category,
        style: headingTxt(16, context),
      ),
    );
  }
}

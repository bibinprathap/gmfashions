import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gmfashions/api/models/home_response_model.dart';
import 'package:gmfashions/api/repository.dart';
import 'package:gmfashions/layouts/category_list_view/category_list_view_screen.dart';
import 'package:gmfashions/layouts/product_details/product_details.dart';
import 'package:gmfashions/layouts/search/search_product_screen.dart';
import 'package:gmfashions/layouts/sub_category/sub_category_screen.dart';
import 'package:gmfashions/utils/utils.dart';

import '../../main.dart';
import 'dashboard_screen.dart';

enum DashboardPageState { IDLE, LOADING, EMPTY, ERROR }

enum LatestProductState { IDLE, LOADING, EMPTY, ERROR }

abstract class DashboardActivity extends State<Dashboard> {
  bool isGrid = true;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


  DateTime currentBackPressTime;


  // category , latest product list & banner list

  List<Category> categoryList = [];

  List<LatestProduct> latestProductList = [];

  List<SlideBanner> bannerList = [];

  StreamController<DashboardPageState> dashboardController =
      StreamController<DashboardPageState>.broadcast();

//  StreamController<LatestProductState> gridCtr =
//      StreamController<LatestProductState>.broadcast();

//
//
//  gridView() {
//    isGrid = !isGrid;
//    dashboardController.add(DashboardPageState.IDLE);
//  }

// Get Categories list

getDashboardList() async{
  dashboardController.add(DashboardPageState.LOADING);
  HomeResponseModel model = await homePageList();
  if (model != null) {
    if(model.response.latestProducts.isNotEmpty || model.response.slideBanner.isNotEmpty|| model.response.categories.isNotEmpty){
      categoryList = model.response.categories;
      latestProductList = model.response.latestProducts;
      bannerList = model.response.slideBanner;
      dashboardController.add(DashboardPageState.IDLE);
    }else{
      dashboardController.add(DashboardPageState.EMPTY);
    }
  } else {
    print('json decode error');
    dashboardController.add(DashboardPageState.ERROR);
  }

}
  ///navigate list view
navigateCategoryListView(){
  push(
      context: context,
      pushReplacement: false,
      toWidget: CategoryListViewScreen(isUserNull: widget.isUserNull,));
}
  ///navigate subcategory
navigateSubCategory(String cID,String category){
  push(
      context: context,
      pushReplacement: false,
      toWidget: SubCategoryScreen(
        isUserNull: widget.isUserNull,
        categoryId: cID,
        name: category,
      ));
}

///navigate product details
navigateProductDetails(String id,String product,String price){
  push(
      context: context,
      pushReplacement: false,
      toWidget: ProductDetails(
        price: price,
        productId: id,
        productName: product,
        isUserNull: widget.isUserNull,
      ));
}

///search screen
navigateSearchScreen(){
  showSearch(context: context, delegate: SearchProductScreen(isUserNull: widget.isUserNull));
}

  Future<bool> willPopCallback() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: 'Press Again to Exit ');
      return Future.value(false);
    }
    SystemNavigator.pop();
    return Future.value(true);
  }
// Get Latest product List

//getLatestProducts() async{
//  gridCtr.add(LatestProductState.LOADING);
//
//  HomeResponseModel model = await homePageList();
//  if(model != null){
//    if(model.success == 1){
//      latestProductList = model.response.latestProducts;
//      gridCtr.add(LatestProductState.IDLE);
//    }
//    else{
//      gridCtr.add(LatestProductState.ERROR);
//    }
//
//  }else{
//    gridCtr.add(LatestProductState.EMPTY);
//  }
//
//}

// Get Banner List
//
//  getBannerList()  async {
//    dashboardController.add(DashboardPageState.LOADING);
//    HomeResponseModel model = await homePageList();
//    if(model != null){
//      if(model.success == 1){
//        bannerList = model.response.slideBanner;
//        dashboardController.add(DashboardPageState.IDLE);
//      }
//      else{
//        dashboardController.add(DashboardPageState.ERROR);
//      }
//
//    }else{
//      dashboardController.add(DashboardPageState.EMPTY);
//    }
//
//  }


}

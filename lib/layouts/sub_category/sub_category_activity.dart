import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmfashions/api/models/sub_category_response_model.dart';
import 'package:gmfashions/api/repository.dart';
import 'package:gmfashions/layouts/productlist/product_list.dart';
import 'package:gmfashions/layouts/sub_category/sub_category_screen.dart';
import 'package:gmfashions/utils/utils.dart';

enum SubCategoryPageState { SUCCESS, LOADING, ERROR, EMPTY }

abstract class SubCategoryActivity extends State<SubCategoryScreen>
    with SingleTickerProviderStateMixin {
  // get subCategory list

  List<Response> response = [];

  //scaffold Key

  final scaffoldKey = GlobalKey<ScaffoldState>();

  // tabs for subCategory

  TabController tabController;

  // subCategoryController

  StreamController<SubCategoryPageState> subCategoryController =
      StreamController<SubCategoryPageState>();

  subCategoryList(String id) async {
    subCategoryController.add(SubCategoryPageState.LOADING);
    SubCategoryResponseModel model = await getSubCategory(id);
    if (model != null) {
      if (model.success == 1) {
        if (model.response.isNotEmpty) {
          response = model.response;
          subCategoryController.add(SubCategoryPageState.SUCCESS);
        } else {
          print('List Empty');
          subCategoryController.add(SubCategoryPageState.EMPTY);
        }
      } else {
        print('error');
        subCategoryController.add(SubCategoryPageState.ERROR);
      }
    } else {
      print('Json error');
      subCategoryController.add(SubCategoryPageState.ERROR);
    }
  }

  void navigateProductListScreen(
      BuildContext context, String id, String product) {
    push(
        context: context,
        pushReplacement: false,
        toWidget: ProductList(
          id: id,
          name: product,
          isUserNull: widget.isUserNull,
        ));
  }
}

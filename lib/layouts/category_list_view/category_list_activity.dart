import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmfashions/api/repository.dart';
import 'package:gmfashions/layouts/productlist/product_list.dart';
import 'package:gmfashions/layouts/sub_category/sub_category_screen.dart';
import 'package:gmfashions/utils/utils.dart';

import 'category_list_view_screen.dart';
import 'package:gmfashions/api/models/home_response_model.dart';

enum CategoriesState{IDLE,LOADING,EMPTY,ERROR}

abstract class CategoriesActivity extends State<CategoryListViewScreen>{

  final scaffoldKey = GlobalKey<ScaffoldState>();

 //  list

  List<Category> categoryList = [];

  // category Controller

  StreamController<CategoriesState> categoryController = StreamController<CategoriesState>();

  getCategories() async {
    categoryController.add(CategoriesState.LOADING);
    HomeResponseModel model = await homePageList();
    if(model != null){
      if(model.success == 1){
          if(model.success.toString().isNotEmpty){
            categoryList = model.response.categories;
            categoryController.add(CategoriesState.IDLE);
          }else{
            print('List Empty');
            categoryController.add(CategoriesState.EMPTY);

          }

      }
      else{
        print('Category Error');
        categoryController.add(CategoriesState.ERROR);
      }

    }else{
      print('Json decode Error');
      categoryController.add(CategoriesState.ERROR);
    }

  }

  navigateToSubCategory(String id,String category,int parentId){
    if(parentId == 0){
      push(
          context: context,
          pushReplacement: false,
          toWidget: ProductList(id: id,isUserNull: widget.isUserNull,name: category,));
    }else{
      push(
          context: context,
          pushReplacement: false,
          toWidget: SubCategoryScreen(categoryId: id,name: category,isUserNull: widget.isUserNull,));
    }

  }
}

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmfashions/api/models/product_list_response_model.dart';
import 'package:gmfashions/api/repository.dart';
import 'package:gmfashions/layouts/product_details/product_details.dart';
import 'package:gmfashions/layouts/productlist/product_list.dart';
import 'package:gmfashions/utils/utils.dart';

enum ProductListChangeState { SUCCESS, LOADING, EMPTY, ERROR }

abstract class ProductActivity extends State<ProductList> {
  List<Response> product = [];

  //scaffold Key

  final scaffoldKey = GlobalKey<ScaffoldState>();

  // product list Controller

  StreamController<ProductListChangeState> productListCtr =
      StreamController<ProductListChangeState>();

  getProductList(String id) async {
    productListCtr.add(ProductListChangeState.LOADING);
    ProductResponseModel model = await productList(id);
    if (model != null) {
      if (model.success == 1) {
        if (model.response.isNotEmpty) {
          product = model.response;
          productListCtr.add(ProductListChangeState.SUCCESS);
        } else {
          print('List Empty');
          productListCtr.add(ProductListChangeState.EMPTY);
        }
      } else {
        print('List error');
        productListCtr.add(ProductListChangeState.ERROR);
      }
    } else {
      print('Json Error');
      productListCtr.add(ProductListChangeState.ERROR);
    }
  }

  void navigateProductDetails(BuildContext context, String id, String product,String price) {
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
}

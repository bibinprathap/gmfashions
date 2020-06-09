import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gmfashions/api/models/search_response_model.dart';
import 'package:gmfashions/api/repository.dart';
import 'package:gmfashions/layouts/product_details/product_details.dart';
import 'package:gmfashions/utils/utils.dart';

enum SearchListChangeState { IDLE, LOADING, ERROR, EMPTY }

abstract class SearchProductActivity
    extends SearchDelegate<SearchResponseModel> {
  List<Response> searchList = [];

  StreamController<SearchListChangeState> searchCtr =
      StreamController<SearchListChangeState>.broadcast();

  // Search List

  getSearchList(String query) async {
    searchCtr.add(SearchListChangeState.LOADING);
    SearchResponseModel model = await searchProducts(query);
    if (model != null) {
      if (model.success == 1) {
        if (model.response.isNotEmpty) {
          searchList = model.response;
          searchCtr.add(SearchListChangeState.IDLE);
        } else {
          searchCtr.add(SearchListChangeState.EMPTY);
        }
      } else {
        print('Search Error');
        searchCtr.add(SearchListChangeState.ERROR);
      }
    } else {
      print('Json Error');
      searchCtr.add(SearchListChangeState.ERROR);
    }
  }

  // navigate product details

  void navigateProductDetails(BuildContext context, String product, String id,String price) {
    push(
        context: context,
        pushReplacement: false,
        toWidget: ProductDetails(
          price: price,
          productName: product,
          productId: id,
        ));
  }
}

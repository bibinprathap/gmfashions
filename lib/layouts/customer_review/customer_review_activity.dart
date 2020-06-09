import 'dart:async';


import 'package:flutter/cupertino.dart';
import 'package:gmfashions/api/models/product_details_response_model.dart';
import 'package:gmfashions/api/repository.dart';

import 'customer_review_screen.dart';

enum ReviewListState{IDLE,LOADING,EMPTY,ERROR}
abstract class CustomerReviewActivity extends  State<CustomerReviewScreen>{
  StreamController<ReviewListState> reviewCtr = StreamController<ReviewListState>();

  double rating = 0;
  List<Review> reviewList = [];

  onInitState(String id){
    customerReviewList(id);
  }

  /// rating change

  void ratingChange(double value) {
    rating = value;
  //  reviewCtr.add(ReviewListState.IDLE);
  }

  customerReviewList(String id) async {
    reviewCtr.add(ReviewListState.LOADING);
    ProductDetailResponse model = await productDetails(id);
    if (model != null) {
      if (model.response.review.isNotEmpty) {
        reviewList = model.response.review;
        reviewCtr.add(ReviewListState.IDLE);
      } else {
        print('List Empty');
        reviewCtr.add(ReviewListState.EMPTY);
      }
    } else {
      print('Json Error');
      reviewCtr.add(ReviewListState.ERROR);
    }
  }

}

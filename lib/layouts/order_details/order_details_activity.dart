import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmfashions/api/models/order_details_model.dart';
import 'package:gmfashions/api/repository.dart';

import 'order_details_screen.dart';

enum OrderDetailsChangeState { IDLE, LOADING, ERROR }

abstract class OrderDetailsActivity extends State<OrderDetailsScreen> {
  List<TotalDetail> totalList = [];
  List<ProductDetail> productList = [];
  List<Response> response = [];

  StreamController<OrderDetailsChangeState> orderCtr =
      StreamController<OrderDetailsChangeState>();

  onInitState(String orderId) {
    viewOrderDetails(orderId);
  }

  viewOrderDetails(String orderId) async {
    orderCtr.add(OrderDetailsChangeState.LOADING);
    OrderDetailsModel model = await orderDetails(orderId);
    if (model != null) {
      if (model.success == 1) {
        response = model.response;
        orderCtr.add(OrderDetailsChangeState.IDLE);
      } else {
        print('Error');
        orderCtr.add(OrderDetailsChangeState.ERROR);
      }
    } else {
      print('Json Decode Error');
      orderCtr.add(OrderDetailsChangeState.ERROR);
    }
  }

}

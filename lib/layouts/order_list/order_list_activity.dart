import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:gmfashions/api/models/order_list_model.dart';
import 'package:gmfashions/layouts/order_details/order_details_screen.dart';
import 'package:gmfashions/layouts/order_list/order_list_screen.dart';
import 'package:gmfashions/api/repository.dart';
import 'package:gmfashions/utils/utils.dart';

enum OrderListChangeState { IDLE, LOADING, ERROR, EMPTY }

abstract class OrderListActivity extends State<OrderListScreen> {
  List<Response> list = [];
  StreamController<OrderListChangeState> orderHistoryCtr =
      StreamController<OrderListChangeState>();

  ///initstate
  onInitState() {
    getOrderHistory();
  }

  ///order list
  getOrderHistory() async {
    orderHistoryCtr.add(OrderListChangeState.LOADING);
    OrderListModel model = await orderList();
    if (model != null) {
      if (model.response.isNotEmpty) {
        list = model.response;
        print('Success');
        orderHistoryCtr.add(OrderListChangeState.IDLE);
      } else {
        orderHistoryCtr.add(OrderListChangeState.EMPTY);
      }
    } else {
      print('Json Decode error');
      orderHistoryCtr.add(OrderListChangeState.ERROR);
    }
  }

  ///navigate order details
  navigateOrderDetails(
      String id, BuildContext context, DateTime date, String status) {
    push(
        context: context,
        pushReplacement: false,
        toWidget: OrderDetailsScreen(
          orderID: id,
          date: date,
          status: status,
        ));
  }
}

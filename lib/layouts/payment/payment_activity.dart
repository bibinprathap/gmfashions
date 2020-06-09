import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gmfashions/api/models/PlaceOrderModel.dart' as checkout;
import 'package:gmfashions/api/models/get_total_response_model.dart';
import 'package:gmfashions/api/repository.dart';
import 'package:gmfashions/layouts/order_details/order_details_screen.dart';
import 'package:gmfashions/layouts/payment/payment_screen.dart';
import 'package:gmfashions/utils/sp_keys.dart';
import 'package:gmfashions/utils/utils.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

enum GetTotalState { IDLE, LOADING, ERROR }

abstract class PaymentActivity extends State<PaymentScreen> {
  bool onChange = false;

  List<Response> totalList = [];

  Razorpay razorPay;

  /// total Stream
  StreamController<GetTotalState> totalCtr =
      StreamController<GetTotalState>.broadcast();

  ///place order stream
  final payBtnCtr = StreamController<bool>.broadcast();
  final netBankingSwitchCntlr = StreamController<bool>.broadcast();

  /// initstate
  onInitState() {
    getProductTotal();
    razorPay = Razorpay();
    razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  ///dispose
  onDispose() {
    razorPay.clear();
  }

  /// get total

  getProductTotal() async {
    totalCtr.add(GetTotalState.LOADING);
    GetTotalResponseModel model = await getItemTotal();
    if (model != null) {
      totalList = model.response;
      totalCtr.add(GetTotalState.IDLE);
    } else {
      print('json decode error');
      totalCtr.add(GetTotalState.ERROR);
    }
  }

  /// switch Change
  void valueChange(val) {
  onChange = val;
    netBankingSwitchCntlr.add(onChange);
  }

  /// pay button for place order
  payBtn() {
    payBtnCtr.add(true);
    double total = double.parse(totalList[0].total.toString());
    print('tot - $total');
    if (onChange) {
      paymentGateway(total);
    } else {
      Fluttertoast.showToast(msg: 'Please Select a Option', );
      payBtnCtr.add(false);
    }
  }

  ///payment success
  void handlePaymentSuccess(PaymentSuccessResponse response) {
//    checkOutOrder();
    print('Payment Success');
    payBtnCtr.add(false);
  }

  ///payment cancelled
  void handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: 'Your Payment has been Cancelled');
    print('Payment Cancelled');
    payBtnCtr.add(false);
  }

  ///payment wallet
  void handleExternalWallet(ExternalWalletResponse response) {
    print('Payment Wallet');
    payBtnCtr.add(false);
  }

  ///payment screen

  void paymentGateway(double total) async {
    String name = await storage.read(key: Keys.fName);
    String email = await storage.read(key: Keys.emailID);
    String mobile = await storage.read(key: Keys.phoneNumber);
    print('mobile - $mobile');
    print('$name,$email,$mobile');
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': getPaisa(total.toStringAsFixed(2)),
      'name': '$name.',
      'description': '',
      'prefill': {'contact': '$mobile', 'email': '$email'},
//      'external': {
//        'wallets': ['paytm']
//      }
    };

    try {
      razorPay.open(options);
    } catch (e) {
      debugPrint('payment error - $e');
    }
  }

  ///get paisa
  int getPaisa(String amount) {
    List<String> split = amount.split('.');
    return (int.parse(split[0]) * 100) + int.parse(split[1]);
  }

  /// order placed method
  checkOutOrder() async {
    payBtnCtr.add(true);
    String customerId = await Keys.storage.read(key: Keys.customerID);
    var params = {
      'customer_id': customerId,
      'total': totalList[0].total.toString()
    };
    print('Params - $params');
    checkout.PlaceOrderModel model = await placeOrder(params);
    if (model != null) {
      if (model.success == 1) {
        String orderId = model.response[0].orderId.toString();
        print('oID - $orderId');
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                settings: RouteSettings(name: '/dashboard'),
                builder: (context) => OrderDetailsScreen(
                      orderID: orderId,
                      status: 'Pending',
                    )));
        payBtnCtr.add(false);
      } else {
        print('Order not placed');
        payBtnCtr.add(false);
      }
    } else {
      print('Json decode error');
      payBtnCtr.add(false);
    }
  }
}

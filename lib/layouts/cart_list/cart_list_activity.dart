import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmfashions/api/models/cart_list_response_model.dart';
import 'package:gmfashions/api/models/remove_cart_response_model.dart';
import 'package:gmfashions/api/repository.dart';
import 'package:gmfashions/api/models/get_total_response_model.dart' as total;
import 'package:gmfashions/layouts/address_list/address_list_screen.dart';
import 'package:gmfashions/utils/styles.dart';
import 'package:gmfashions/utils/utils.dart';
import 'cart_list_screen.dart';

enum CartListState { IDLE, LOADING, EMPTY, ERROR }

enum ChangeTotalState { IDLE, LOADING, ERROR }

abstract class CartListActivity extends State<CartListScreen> {
  List<Response> responseList = [];
  List<total.Response> totList = [];
  int currentIndex;

  StreamController<CartListState> cartListController =
      StreamController<CartListState>.broadcast();

  StreamController<ChangeTotalState> totalCtr =
      StreamController<ChangeTotalState>.broadcast();
  StreamController qtnBtnChangeCtr = StreamController<bool>.broadcast();

  // cart list

  getCartItemList() async {
    //cartListController.add(CartListState.LOADING);
    CartListResponseModel model = await cartList();
    if (model != null) {
      if (model.success == 1) {
        if (model.response.isNotEmpty) {
          print('Success');
          responseList = model.response;
          getGrandTotal();
          cartListController.add(CartListState.IDLE);
        } else {
          print('cart List Empty');
          cartListController.add(CartListState.EMPTY);
        }
      } else {
        print('Cart List Error');
        cartListController.add(CartListState.ERROR);
      }
    } else {
      print('json decode Error');
      cartListController.add(CartListState.ERROR);
    }
  }

  // get total

  getGrandTotal() async {
    //totalCtr.add(ChangeTotalState.LOADING);
    total.GetTotalResponseModel model = await getItemTotal();
    if (model != null) {
      totList = model.response;
      totalCtr.add(ChangeTotalState.IDLE);
    } else {
      print('json error');
      totalCtr.add(ChangeTotalState.ERROR);
    }
  }

  // remove cart dialog

  deleteCart(String cartID, int index, List<Response> list) {
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (context) {
          return showCustomDialog(
              context: context,
              title: 'Warning!',
              content: 'Are you sure Remove item from Cart?',
              onPressed: () {
                Navigator.pop(context);
                removeCartItem(cartID, index, list);
              });

//           return showCustomDialog(
//             title: 'Warning!',
//             content: 'Are you sure Remove item from Cart?',
//             action: [
//               FlatButton(child: Text('No',style: headingTxt(16, context,color: black,fontWeight: FontWeight.w500),), onPressed : () {
//                 Navigator.pop(context);
//               }),
//               FlatButton(child: Text('Yes',style: headingTxt(16, context,color: red,fontWeight: FontWeight.w500),), onPressed : () {
//                 Navigator.pop(context);
//                 removeCartItem(cartID, index, list);
//               }),
//             ]);
        });
  }

  // remove cart item

  removeCartItem(String cartID, int index, List<Response> list) async {
    print('cartID - $cartID');
    RemoveCartResponseModel removeCartResponseModel = await removeCart(cartID);
    if (removeCartResponseModel != null) {
      if (removeCartResponseModel.response == true) {
        print('success');
        list.removeAt(index);
        getCartItemList();
        cartListController.add(CartListState.IDLE);
      } else {
        print('error');
        cartListController.add(CartListState.ERROR);
      }
    } else {
      print('json error');
      cartListController.add(CartListState.ERROR);
    }
  }

  void quantityPlus(String id, int qty, int index) async {
    if (qty < 40) {
      qtnBtnChangeCtr.add(true);
      currentIndex = index;
      print('currentIndex $currentIndex');
      qty = qty + 1;
      RemoveCartResponseModel model = await qtyChange(id, qty);
      if (model.response == true) {
        await getCartItemList();
//        getGrandTotal();
        print('success');
        qtnBtnChangeCtr.add(false);
        cartListController.add(CartListState.IDLE);
      } else {
        print('error');
        cartListController.add(CartListState.ERROR);
      }
    }

    //  cartListController.add(CartListState.IDLE);
  }

  // quantity decrement btn

  void qtyMinus(String id, int qty, int index) async {
    currentIndex = index;
    print('currentIndex $currentIndex');
    cartListController.add(CartListState.IDLE);
    if (qty <= 1) return;
    qtnBtnChangeCtr.add(true);
    qty--;
    print(qty);
    RemoveCartResponseModel model = await qtyChange(id, qty);
    if (model.response == true) {
      await getCartItemList();
      print('success');
      cartListController.add(CartListState.IDLE);
    } else {
      // isLoading = false;
      print('error');
      cartListController.add(CartListState.ERROR);
    }
    qtnBtnChangeCtr.add(false);
  }

  navigateAddressScreen(BuildContext context) {
    push(
        context: context, pushReplacement: false, toWidget: AddressListScreen(isDrawer: false,));
  }
}

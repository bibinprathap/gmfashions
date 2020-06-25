import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:gmfashions/api/models/add_to_Cart_res_model.dart';
import 'package:gmfashions/api/models/product_details_response_model.dart';
import 'package:gmfashions/api/repository.dart';
import 'package:gmfashions/layouts/cart_list/cart_list_screen.dart';
import 'package:gmfashions/layouts/customer_review/customer_review_screen.dart';
import 'package:gmfashions/layouts/login/login_screen.dart';
import 'package:gmfashions/layouts/product_details/product_details.dart';
import 'package:gmfashions/layouts/product_details/product_details.dart';
import 'package:gmfashions/utils/sp_keys.dart';
import 'package:gmfashions/utils/styles.dart';
import 'package:gmfashions/utils/utils.dart';
import 'package:gmfashions/widgets/server_error_widget.dart';
import 'package:html_unescape/html_unescape.dart';

enum ProductDetailsState { IDLE, LOADING, EMPTY, ERROR }
enum changeQtystate { IDLE, LOADING }
enum optionChangeState { IDLE, LOADING }

abstract class ProductDetailsActivity extends State<ProductDetails> {
  double rating = 4;
  int quantity = 1;
  int amount;
  String price;
  bool optionSelected = true;
  double dPrice,
      dSpecialPrice = 0.0,
      optionPrice,
      dFinalPrice,
      dSpecialFinalPrice = 0.0;

  int iDiscount = 0;
  int currentIndex;

  final qtyLoadingCntlr = StreamController<bool>.broadcast();


  var unescape = new HtmlUnescape();
  var text;

  final flutterWebViewPlugin = FlutterWebviewPlugin();

  /// product details response lists

  List<BasicDetail> basicDetailsList = [];
  List<Rating> ratingList = [];
  List<Option> optionList = [];
  List<ImageDetail> imgList = [];
  List<Review> reviewList = [];
  List<RelatedProduct> relatedProduct = [];
  List<Special> specialList = [];

  ///product details Controller

  StreamController<ProductDetailsState> productDetailsctr =
      StreamController<ProductDetailsState>.broadcast();

  /// Add to cart & buy now button controller

  StreamController addCartBtnController = StreamController<bool>.broadcast();

  StreamController buyNowController = StreamController<bool>.broadcast();

  /// scaffoldKey

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  onInitState() {
    productDetailsList(widget.productId);
    dPrice = double.parse(widget.price.replaceAll(',', ''));
  }

  /// rating change

  void ratingChange(double value) {
    rating = value;
    productDetailsctr.add(ProductDetailsState.IDLE);
  }

  /// qty increment

  quantityPlus(String price) {
    amount = int.parse(price);

//   quantity = int.parse(qty);
//   print('price - $amt');
    quantity += 1;
//   print('+qty - $quantity');
    amount = amount * quantity;
    print('total  - $amount');
    productDetailsctr.add(ProductDetailsState.IDLE);
  }

  /// qty decrement

  void quantityMinus(String price) {
//       detailsController.add(ProductDetailsState.LOADING);
    amount = int.parse(price);
//    quantity = int.parse(qty);
//      print('price - $amt');
    if (quantity == 1) return;
    quantity -= 1;
    print('-qty - $quantity');
    amount = amount * quantity;
    print('total - $amount');
    productDetailsctr.add(ProductDetailsState.IDLE);
  }

  /// product details response list

  productDetailsList(String id) async {
    productDetailsctr.add(ProductDetailsState.LOADING);
    ProductDetailResponse model = await productDetails(id);
    if (model != null) {
      if (model.success.toString().isNotEmpty) {
        imgList = model.response.imageDetails;
        basicDetailsList = model.response.basicDetails;
        ratingList = model.response.rating;
        optionList = model.response.options;
        reviewList = model.response.review;
        specialList = model.response.special;
        relatedProduct = model.response.relatedProduct;
        productDetailsctr.add(ProductDetailsState.IDLE);
      } else {
        print('List Empty');
        productDetailsctr.add(ProductDetailsState.EMPTY);
      }
    } else {
      print('Json Error');
      productDetailsctr.add(ProductDetailsState.ERROR);
    }
  }

  ///calculate discount for discount row
  int calculateDiscount(int iDiscount) {
    if (specialList != null) {
      double dDiscount =
          (double.parse(basicDetailsList[0].price.replaceAll(',', '')) -
                  double.parse(specialList[0].price.replaceAll(',', ''))) /
              double.parse(basicDetailsList[0].price.replaceAll(',', '')) *
              100;
      iDiscount = dDiscount.round();
    }
    return iDiscount;
  }

  /// Item added to cart snackBar

  void itemAddedSnackBar(BuildContext context, String cId, int amt, int qty) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        'Item Added to Cart',
      ),
      action: SnackBarAction(
        label: 'Go To Cart',
        onPressed: () {
          push(
              context: context,
              pushReplacement: false,
              toWidget: CartListScreen());
        },
      ),
    ));
//    showFlushBar(
//      context,
//      red1,
//      'Item Added to Cart',
//      Icons.add_shopping_cart,
//      button: FlatButton(
//        onPressed: () {
//          push(
//              context: context,
//              pushReplacement: false,
//              toWidget: CartListScreen(
//                customerId: cId,
//                price: amt,
//                qty: qty,
//              ));
//        },
//        child: Text(
//          "Go To Cart",
//          style: TextStyle(color: white),
//        ),
//      ),
//    );
  }

  /// choose options - size & color
  void chooseOptions(int index, ProductOptionValue option) {
    //_isFirstTime = false;
    optionSelected = true;
    optionList[index].productOptionValue.forEach((opt) {
      opt.isSelected = false;
    });
    option.isSelected = true;
    optionPrice = double.parse(option.price.replaceAll(',', ''));
    if (option.pricePrefix == '+') {
      dFinalPrice = (dPrice + optionPrice) * quantity;
      dSpecialFinalPrice = (dSpecialPrice + optionPrice) * quantity;
      productDetailsctr.add(ProductDetailsState.IDLE);
    } else {
      dFinalPrice = (dPrice - optionPrice) * quantity;
      dSpecialFinalPrice = (dSpecialPrice - optionPrice) * quantity;
      productDetailsctr.add(ProductDetailsState.IDLE);
    }
  }

  /// add to cart button

  addToCartButton(
      int qty, int amt, BuildContext context, BasicDetail basicDetail) async {
    String cId = await storage.read(key: Keys.customerID);
    print('cid - $cId');
    addCartBtnController.add(true);
    if (cId != null) {
      List<OptionIDs> selectedOptionList = [];
      int item = optionList.length;
      print('option length - $item');
      optionList.asMap().forEach((index, option) {
        option.productOptionValue.forEach((val) {
          print('option index - $index');
          if (val.isSelected) {
            selectedOptionList.add(OptionIDs(
                optionID: val.productOptionId,
                optionValue: val.productOptionValueId));
          }
          productDetailsctr.add(ProductDetailsState.IDLE);
        });
      });
      if (selectedOptionList.length == item) {
        String optionValue = '';
        selectedOptionList.forEach((option) {
          optionValue += '&option[${option.optionID}]=${option.optionValue}';
          print('option value - $optionValue');
        });
        AddToCartResponseModel model =
            await addToCartItem(cId, basicDetail.productId, qty, optionValue);
        if (model != null) {
          if (model.response == true) {
            print('Item added to cart');
            itemAddedSnackBar(context, cId, amt, qty);
            addCartBtnController.add(false);
          } else {
            print('Error');
            //errorDialog(context);
            push(
                context: context,
                pushReplacement: true,
                toWidget: ServerErrorWidget());
            addCartBtnController.add(false);
            // Dialog

          }
        } else {
          print('json decode error');
          addCartBtnController.add(false);
        }
      } else {
        optionSelected = false;
        addCartBtnController.add(false);
      }
    } else {
      print('Please Login');
      userNullLoginDialog(context);
      addCartBtnController.add(false);
      // Dialog
    }
  }

  /// buy now button

  buyNowButton(
      int qty, int amt, BuildContext context, BasicDetail basicDetail) async {
    String cId = await storage.read(key: Keys.customerID);
    print('cid - $cId');
    buyNowController.add(true);
    if (cId != null) {
      List<OptionIDs> selectedOptionList = [];
      int item = optionList.length;
      print('option length - $item');
      optionList.asMap().forEach((index, option) {
        option.productOptionValue.forEach((val) {
          print('option index - $index');
          if (val.isSelected) {
            selectedOptionList.add(OptionIDs(
                optionID: val.productOptionId,
                optionValue: val.productOptionValueId));
          }
          productDetailsctr.add(ProductDetailsState.IDLE);
        });
      });
      if (selectedOptionList.length == item) {
        String optionValue = '';
        selectedOptionList.forEach((option) {
          optionValue += '&option[${option.optionID}]=${option.optionValue}';
          print('option value - $optionValue');
        });
        AddToCartResponseModel model =
            await addToCartItem(cId, basicDetail.productId, qty, optionValue);
        if (model != null) {
          if (model.response == true) {
            print('Item added to cart');
            push(
                context: context,
                pushReplacement: true,
                toWidget: CartListScreen());
            buyNowController.add(false);
          } else {
            print('Error');
            // errorDialog(context);
            push(
                context: context,
                pushReplacement: true,
                toWidget: ServerErrorWidget());
            buyNowController.add(false);
            // Dial
          }
        } else {
          print('json decode error');
          buyNowController.add(false);
        }
      } else {
        optionSelected = false;
        buyNowController.add(false);
      }
    } else {
      print('Please Login');
      userNullLoginDialog(context);
      buyNowController.add(false);
      // Dialog
    }
  }

  navigateToCustomerReview(BuildContext context) {
    push(
        context: context,
        pushReplacement: false,
        toWidget: CustomerReviewScreen(
          rating: ratingList[0],
          pId: widget.productId,
        ));
  }
}

///option class
class OptionIDs {
  String optionID, optionValue;

  OptionIDs({this.optionID, this.optionValue});
}

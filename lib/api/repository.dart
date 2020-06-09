
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gmfashions/api/http_request.dart';
import 'package:gmfashions/api/models/PlaceOrderModel.dart';
import 'package:gmfashions/api/models/add_address_model.dart';
import 'package:gmfashions/api/models/add_to_Cart_res_model.dart';
import 'package:gmfashions/api/models/address_list_model.dart';
import 'package:gmfashions/api/models/country_list_response_model.dart';
import 'package:gmfashions/api/models/make_default_address_model.dart';
import 'package:gmfashions/api/models/order_details_model.dart';
import 'package:gmfashions/api/models/order_list_model.dart';
import 'package:gmfashions/api/models/product_details_response_model.dart';
import 'package:gmfashions/api/models/product_list_response_model.dart';
import 'package:gmfashions/api/models/search_response_model.dart';
import 'package:gmfashions/api/models/state_list_response_model.dart';
import 'package:gmfashions/api/models/sub_category_response_model.dart';
import 'package:gmfashions/api/urls.dart';
import 'package:gmfashions/utils/sp_keys.dart';
import 'package:gmfashions/utils/utils.dart';

import 'models/cart_list_response_model.dart';
import 'models/get_total_response_model.dart';
import 'models/home_response_model.dart';
import 'models/login_response_model.dart';
import 'models/post_register_details_model.dart';
import 'models/remove_cart_response_model.dart';

final storage = FlutterSecureStorage();

// doLogin

Future<LoginResponseModel> doLogin(String email,String password) async {
  print('user -$email , pass - $password');
  return loginResponseModelFromJson(await httpGet(url: login(email,password)));

}

// dashboard list

Future<HomeResponseModel> homePageList() async {
  return homeResponseModelFromJson(await httpGet(url: homeURL));
}

// sub Category

Future<SubCategoryResponseModel> getSubCategory(String categoryID) async {
  print('categoryID - $categoryID');
  return subCategoryResponseModelFromJson(await httpGet(url: subCategoryURL + categoryID ));
}

// product List

Future<ProductResponseModel> productList(String categoryID) async {
  print('categoryID - $categoryID');
  return productResponseModelFromJson(await httpGet(url: productListURL + categoryID ));
}

// product details

Future<ProductDetailResponse> productDetails(String productId) async {
  print('productId - $productId');
  return productDetailResponseFromJson(await httpGet(url: getProductDetails + productId ));
}

// Add to Cart

Future<AddToCartResponseModel> addToCartItem(String customerID,productID,quantity,option) async {
  return addToCartResponseModelFromJson(
      await httpGet(url: addToCart(customerID, productID, quantity,option)));
}


// get Cart List

Future<CartListResponseModel> cartList() async {
  String cId = await storage.read(key: Keys.customerID);
  print('cusid - $cId');
  return cartListResponseModelFromJson(await httpGet(url: getCartList + cId));
}

// Get Total Payment Screen

Future<GetTotalResponseModel> getItemTotal() async{
  String cId = await storage.read(key:  Keys.customerID);
  print('customer id - $cId');
  return getTotalResponseModelFromJson(await httpGet(url: getTotal + cId));

}

// remove cart

Future<RemoveCartResponseModel> removeCart(String cartId) async {
  print('cart id -$cartId');
  return removeCartResponseModelFromJson(await httpGet(url: removeFromCart + cartId));
}


// quantity change

Future<RemoveCartResponseModel> qtyChange(String cartID, int qty)async{
  return removeCartResponseModelFromJson(await httpGet(url: quantityChange(cartID, qty.toString())));

}

// search products in dashboard

Future<SearchResponseModel> searchProducts(String searchQuery) async{
  String url = searchProduct + searchQuery;
  print('search url : $url');
  return searchResponseModelFromJson(await httpGet(url:url));

}

// check email in register

Future<AddToCartResponseModel> checkMail(String email)async{
  return addToCartResponseModelFromJson(await httpGet(url: checkEmail + email ));

}


// get country List

Future<CountryListResponseModel> getCountryList() async{
  return countryListResponseModelFromJson(await httpGet(url: countryList));
}

// get state list

Future<StateListResponseModel> getStateList(String countryId) async{
  print('country id -$countryId');
  return stateListResponseModelFromJson(await httpGet(url: districtList + countryId));
}

// Register Details

Future<PostRegisterResponseModel> postRegisterDetails(Map<String,String> params) async{
  return postRegisterResponseModelFromJson(await httpPost(url: signUp(),params: params));
}


// Address List

Future<AddressListModel> getAddressList() async {
  String cId = await storage.read(key:  Keys.customerID);
  print('customer id - $cId');
  return addressListModelFromJson(await httpGet(url: addressList + cId));
}

// Default Address List

Future<MakeDefaultResponseModel> setDefaultAddress(String addressId) async {
  String cId = await storage.read(key:  Keys.customerID);
  String url = makeDefaultAddress  + cId +'&address_id=' + addressId;
  print('url - $url');
  print('customer id - $cId');
  return makeDefaultResponseModelFromJson(await httpGet(url: url));
}

// Delete Address
Future<AddToCartResponseModel> removeAddress(String addressId) async {
  return addToCartResponseModelFromJson(await httpGet(url: deleteAddress + addressId));
}

// get order list
Future<OrderListModel> orderList() async {
  String cId = await storage.read(key:  Keys.customerID);
  return orderListModelFromJson(await httpGet(url: getOrderList + cId));
}

Future<OrderDetailsModel> orderDetails(String oId) async {
  return orderDetailsModelFromJson(await httpGet(url: getOrderDetails + oId));
}


// Add Address

Future<AddAddressResponseModel> addAddress(Map<String,String> params) async{
  return addAddressResponseModelFromJson(await httpPost(url: addNewAddress,params: params));
}


// Edit Address

Future<AddToCartResponseModel> updateAddress(Map<String,String> params) async{
  return addToCartResponseModelFromJson(await httpPost(url:editAddress ,params: params));
}

// place order

Future<PlaceOrderModel> placeOrder(Map<String,String> params) async{
  return placeOrderModelFromJson(await httpPost(url:checkout ,params: params));
}




String baseURL = 'https://www.gmfashions.in/api/services/api_call.php?type=';
//String baseURL = 'https://www.rotary2982.org/oc/api/services/api_call.php?type=';
String imageBaseURL = 'https://www.gmfashions.in/';
//String imageURL = 'https://www.rotary2982.org/oc/';
String homeURL = baseURL + 'home';
String categoryURL = baseURL + 'categories';
String subCategoryURL = baseURL + 'categories&parent_id=';
String productListURL = baseURL + 'products&category_id=';
String getFilersURL = baseURL + 'filter&category_id=';
String getProductDetails = baseURL + 'product_details&product_id=';
String getCartList = baseURL + 'view_cart&customer_id=';
String removeFromCart = baseURL + 'remove_from_cart&cart_id=';
String getTotal = baseURL + 'get_total&customer_id=';
String getOrderList = baseURL + 'get_orders&customer_id=';
String getOrderDetails = baseURL + 'get_order_details&order_id=';
String checkEmail = baseURL + 'check_email&email=';
String countryList = baseURL + 'signup_form';
String checkout = baseURL + 'checkout';
String districtList = baseURL + 'get_state&country_id=';
String getCustomer = baseURL + 'get_customer&customer_id=';
String searchProduct = baseURL + 'search&search_tag=';
String addressList = baseURL + 'address_list&customer_id=';
String addNewAddress = baseURL + 'add_address';
String editAddress = baseURL + 'update_address';
String staticPage = baseURL + 'page_content';
String staticPageList = baseURL + 'pages_list';
String makeDefaultAddress = baseURL + 'default_address&customer_id=';
String deleteAddress = baseURL + 'delete_address&address_id=';

String addFilter(String categoryID, filterIDs) {
  return productListURL + '$categoryID' + '&filter=$filterIDs';
}

String login(String username, password) {
  return baseURL + 'login&email=$username&password=$password';
}

String addToCart(String customerID, productID, quantity, optionValue) {
//  return baseURL+'add_to_cart&customer_id=$customerID&product_id=$productID&quantity=$quantity';
  return baseURL +
      'add_to_cart&customer_id=$customerID&product_id=$productID}&quantity=$quantity' +
      optionValue;
}

String quantityChange(String cartID, String qty) {
  return baseURL + 'update_qty&cart_id=$cartID&qty=$qty';
}

String signUp() {
  return baseURL + 'signup';
}

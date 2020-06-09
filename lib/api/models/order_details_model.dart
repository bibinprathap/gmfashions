// To parse this JSON data, do
//
//     final orderDetailsModel = orderDetailsModelFromJson(jsonString);

import 'dart:convert';

OrderDetailsModel orderDetailsModelFromJson(String str) {
  try{
    return OrderDetailsModel.fromJson(json.decode(str));
  }catch(e){
    print('json decode error - $e');
    return null;
  }

}

String orderDetailsModelToJson(OrderDetailsModel data) => json.encode(data.toJson());

class OrderDetailsModel {
  List<Response> response;
  int success;
  String message;

  OrderDetailsModel({
    this.response,
    this.success,
    this.message,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) => OrderDetailsModel(
    response: json["response"] == null ? null : List<Response>.from(json["response"].map((x) => Response.fromJson(x))),
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "response": response == null ? null : List<dynamic>.from(response.map((x) => x.toJson())),
    "success": success == null ? null : success,
    "message": message == null ? null : message,
  };
}

class Response {
  List<Map<String, String>> orderDetails;
  List<ProductDetail> productDetails;
  List<TotalDetail> totalDetails;

  Response({
    this.orderDetails,
    this.productDetails,
    this.totalDetails,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    orderDetails: json["order_details"] == null ? null : List<Map<String, String>>.from(json["order_details"].map((x) => Map.from(x).map((k, v) => MapEntry<String, String>(k, v)))),
    productDetails: json["product_details"] == null ? null : List<ProductDetail>.from(json["product_details"].map((x) => ProductDetail.fromJson(x))),
    totalDetails: json["total_details"] == null ? null : List<TotalDetail>.from(json["total_details"].map((x) => TotalDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "order_details": orderDetails == null ? null : List<dynamic>.from(orderDetails.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
    "product_details": productDetails == null ? null : List<dynamic>.from(productDetails.map((x) => x.toJson())),
    "total_details": totalDetails == null ? null : List<dynamic>.from(totalDetails.map((x) => x.toJson())),
  };
}

class ProductDetail {
  String name;
  String model;
  String image;
  List<Option> option;
  String quantity;
  int price;
  int total;

  ProductDetail({
    this.name,
    this.model,
    this.image,
    this.option,
    this.quantity,
    this.price,
    this.total,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
    name: json["name"] == null ? null : json["name"],
    model: json["model"] == null ? null : json["model"],
    image: json["image"] == null ? null : json["image"],
    option: json["option"] == null ? null : List<Option>.from(json["option"].map((x) => Option.fromJson(x))),
    quantity: json["quantity"] == null ? null : json["quantity"],
    price: json["price"] == null ? null : json["price"],
    total: json["total"] == null ? null : json["total"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "model": model == null ? null : model,
    "image": image == null ? null : image,
    "option": option == null ? null : List<dynamic>.from(option.map((x) => x.toJson())),
    "quantity": quantity == null ? null : quantity,
    "price": price == null ? null : price,
    "total": total == null ? null : total,
  };
}

class Option {
  String name;
  String value;

  Option({
    this.name,
    this.value,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    name: json["name"] == null ? null : json["name"],
    value: json["value"] == null ? null : json["value"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "value": value == null ? null : value,
  };
}

class TotalDetail {
  String orderTotalId;
  String orderId;
  String code;
  String title;
  String value;
  String sortOrder;
  String text;

  TotalDetail({
    this.orderTotalId,
    this.orderId,
    this.code,
    this.title,
    this.value,
    this.sortOrder,
    this.text,
  });

  factory TotalDetail.fromJson(Map<String, dynamic> json) => TotalDetail(
    orderTotalId: json["order_total_id"] == null ? null : json["order_total_id"],
    orderId: json["order_id"] == null ? null : json["order_id"],
    code: json["code"] == null ? null : json["code"],
    title: json["title"] == null ? null : json["title"],
    value: json["value"] == null ? null : json["value"],
    sortOrder: json["sort_order"] == null ? null : json["sort_order"],
    text: json["text"] == null ? null : json["text"],
  );

  Map<String, dynamic> toJson() => {
    "order_total_id": orderTotalId == null ? null : orderTotalId,
    "order_id": orderId == null ? null : orderId,
    "code": code == null ? null : code,
    "title": title == null ? null : title,
    "value": value == null ? null : value,
    "sort_order": sortOrder == null ? null : sortOrder,
    "text": text == null ? null : text,
  };
}

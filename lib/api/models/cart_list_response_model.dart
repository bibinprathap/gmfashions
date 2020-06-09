// To parse this JSON data, do
//
//     final cartListResponseModel = cartListResponseModelFromJson(jsonString);

import 'dart:convert';

CartListResponseModel cartListResponseModelFromJson(String str) {
  try{
    return CartListResponseModel.fromJson(json.decode(str));
  }catch(e){
    print('json decode error $e');
    return null;
  }

}

String cartListResponseModelToJson(CartListResponseModel data) => json.encode(data.toJson());

class CartListResponseModel {
  List<Response> response;
  int success;
  String message;

  CartListResponseModel({
    this.response,
    this.success,
    this.message,
  });

  factory CartListResponseModel.fromJson(Map<String, dynamic> json) => CartListResponseModel(
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
  String cartId;
  String productId;
  String name;
  String model;
  String image;
  List<Option> option;
  String quantity;
  String minimum;
  String subtract;
  bool stock;
  int price;
  int total;
  bool recurring;

  Response({
    this.cartId,
    this.productId,
    this.name,
    this.model,
    this.image,
    this.option,
    this.quantity,
    this.minimum,
    this.subtract,
    this.stock,
    this.price,
    this.total,
    this.recurring,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    cartId: json["cart_id"] == null ? null : json["cart_id"],
    productId: json["product_id"] == null ? null : json["product_id"],
    name: json["name"] == null ? null : json["name"],
    model: json["model"] == null ? null : json["model"],
    image: json["image"] == null ? null : json["image"],
    option: json["option"] == null ? null : List<Option>.from(json["option"].map((x) => Option.fromJson(x))),
    quantity: json["quantity"] == null ? null : json["quantity"],
    minimum: json["minimum"] == null ? null : json["minimum"],
    subtract: json["subtract"] == null ? null : json["subtract"],
    stock: json["stock"] == null ? null : json["stock"],
    price: json["price"] == null ? null : json["price"],
    total: json["total"] == null ? null : json["total"],
    recurring: json["recurring"] == null ? null : json["recurring"],
  );

  Map<String, dynamic> toJson() => {
    "cart_id": cartId == null ? null : cartId,
    "product_id": productId == null ? null : productId,
    "name": name == null ? null : name,
    "model": model == null ? null : model,
    "image": image == null ? null : image,
    "option": option == null ? null : List<dynamic>.from(option.map((x) => x.toJson())),
    "quantity": quantity == null ? null : quantity,
    "minimum": minimum == null ? null : minimum,
    "subtract": subtract == null ? null : subtract,
    "stock": stock == null ? null : stock,
    "price": price == null ? null : price,
    "total": total == null ? null : total,
    "recurring": recurring == null ? null : recurring,
  };
}

class Option {
  String productOptionId;
  String productOptionValueId;
  String optionId;
  String optionValueId;
  String name;
  String value;
  String type;
  String quantity;
  String subtract;
  String price;
  String pricePrefix;
  String points;
  String pointsPrefix;
  String weight;
  String weightPrefix;

  Option({
    this.productOptionId,
    this.productOptionValueId,
    this.optionId,
    this.optionValueId,
    this.name,
    this.value,
    this.type,
    this.quantity,
    this.subtract,
    this.price,
    this.pricePrefix,
    this.points,
    this.pointsPrefix,
    this.weight,
    this.weightPrefix,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    productOptionId: json["product_option_id"] == null ? null : json["product_option_id"],
    productOptionValueId: json["product_option_value_id"] == null ? null : json["product_option_value_id"],
    optionId: json["option_id"] == null ? null : json["option_id"],
    optionValueId: json["option_value_id"] == null ? null : json["option_value_id"],
    name: json["name"] == null ? null : json["name"],
    value: json["value"] == null ? null : json["value"],
    type: json["type"] == null ? null : json["type"],
    quantity: json["quantity"] == null ? null : json["quantity"],
    subtract: json["subtract"] == null ? null : json["subtract"],
    price: json["price"] == null ? null : json["price"],
    pricePrefix: json["price_prefix"] == null ? null : json["price_prefix"],
    points: json["points"] == null ? null : json["points"],
    pointsPrefix: json["points_prefix"] == null ? null : json["points_prefix"],
    weight: json["weight"] == null ? null : json["weight"],
    weightPrefix: json["weight_prefix"] == null ? null : json["weight_prefix"],
  );

  Map<String, dynamic> toJson() => {
    "product_option_id": productOptionId == null ? null : productOptionId,
    "product_option_value_id": productOptionValueId == null ? null : productOptionValueId,
    "option_id": optionId == null ? null : optionId,
    "option_value_id": optionValueId == null ? null : optionValueId,
    "name": name == null ? null : name,
    "value": value == null ? null : value,
    "type": type == null ? null : type,
    "quantity": quantity == null ? null : quantity,
    "subtract": subtract == null ? null : subtract,
    "price": price == null ? null : price,
    "price_prefix": pricePrefix == null ? null : pricePrefix,
    "points": points == null ? null : points,
    "points_prefix": pointsPrefix == null ? null : pointsPrefix,
    "weight": weight == null ? null : weight,
    "weight_prefix": weightPrefix == null ? null : weightPrefix,
  };
}

// To parse this JSON data, do
//
//     final productResponseModel = productResponseModelFromJson(jsonString);

import 'dart:convert';

ProductResponseModel productResponseModelFromJson(String str) {
  try{
    return ProductResponseModel.fromJson(json.decode(str));

  }catch(e){
    print('json decode error');
    return null;
  }
}

String productResponseModelToJson(ProductResponseModel data) => json.encode(data.toJson());

class ProductResponseModel {
  List<Response> response;
  int success;
  String message;

  ProductResponseModel({
    this.response,
    this.success,
    this.message,
  });

  factory ProductResponseModel.fromJson(Map<String, dynamic> json) => ProductResponseModel(
    response: json["response"] == 0 ? null : List<Response>.from(json["response"].map((x) => Response.fromJson(x))),
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
  String productId;
  String quantity;
  String image;
  String price;
  String name;

  Response({
    this.productId,
    this.quantity,
    this.image,
    this.price,
    this.name,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    productId: json["product_id"] == null ? null : json["product_id"],
    quantity: json["quantity"] == null ? null : json["quantity"],
    image: json["image"] == null ? null : json["image"],
    price: json["price"] == null ? null : json["price"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId == null ? null : productId,
    "quantity": quantity == null ? null : quantity,
    "image": image == null ? null : image,
    "price": price == null ? null : price,
    "name": name == null ? null : name,
  };
}

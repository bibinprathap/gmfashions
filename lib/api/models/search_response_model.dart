// To parse this JSON data, do
//
//     final searchResponseModel = searchResponseModelFromJson(jsonString);

import 'dart:convert';

SearchResponseModel searchResponseModelFromJson(String str) {

  try{
    return SearchResponseModel.fromJson(json.decode(str));

  }catch(e){
    print('json decode error - $e');
    return null;
  }
}

String searchResponseModelToJson(SearchResponseModel data) => json.encode(data.toJson());

class SearchResponseModel {
  List<Response> response;
  int success;
  String message;

  SearchResponseModel({
    this.response,
    this.success,
    this.message,
  });

  factory SearchResponseModel.fromJson(Map<String, dynamic> json) => SearchResponseModel(
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
  String productId;
  String quantity;
  String image;
  String price;
  String name;
  String description;

  Response({
    this.productId,
    this.quantity,
    this.image,
    this.price,
    this.name,
    this.description,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    productId: json["product_id"] == null ? null : json["product_id"],
    quantity: json["quantity"] == null ? null : json["quantity"],
    image: json["image"] == null ? null : json["image"],
    price: json["price"] == null ? null : json["price"],
    name: json["name"] == null ? null : json["name"],
    description: json["description"] == null ? null : json["description"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId == null ? null : productId,
    "quantity": quantity == null ? null : quantity,
    "image": image == null ? null : image,
    "price": price == null ? null : price,
    "name": name == null ? null : name,
    "description": description == null ? null : description,
  };
}

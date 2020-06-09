// To parse this JSON data, do
//
//     final homeResponseModel = homeResponseModelFromJson(jsonString);

import 'dart:convert';

HomeResponseModel homeResponseModelFromJson(String str) {
  try{
    return HomeResponseModel.fromJson(json.decode(str));
  }catch(e){
    print('Json decode error - $e');
    return null;
  }

}

String homeResponseModelToJson(HomeResponseModel data) => json.encode(data.toJson());

class HomeResponseModel {
  Response response;
  int success;
  String message;

  HomeResponseModel({
    this.response,
    this.success,
    this.message,
  });

  factory HomeResponseModel.fromJson(Map<String, dynamic> json) => HomeResponseModel(
    response: json["response"] == null ? null : Response.fromJson(json["response"]),
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "response": response == null ? null : response.toJson(),
    "success": success == null ? null : success,
    "message": message == null ? null : message,
  };
}

class Response {
  List<SlideBanner> slideBanner;
  List<LatestProduct> latestProducts;
  List<Category> categories;

  Response({
    this.slideBanner,
    this.latestProducts,
    this.categories,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    slideBanner: json["slide_banner"] == null ? [] : List<SlideBanner>.from(json["slide_banner"].map((x) => SlideBanner.fromJson(x))),
    latestProducts: json["latest_products"] == [] ? null : List<LatestProduct>.from(json["latest_products"].map((x) => LatestProduct.fromJson(x))),
    categories: json["categories"] == null ? [] : List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "slide_banner": slideBanner == null ? null : List<dynamic>.from(slideBanner.map((x) => x.toJson())),
    "latest_products": latestProducts == null ? null : List<dynamic>.from(latestProducts.map((x) => x.toJson())),
    "categories": categories == null ? null : List<dynamic>.from(categories.map((x) => x.toJson())),
  };
}

class Category {
  String categoryId;
  String name;
  String image;
  int parent;

  Category({
    this.categoryId,
    this.name,
    this.image,
    this.parent,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    categoryId: json["category_id"] == null ? null : json["category_id"],
    name: json["name"] == null ? null : json["name"],
    image: json["image"] == null ? null : json["image"],
    parent: json["parent"] == null ? null : json["parent"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId == null ? null : categoryId,
    "name": name == null ? null : name,
    "image": image == null ? null : image,
    "parent": parent == null ? null : parent,
  };
}

class LatestProduct {
  String productId;
  String quantity;
  String image;
  String price;
  String name;

  LatestProduct({
    this.productId,
    this.quantity,
    this.image,
    this.price,
    this.name,
  });

  factory LatestProduct.fromJson(Map<String, dynamic> json) => LatestProduct(
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

class SlideBanner {
  String image;

  SlideBanner({
    this.image,
  });

  factory SlideBanner.fromJson(Map<String, dynamic> json) => SlideBanner(
    image: json["image"] == null ? null : json["image"],
  );

  Map<String, dynamic> toJson() => {
    "image": image == null ? null : image,
  };
}

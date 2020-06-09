// To parse this JSON data, do
//
//     final subCategoryResponseModel = subCategoryResponseModelFromJson(jsonString);

import 'dart:convert';

SubCategoryResponseModel subCategoryResponseModelFromJson(String str) {
  try{
    return SubCategoryResponseModel.fromJson(json.decode(str));
  }catch(e){
    print('json decode error - $e');
    return null;
  }
}

String subCategoryResponseModelToJson(SubCategoryResponseModel data) => json.encode(data.toJson());

class SubCategoryResponseModel {
  List<Response> response;
  int success;
  String message;

  SubCategoryResponseModel({
    this.response,
    this.success,
    this.message,
  });

  factory SubCategoryResponseModel.fromJson(Map<String, dynamic> json) => SubCategoryResponseModel(
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
  String categoryId;
  String name;
  String image;
  int parent;

  Response({
    this.categoryId,
    this.name,
    this.image,
    this.parent,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
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

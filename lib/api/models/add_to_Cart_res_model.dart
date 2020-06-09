// To parse this JSON data, do
//
//     final addToCartResponseModel = addToCartResponseModelFromJson(jsonString);

import 'dart:convert';

AddToCartResponseModel addToCartResponseModelFromJson(String str) {
  try{
    return AddToCartResponseModel.fromJson(json.decode(str));
  }
  catch(e){
    print('json decode error - $e');
    return null;
  }

}

String addToCartResponseModelToJson(AddToCartResponseModel data) => json.encode(data.toJson());

class AddToCartResponseModel {
  bool response;
  int success;
  String message;

  AddToCartResponseModel({
    this.response,
    this.success,
    this.message,
  });

  factory AddToCartResponseModel.fromJson(Map<String, dynamic> json) => AddToCartResponseModel(
    response: json["response"] == null ? null : json["response"],
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "response": response == null ? null : response,
    "success": success == null ? null : success,
    "message": message == null ? null : message,
  };
}

// To parse this JSON data, do
//
//     final removeCartResponseModel = removeCartResponseModelFromJson(jsonString);

import 'dart:convert';

RemoveCartResponseModel removeCartResponseModelFromJson(String str) {
  try{
    return RemoveCartResponseModel.fromJson(json.decode(str));
  }catch(e){
    print('json decode error $e');
    return null;
  }


}

String removeCartResponseModelToJson(RemoveCartResponseModel data) => json.encode(data.toJson());

class RemoveCartResponseModel {
  bool response;
  int success;
  String message;

  RemoveCartResponseModel({
    this.response,
    this.success,
    this.message,
  });

  factory RemoveCartResponseModel.fromJson(Map<String, dynamic> json) => RemoveCartResponseModel(
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

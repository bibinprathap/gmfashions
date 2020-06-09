// To parse this JSON data, do
//
//     final postRegisterResponseModel = postRegisterResponseModelFromJson(jsonString);

import 'dart:convert';

PostRegisterResponseModel postRegisterResponseModelFromJson(String str) {


  return PostRegisterResponseModel.fromJson(json.decode(str));
}

String postRegisterResponseModelToJson(PostRegisterResponseModel data) => json.encode(data.toJson());

class PostRegisterResponseModel {
  List<Response> response;
  int success;
  String message;

  PostRegisterResponseModel({
    this.response,
    this.success,
    this.message,
  });

  factory PostRegisterResponseModel.fromJson(Map<String, dynamic> json) => PostRegisterResponseModel(
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
  int customerId;
  int addressId;

  Response({
    this.customerId,
    this.addressId,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    customerId: json["customer_id"] == null ? null : json["customer_id"],
    addressId: json["address_id"] == null ? null : json["address_id"],
  );

  Map<String, dynamic> toJson() => {
    "customer_id": customerId == null ? null : customerId,
    "address_id": addressId == null ? null : addressId,
  };
}

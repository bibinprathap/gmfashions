// To parse this JSON data, do
//
//     final addAddressResponseModel = addAddressResponseModelFromJson(jsonString);

import 'dart:convert';

AddAddressResponseModel addAddressResponseModelFromJson(String str) {

  try{
    return AddAddressResponseModel.fromJson(json.decode(str));
  }
  catch(e){
    print('Json Decode Error $e');
    return null;

  }
}

String addAddressResponseModelToJson(AddAddressResponseModel data) => json.encode(data.toJson());

class AddAddressResponseModel {
  List<Response> response;
  int success;
  String message;

  AddAddressResponseModel({
    this.response,
    this.success,
    this.message,
  });

  factory AddAddressResponseModel.fromJson(Map<String, dynamic> json) => AddAddressResponseModel(
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
  int addressId;

  Response({
    this.addressId,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    addressId: json["address_id"] == null ? null : json["address_id"],
  );

  Map<String, dynamic> toJson() => {
    "address_id": addressId == null ? null : addressId,
  };
}

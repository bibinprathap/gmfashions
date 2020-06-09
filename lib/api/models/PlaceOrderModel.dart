// To parse this JSON data, do
//
//     final placeOrderModel = placeOrderModelFromJson(jsonString);

import 'dart:convert';

PlaceOrderModel placeOrderModelFromJson(String str) {
  try{
    return PlaceOrderModel.fromJson(json.decode(str));
  }catch(e){
    print('Json Decode error - $e');
    return null;
  }

}

String placeOrderModelToJson(PlaceOrderModel data) => json.encode(data.toJson());

class PlaceOrderModel {
  List<Response> response;
  int success;
  String message;

  PlaceOrderModel({
    this.response,
    this.success,
    this.message,
  });

  factory PlaceOrderModel.fromJson(Map<String, dynamic> json) => PlaceOrderModel(
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
  int orderId;

  Response({
    this.orderId,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    orderId: json["order_id"] == null ? null : json["order_id"],
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId == null ? null : orderId,
  };
}

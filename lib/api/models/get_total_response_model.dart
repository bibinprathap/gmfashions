// To parse this JSON data, do
//
//     final getTotalResponseModel = getTotalResponseModelFromJson(jsonString);

import 'dart:convert';

GetTotalResponseModel getTotalResponseModelFromJson(String str) {
  try{
    return GetTotalResponseModel.fromJson(json.decode(str));
  }catch(e){
    print('json decode error - $e');
    return null;
  }

}

String getTotalResponseModelToJson(GetTotalResponseModel data) => json.encode(data.toJson());

class GetTotalResponseModel {
  List<Response> response;
  int success;
  String message;

  GetTotalResponseModel({
    this.response,
    this.success,
    this.message,
  });

  factory GetTotalResponseModel.fromJson(Map<String, dynamic> json) => GetTotalResponseModel(
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
  int subTotal;
  int shippingCharge;
  int total;
  int qty;

  Response({
    this.subTotal,
    this.shippingCharge,
    this.total,
    this.qty,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    subTotal: json["sub_total"] == null ? null : json["sub_total"],
    shippingCharge: json["shipping_charge"] == null ? null : json["shipping_charge"],
    total: json["total"] == null ? null : json["total"],
    qty: json["qty"] == null ? null : json["qty"],
  );

  Map<String, dynamic> toJson() => {
    "sub_total": subTotal == null ? null : subTotal,
    "shipping_charge": shippingCharge == null ? null : shippingCharge,
    "total": total == null ? null : total,
    "qty": qty == null ? null : qty,
  };
}

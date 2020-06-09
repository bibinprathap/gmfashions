// To parse this JSON data, do
//
//     final orderListModel = orderListModelFromJson(jsonString);

import 'dart:convert';

OrderListModel orderListModelFromJson(String str) {
  try{
    return OrderListModel.fromJson(json.decode(str));
  }catch(e){
    print('Json decode error - $e');
    return null;
  }

}

String orderListModelToJson(OrderListModel data) => json.encode(data.toJson());

class OrderListModel {
  List<Response> response;
  int success;
  String message;

  OrderListModel({
    this.response,
    this.success,
    this.message,
  });

  factory OrderListModel.fromJson(Map<String, dynamic> json) => OrderListModel(
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
  String orderId;
  String firstname;
  String lastname;
  String status;
  DateTime dateAdded;
  String total;
  String currencyCode;
  String currencyValue;

  Response({
    this.orderId,
    this.firstname,
    this.lastname,
    this.status,
    this.dateAdded,
    this.total,
    this.currencyCode,
    this.currencyValue,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    orderId: json["order_id"] == null ? null : json["order_id"],
    firstname: json["firstname"] == null ? null : json["firstname"],
    lastname: json["lastname"] == null ? null : json["lastname"],
    status: json["status"] == null ? null : json["status"],
    dateAdded: json["date_added"] == null ? null : DateTime.parse(json["date_added"]),
    total: json["total"] == null ? null : json["total"],
    currencyCode: json["currency_code"] == null ? null : json["currency_code"],
    currencyValue: json["currency_value"] == null ? null : json["currency_value"],
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId == null ? null : orderId,
    "firstname": firstname == null ? null : firstname,
    "lastname": lastname == null ? null : lastname,
    "status": status == null ? null : status,
    "date_added": dateAdded == null ? null : dateAdded.toIso8601String(),
    "total": total == null ? null : total,
    "currency_code": currencyCode == null ? null : currencyCode,
    "currency_value": currencyValue == null ? null : currencyValue,
  };
}

// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  List<Response> response;
  int success;
  String message;

  LoginResponseModel({
    this.response,
    this.success,
    this.message,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
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
  String customerId;
  String firstname;
  String lastname;
  String email;
  String telephone;
  String password;
  dynamic cart;
  String addressId;
  String ip;
  String status;
  String approved;
  DateTime dateAdded;

  Response({
    this.customerId,
    this.firstname,
    this.lastname,
    this.email,
    this.telephone,
    this.password,
    this.cart,
    this.addressId,
    this.ip,
    this.status,
    this.approved,
    this.dateAdded,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    customerId: json["customer_id"] == null ? null : json["customer_id"],
    firstname: json["firstname"] == null ? null : json["firstname"],
    lastname: json["lastname"] == null ? null : json["lastname"],
    email: json["email"] == null ? null : json["email"],
    telephone: json["telephone"] == null ? null : json["telephone"],
    password: json["password"] == null ? null : json["password"],
    cart: json["cart"],
    addressId: json["address_id"] == null ? null : json["address_id"],
    ip: json["ip"] == null ? null : json["ip"],
    status: json["status"] == null ? null : json["status"],
    approved: json["approved"] == null ? null : json["approved"],
    dateAdded: json["date_added"] == null ? null : DateTime.parse(json["date_added"]),
  );

  Map<String, dynamic> toJson() => {
    "customer_id": customerId == null ? null : customerId,
    "firstname": firstname == null ? null : firstname,
    "lastname": lastname == null ? null : lastname,
    "email": email == null ? null : email,
    "telephone": telephone == null ? null : telephone,
    "password": password == null ? null : password,
    "cart": cart,
    "address_id": addressId == null ? null : addressId,
    "ip": ip == null ? null : ip,
    "status": status == null ? null : status,
    "approved": approved == null ? null : approved,
    "date_added": dateAdded == null ? null : dateAdded.toIso8601String(),
  };
}

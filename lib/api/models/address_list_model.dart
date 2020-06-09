// To parse this JSON data, do
//
//     final addressListModel = addressListModelFromJson(jsonString);

import 'dart:convert';

AddressListModel addressListModelFromJson(String str) {
  try{
    return AddressListModel.fromJson(json.decode(str));
  }catch(e){
    print('Json decode error - $e');
    return null;
  }

}

String addressListModelToJson(AddressListModel data) => json.encode(data.toJson());

class AddressListModel {
  List<Response> response;
  int success;
  String message;

  AddressListModel({
    this.response,
    this.success,
    this.message,
  });

  factory AddressListModel.fromJson(Map<String, dynamic> json) => AddressListModel(
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
  String addressId;
  String customerId;
  String firstname;
  String lastname;
  String company;
  String address1;
  String address2;
  String city;
  String postcode;
  String countryId;
  String zoneId;
  String customField;
  String companyId;
  String taxId;
  String telephone;
  String countryName;
  String zoneName;

  Response({
    this.addressId,
    this.customerId,
    this.firstname,
    this.lastname,
    this.company,
    this.address1,
    this.address2,
    this.city,
    this.postcode,
    this.countryId,
    this.zoneId,
    this.customField,
    this.companyId,
    this.taxId,
    this.telephone,
    this.countryName,
    this.zoneName,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    addressId: json["address_id"] == null ? null : json["address_id"],
    customerId: json["customer_id"] == null ? null : json["customer_id"],
    firstname: json["firstname"] == null ? null : json["firstname"],
    lastname: json["lastname"] == null ? null : json["lastname"],
    company: json["company"] == null ? null : json["company"],
    address1: json["address_1"] == null ? null : json["address_1"],
    address2: json["address_2"] == null ? null : json["address_2"],
    city: json["city"] == null ? null : json["city"],
    postcode: json["postcode"] == null ? null : json["postcode"],
    countryId: json["country_id"] == null ? null : json["country_id"],
    zoneId: json["zone_id"] == null ? null : json["zone_id"],
    customField: json["custom_field"] == null ? null : json["custom_field"],
    companyId: json["company_id"] == null ? null : json["company_id"],
    taxId: json["tax_id"] == null ? null : json["tax_id"],
    telephone: json["telephone"] == null ? null : json["telephone"],
    countryName: json["country_name"] == null ? null : json["country_name"],
    zoneName: json["zone_name"] == null ? null : json["zone_name"],
  );

  Map<String, dynamic> toJson() => {
    "address_id": addressId == null ? null : addressId,
    "customer_id": customerId == null ? null : customerId,
    "firstname": firstname == null ? null : firstname,
    "lastname": lastname == null ? null : lastname,
    "company": company == null ? null : company,
    "address_1": address1 == null ? null : address1,
    "address_2": address2 == null ? null : address2,
    "city": city == null ? null : city,
    "postcode": postcode == null ? null : postcode,
    "country_id": countryId == null ? null : countryId,
    "zone_id": zoneId == null ? null : zoneId,
    "custom_field": customField == null ? null : customField,
    "company_id": companyId == null ? null : companyId,
    "tax_id": taxId == null ? null : taxId,
    "telephone": telephone == null ? null : telephone,
    "country_name": countryName == null ? null : countryName,
    "zone_name": zoneName == null ? null : zoneName,
  };
}

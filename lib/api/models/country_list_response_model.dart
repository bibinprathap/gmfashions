// To parse this JSON data, do
//
//     final countryListResponseModel = countryListResponseModelFromJson(jsonString);

import 'dart:convert';

CountryListResponseModel countryListResponseModelFromJson(String str) {

  try{
    return CountryListResponseModel.fromJson(json.decode(str));

  }catch(e){
    print('json decode error - $e');
    return null;
  }


}

String countryListResponseModelToJson(CountryListResponseModel data) => json.encode(data.toJson());

class CountryListResponseModel {
  List<Response> response;
  int success;
  String message;

  CountryListResponseModel({
    this.response,
    this.success,
    this.message,
  });

  factory CountryListResponseModel.fromJson(Map<String, dynamic> json) => CountryListResponseModel(
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
  String countryId;
  String name;

  Response({
    this.countryId,
    this.name,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    countryId: json["country_id"] == null ? null : json["country_id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "country_id": countryId == null ? null : countryId,
    "name": name == null ? null : name,
  };
}

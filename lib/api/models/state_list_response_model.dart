// To parse this JSON data, do
//
//     final stateListResponseModel = stateListResponseModelFromJson(jsonString);

import 'dart:convert';

StateListResponseModel stateListResponseModelFromJson(String str) {
  try{
    return StateListResponseModel.fromJson(json.decode(str));

  }catch(e){
    print('json decode error - $e');
    return null;
  }
}

String stateListResponseModelToJson(StateListResponseModel data) => json.encode(data.toJson());

class StateListResponseModel {
  List<Response> response;
  int success;
  String message;

  StateListResponseModel({
    this.response,
    this.success,
    this.message,
  });

  factory StateListResponseModel.fromJson(Map<String, dynamic> json) => StateListResponseModel(
    response: json["response"] == false ? null : List<Response>.from(json["response"].map((x) => Response.fromJson(x))),
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
  String zoneId;
  String name;

  Response({
    this.zoneId,
    this.name,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    zoneId: json["zone_id"] == null ? null : json["zone_id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "zone_id": zoneId == null ? null : zoneId,
    "name": name == null ? null : name,
  };
}

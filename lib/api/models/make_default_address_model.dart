// To parse this JSON data, do
//
//     final makeDefaultResponseModel = makeDefaultResponseModelFromJson(jsonString);

import 'dart:convert';

MakeDefaultResponseModel makeDefaultResponseModelFromJson(String str) {
  try{
    return MakeDefaultResponseModel.fromJson(json.decode(str));
  }catch(e){
    print('Json decode error -$e');
    return null;
  }

}

String makeDefaultResponseModelToJson(MakeDefaultResponseModel data) => json.encode(data.toJson());

class MakeDefaultResponseModel {
  int response;
  int success;
  String message;

  MakeDefaultResponseModel({
    this.response,
    this.success,
    this.message,
  });

  factory MakeDefaultResponseModel.fromJson(Map<String, dynamic> json) => MakeDefaultResponseModel(
    response: json["response"] == false ? null : json["response"],
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "response": response == null ? null : response,
    "success": success == null ? null : success,
    "message": message == null ? null : message,
  };
}

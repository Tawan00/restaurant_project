// To parse this JSON data, do
//
//     final tkAddModel = tkAddModelFromJson(jsonString);

import 'dart:convert';

TkAddModel tkAddModelFromJson(String str) =>
    TkAddModel.fromJson(json.decode(str));

String tkAddModelToJson(TkAddModel data) => json.encode(data.toJson());

class TkAddModel {
  TkAddModel({
    this.message,
    this.token,
    this.accId,
    this.accName,
  });

  String message;
  String token;
  int accId;
  String accName;

  factory TkAddModel.fromJson(Map<String, dynamic> json) => TkAddModel(
        message: json["message"],
        token: json["token"],
        accId: json["acc_id"],
        accName: json["acc_name"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "token": token,
        "acc_id": accId,
        "acc_name": accName,
      };
}

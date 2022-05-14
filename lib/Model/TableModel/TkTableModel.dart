// To parse this JSON data, do
//
//     final tkTablesModel = tkTablesModelFromJson(jsonString);

import 'dart:convert';

TkTablesModel tkTablesModelFromJson(String str) =>
    TkTablesModel.fromJson(json.decode(str));

String tkTablesModelToJson(TkTablesModel data) => json.encode(data.toJson());

class TkTablesModel {
  TkTablesModel({
    this.message,
    this.token,
  });

  String message;
  String token;

  factory TkTablesModel.fromJson(Map<String, dynamic> json) => TkTablesModel(
        message: json["message"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "token": token,
      };
}

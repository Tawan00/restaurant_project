import 'dart:convert';

TkLoginModel tkLoginModelFromJson(String str) =>
    TkLoginModel.fromJson(json.decode(str));

String tkLoginModelToJson(TkLoginModel data) => json.encode(data.toJson());

class TkLoginModel {
  TkLoginModel({
    this.message,
    this.token,
    this.type,
    this.status,
  });

  String message;
  String token;
  int type;
  int status;

  factory TkLoginModel.fromJson(Map<String, dynamic> json) => TkLoginModel(
        message: json["message"],
        token: json["token"],
        type: json["acc_type"],
        status: json["acc_status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "token": token,
        "acc_type": type,
        "acc_status": status,
      };
}

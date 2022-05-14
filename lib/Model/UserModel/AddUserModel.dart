// To parse this JSON data, do
//
//     final adduserModel = adduserModelFromJson(jsonString);

import 'dart:convert';

AdduserModel adduserModelFromJson(String str) =>
    AdduserModel.fromJson(json.decode(str));

String adduserModelToJson(AdduserModel data) => json.encode(data.toJson());

class AdduserModel {
  AdduserModel({
    this.accName,
    this.accSname,
    this.accImg,
    this.accAddr,
    this.accTel,
    this.accEmail,
    this.accUser,
    this.accPass,
    this.accLine,
    this.accFb,
    this.accType,
    this.message,
  });

  String accName;
  String accSname;
  String accImg;
  String accAddr;
  String accTel;
  String accEmail;
  String accUser;
  String accPass;
  String accLine;
  String accFb;
  int accType;
  String message;

  factory AdduserModel.fromJson(Map<String, dynamic> json) => AdduserModel(
        accName: json["acc_name"],
        accSname: json["acc_sname"],
        accImg: json["acc_img"],
        accAddr: json["acc_addr"],
        accTel: json["acc_tel"],
        accEmail: json["acc_email"],
        accUser: json["acc_user"],
        accPass: json["acc_pass"],
        accLine: json["acc_line"],
        accFb: json["acc_fb"],
        accType: json["acc_type"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "acc_name": accName,
        "acc_sname": accSname,
        "acc_img": accImg,
        "acc_addr": accAddr,
        "acc_tel": accTel,
        "acc_email": accEmail,
        "acc_user": accUser,
        "acc_pass": accPass,
        "acc_line": accLine,
        "acc_fb": accFb,
        "acc_type": accType,
        "message": message,
      };
}

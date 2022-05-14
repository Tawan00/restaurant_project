// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

List<LoginModel> loginModelFromJson(String str) =>
    List<LoginModel>.from(json.decode(str).map((x) => LoginModel.fromJson(x)));

String loginModelToJson(List<LoginModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LoginModel {
  LoginModel({
    this.accId,
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
    this.accStatus,
  });

  int accId;
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
  int accStatus;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        accId: json["acc_id"],
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
        accStatus: json["acc_status"],
      );

  Map<String, dynamic> toJson() => {
        "acc_id": accId,
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
        "acc_status": accStatus,
      };
}

// To parse this JSON data, do
//
//     final storeModel = storeModelFromJson(jsonString);

import 'dart:convert';

List<StoreModel> storeModelFromJson(String str) =>
    List<StoreModel>.from(json.decode(str).map((x) => StoreModel.fromJson(x)));

String storeModelToJson(List<StoreModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StoreModel {
  StoreModel({
    this.shopName,
    this.shopMgName,
    this.shopMgSname,
    this.shopAddr,
    this.shopEmail,
    this.shopTel,
    this.shopOpentime,
    this.shopClosetime,
    this.shopStatus,
  });

  String shopName;
  String shopMgName;
  String shopMgSname;
  String shopAddr;
  String shopEmail;
  String shopTel;
  String shopOpentime;
  String shopClosetime;
  int shopStatus;

  factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
        shopName: json["shop_name"],
        shopMgName: json["shop_mg_name"],
        shopMgSname: json["shop_mg_sname"],
        shopAddr: json["shop_addr"],
        shopEmail: json["shop_email"],
        shopTel: json["shop_tel"],
        shopOpentime: json["shop_opentime"],
        shopClosetime: json["shop_closetime"],
        shopStatus: json["shop_status"],
      );

  Map<String, dynamic> toJson() => {
        "shop_name": shopName,
        "shop_mg_name": shopMgName,
        "shop_mg_sname": shopMgSname,
        "shop_addr": shopAddr,
        "shop_email": shopEmail,
        "shop_tel": shopTel,
        "shop_opentime": shopOpentime,
        "shop_closetime": shopClosetime,
        "shop_status": shopStatus,
      };
}

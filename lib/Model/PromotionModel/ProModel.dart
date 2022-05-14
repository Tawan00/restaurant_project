// To parse this JSON data, do
//
//     final promotionModel = promotionModelFromJson(jsonString);

import 'dart:convert';

List<PromotionModel> promotionModelFromJson(String str) =>
    List<PromotionModel>.from(
        json.decode(str).map((x) => PromotionModel.fromJson(x)));

String promotionModelToJson(List<PromotionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PromotionModel {
  PromotionModel({
    this.proId,
    this.proName,
    this.proDesc,
    this.proDiscount,
    this.proStartDate,
    this.proEndDate,
    this.proStatus,
  });

  int proId;
  String proName;
  String proDesc;
  int proDiscount;
  DateTime proStartDate;
  DateTime proEndDate;
  int proStatus;

  factory PromotionModel.fromJson(Map<String, dynamic> json) => PromotionModel(
        proId: json["pro_id"],
        proName: json["pro_name"],
        proDesc: json["pro_desc"],
        proDiscount: json["pro_discount"],
        proStartDate: DateTime.parse(json["pro_start_date"]),
        proEndDate: DateTime.parse(json["pro_end_date"]),
        proStatus: json["pro_status"],
      );

  Map<String, dynamic> toJson() => {
        "pro_id": proId,
        "pro_name": proName,
        "pro_desc": proDesc,
        "pro_discount": proDiscount,
        "pro_start_date": proStartDate.toIso8601String(),
        "pro_end_date": proEndDate.toIso8601String(),
        "pro_status": proStatus,
      };
}

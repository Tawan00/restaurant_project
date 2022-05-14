// To parse this JSON data, do
//
//     final proFoodModel = proFoodModelFromJson(jsonString);

import 'dart:convert';

List<ProFoodModel> proFoodModelFromJson(String str) => List<ProFoodModel>.from(
    json.decode(str).map((x) => ProFoodModel.fromJson(x)));

String proFoodModelToJson(List<ProFoodModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProFoodModel {
  ProFoodModel({
    this.pfId,
    this.proId,
    this.foodId,
    this.date,
  });

  int pfId;
  int proId;
  int foodId;
  DateTime date;

  factory ProFoodModel.fromJson(Map<String, dynamic> json) => ProFoodModel(
        pfId: json["pf_id"],
        proId: json["pro_id"],
        foodId: json["food_id"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "pf_id": pfId,
        "pro_id": proId,
        "food_id": foodId,
        "date": date.toIso8601String(),
      };
}

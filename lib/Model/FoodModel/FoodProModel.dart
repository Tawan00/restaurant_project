// To parse this JSON data, do
//
//     final foodProModel = foodProModelFromJson(jsonString);

import 'dart:convert';

List<FoodProModel> foodProModelFromJson(String str) => List<FoodProModel>.from(
    json.decode(str).map((x) => FoodProModel.fromJson(x)));

String foodProModelToJson(List<FoodProModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FoodProModel {
  FoodProModel({
    this.foodId,
    this.foodName,
    this.foodImg,
    this.foodPriceNew,
    this.proDiscount,
  });

  int foodId;
  String foodName;
  String foodImg;
  int foodPriceNew;
  int proDiscount;

  factory FoodProModel.fromJson(Map<String, dynamic> json) => FoodProModel(
        foodId: json["food_id"],
        foodName: json["food_name"],
        foodImg: json["food_img"],
        foodPriceNew: json["food_price_new"],
        proDiscount: json["pro_discount"],
      );

  Map<String, dynamic> toJson() => {
        "food_id": foodId,
        "food_name": foodName,
        "food_img": foodImg,
        "food_price_new": foodPriceNew,
        "pro_discount": proDiscount,
      };
}

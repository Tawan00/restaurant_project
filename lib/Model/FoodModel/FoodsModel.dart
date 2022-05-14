// To parse this JSON data, do
//
//     final foodsModel = foodsModelFromJson(jsonString);

import 'dart:convert';

List<FoodsModel> foodsModelFromJson(String str) =>
    List<FoodsModel>.from(json.decode(str).map((x) => FoodsModel.fromJson(x)));

String foodsModelToJson(List<FoodsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FoodsModel {
  FoodsModel(
      {this.foodId,
      this.fProId,
      this.typeId,
      this.foodName,
      this.foodImg,
      this.foodPrice,
      this.foodPriceNew,
      this.foodStatus});

  int foodId;
  int fProId;
  int typeId;
  String foodName;
  String foodImg;
  int foodPrice;
  int foodPriceNew;
  int foodStatus;

  factory FoodsModel.fromJson(Map<String, dynamic> json) => FoodsModel(
        foodId: json["food_id"],
        fProId: json["f_pro_id"],
        typeId: json["type_id"],
        foodName: json["food_name"],
        foodImg: json["food_img"],
        foodPrice: json["food_price"],
        foodPriceNew: json["food_price_new"],
        foodStatus: json["food_status"],
      );

  Map<String, dynamic> toJson() => {
        "food_id": foodId,
        "f_pro_id": fProId,
        "type_id": typeId,
        "food_name": foodName,
        "food_img": foodImg,
        "food_price": foodPrice,
        "food_price_new": foodPriceNew,
        "food_status": foodStatus,
      };
}

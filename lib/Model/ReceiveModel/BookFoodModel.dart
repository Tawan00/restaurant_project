import 'dart:convert';

BookFoodModel bookFoodModelFromJson(String str) =>
    BookFoodModel.fromJson(json.decode(str));

String bookFoodModelToJson(BookFoodModel data) => json.encode(data.toJson());

class BookFoodModel {
  BookFoodModel({
    this.bfId,
    this.foodId,
    this.boId,
    this.foodCount,
  });

  int bfId;
  int foodId;
  int boId;
  int foodCount;

  factory BookFoodModel.fromJson(Map<String, dynamic> json) => BookFoodModel(
        bfId: json["bf_id"],
        foodId: json["food_id"],
        boId: json["bo_id"],
        foodCount: json["food_count"],
      );

  Map<String, dynamic> toJson() => {
        "bf_id": bfId,
        "food_id": foodId,
        "bo_id": boId,
        "food_count": foodCount,
      };
}

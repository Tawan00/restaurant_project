// To parse this JSON data, do
//
//     final reviewModel = reviewModelFromJson(jsonString);

import 'dart:convert';

List<ReviewModel> reviewModelFromJson(String str) => List<ReviewModel>.from(
    json.decode(str).map((x) => ReviewModel.fromJson(x)));

String reviewModelToJson(List<ReviewModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReviewModel {
  ReviewModel({
    this.rvId,
    this.accId,
    this.rvDesc,
    this.rvScore,
    this.rvDate,
  });

  int rvId;
  int accId;
  String rvDesc;
  double rvScore;
  DateTime rvDate;

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
        rvId: json["rv_id"],
        accId: json["acc_id"],
        rvDesc: json["rv_desc"],
        rvScore: json["rv_score"].toDouble(),
        rvDate: DateTime.parse(json["rv_date"]),
      );

  Map<String, dynamic> toJson() => {
        "rv_id": rvId,
        "acc_id": accId,
        "rv_desc": rvDesc,
        "rv_score": rvScore,
        "rv_date": rvDate.toIso8601String(),
      };
}

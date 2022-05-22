// To parse this JSON data, do
//
//     final reviewAllModel = reviewAllModelFromJson(jsonString);

import 'dart:convert';

List<ReviewAllModel> reviewAllModelFromJson(String str) =>
    List<ReviewAllModel>.from(
        json.decode(str).map((x) => ReviewAllModel.fromJson(x)));

String reviewAllModelToJson(List<ReviewAllModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReviewAllModel {
  ReviewAllModel({
    this.rvId,
    this.accId,
    this.accName,
    this.accImg,
    this.rvDesc,
    this.rvDate,
    this.rvScore,
  });

  int rvId;
  int accId;
  String accName;
  String accImg;
  String rvDesc;
  DateTime rvDate;
  double rvScore;

  factory ReviewAllModel.fromJson(Map<String, dynamic> json) => ReviewAllModel(
        rvId: json["rv_id"],
        accId: json["acc_id"],
        accName: json["acc_name"],
        accImg: json["acc_img"],
        rvDesc: json["rv_desc"],
        rvDate: DateTime.parse(json["rv_date"]),
        rvScore: json["rv_score"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "rv_id": rvId,
        "acc_id": accId,
        "acc_name": accName,
        "acc_img": accImg,
        "rv_desc": rvDesc,
        "rv_date": rvDate.toIso8601String(),
        "rv_score": rvScore,
      };
}

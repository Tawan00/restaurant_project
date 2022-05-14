// To parse this JSON data, do
//
//     final typeFoodsModel = typeFoodsModelFromJson(jsonString);

import 'dart:convert';

List<TypeFoodsModel> typeFoodsModelFromJson(String str) =>
    List<TypeFoodsModel>.from(
        json.decode(str).map((x) => TypeFoodsModel.fromJson(x)));

String typeFoodsModelToJson(List<TypeFoodsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TypeFoodsModel {
  TypeFoodsModel({
    this.tfId,
    this.tfName,
  });

  int tfId;
  String tfName;

  factory TypeFoodsModel.fromJson(Map<String, dynamic> json) => TypeFoodsModel(
        tfId: json["tf_id"],
        tfName: json["tf_name"],
      );

  Map<String, dynamic> toJson() => {
        "tf_id": tfId,
        "tf_name": tfName,
      };
}

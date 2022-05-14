import 'dart:convert';

EditModel editModelFromJson(String str) => EditModel.fromJson(json.decode(str));

String edituserModelToJson(EditModel data) => json.encode(data.toJson());

class EditModel {
  EditModel({
    this.message,
  });

  String message;

  factory EditModel.fromJson(Map<String, dynamic> json) => EditModel(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}

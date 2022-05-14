import 'dart:convert';

EditUserModel edituserModelFromJson(String str) =>
    EditUserModel.fromJson(json.decode(str));

String edituserModelToJson(EditUserModel data) => json.encode(data.toJson());

class EditUserModel {
  EditUserModel({
    this.message,
  });

  String message;

  factory EditUserModel.fromJson(Map<String, dynamic> json) => EditUserModel(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}

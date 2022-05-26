import 'dart:convert';

List<ReceiptModel> receiptModelFromJson(String str) => List<ReceiptModel>.from(json.decode(str).map((x) => ReceiptModel.fromJson(x)));

String receiptModelToJson(List<ReceiptModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReceiptModel {
  ReceiptModel({
    this.boId,
    this.btId,
    this.date,
  });

  int boId;
  int btId;
  DateTime date;

  factory ReceiptModel.fromJson(Map<String, dynamic> json) => ReceiptModel(
    boId: json["bo_id"],
    btId: json["bt_id"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "bo_id": boId,
    "bt_id": btId,
    "date": date.toIso8601String(),
  };
}
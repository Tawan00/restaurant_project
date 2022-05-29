// To parse this JSON data, do
//
//     final myOrderModel = myOrderModelFromJson(jsonString);

import 'dart:convert';

List<MyOrderModel> myOrderModelFromJson(String str) => List<MyOrderModel>.from(
    json.decode(str).map((x) => MyOrderModel.fromJson(x)));

String myOrderModelToJson(List<MyOrderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyOrderModel {
  MyOrderModel({
    this.btId,
    this.boId,
    this.tbId,
    this.accName,
    this.btCount,
    this.btStartTime,
    this.btEndTime,
    this.btDateCheckIn,
    this.btDate,
    this.foodName,
    this.foodCount,
    this.btTotal,
    this.btStatus,
  });

  int btId;
  int boId;
  int tbId;
  String accName;
  int btCount;
  String btStartTime;
  String btEndTime;
  String btDateCheckIn;
  DateTime btDate;
  String foodName;
  int foodCount;
  int btTotal;
  int btStatus;

  factory MyOrderModel.fromJson(Map<String, dynamic> json) => MyOrderModel(
        btId: json["bt_id"],
        boId: json["bo_id"],
        tbId: json["tb_id"],
        accName: json["acc_name"],
        btCount: json["bt_count"],
        btStartTime: json["bt_start_time"],
        btEndTime: json["bt_end_time"],
        btDateCheckIn: json["bt_date_check_in"],
        btDate: DateTime.parse(json["bt_date"]),
        foodName: json["food_name"],
        foodCount: json["food_count"],
        btTotal: json["bt_total"],
        btStatus: json["bt_status"],
      );

  Map<String, dynamic> toJson() => {
        "bt_id": btId,
        "bo_id": boId,
        "tb_id": tbId,
        "acc_name": accName,
        "bt_count": btCount,
        "bt_start_time": btStartTime,
        "bt_end_time": btEndTime,
        "bt_date_check_in": btDateCheckIn,
        "bt_date": btDate.toIso8601String(),
        "food_name": foodName,
        "food_count": foodCount,
        "bt_total": btTotal,
        "bt_status": btStatus,
      };

  toLowerCase() {}
}

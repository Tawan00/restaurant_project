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
    this.accId,
    this.tbId,
    this.btCount,
    this.btDate,
    this.btStartTime,
    this.btEndTime,
    this.btDateCheckIn,
    this.btTel,
    this.btTotal,
    this.btStatus,
  });

  int btId;
  int accId;
  int tbId;
  int btCount;
  DateTime btDate;
  String btStartTime;
  String btEndTime;
  String btDateCheckIn;
  String btTel;
  int btTotal;
  int btStatus;

  factory MyOrderModel.fromJson(Map<String, dynamic> json) => MyOrderModel(
        btId: json["bt_id"],
        accId: json["acc_id"],
        tbId: json["tb_id"],
        btCount: json["bt_count"],
        btDate: DateTime.parse(json["bt_date"]),
        btStartTime: json["bt_start_time"],
        btEndTime: json["bt_end_time"],
        btDateCheckIn: json["bt_date_check_in"],
        btTel: json["bt_tel"],
        btTotal: json["bt_total"],
        btStatus: json["bt_status"],
      );

  Map<String, dynamic> toJson() => {
        "bt_id": btId,
        "acc_id": accId,
        "tb_id": tbId,
        "bt_count": btCount,
        "bt_date": btDate.toIso8601String(),
        "bt_start_time": btStartTime,
        "bt_end_time": btEndTime,
        "bt_date_check_in": btDateCheckIn,
        "bt_tel": btTel,
        "bt_total": btTel,
        "bt_status": btStatus,
      };
}

import 'dart:convert';

List<OrderModel> orderModelFromJson(String str) =>
    List<OrderModel>.from(json.decode(str).map((x) => OrderModel.fromJson(x)));

String orderModelToJson(List<OrderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderModel {
  OrderModel({
    this.accId,
    this.accName,
    this.btId,
    this.btCount,
    this.btDate,
    this.btDateCheckIn,
    this.btStartTime,
    this.btEndTime,
  });

  int accId;
  String accName;
  int btId;
  int btCount;
  String btDate;
  String btDateCheckIn;
  String btStartTime;
  String btEndTime;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        accId: json["acc_id"],
        accName: json["acc_name"],
        btId: json["bt_id"],
        btDate: json["bt_date"],
        btCount: json["bt_count"],
        btDateCheckIn: json["bt_date_check_in"],
        btStartTime: json["bt_start_time"],
        btEndTime: json["bt_end_time"],
      );

  Map<String, dynamic> toJson() => {
        "acc_id": accId,
        "acc_name": accName,
        "bt_id": btId,
        "bt_count": btCount,
        "bt_date": btDate,
        "bt_date_check_in": btDateCheckIn,
        "bt_start_time": btStartTime,
        "bt_end_time": btEndTime,
      };
}

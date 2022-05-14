import 'dart:convert';

List<TablesModel> tablesModelFromJson(String str) => List<TablesModel>.from(
    json.decode(str).map((x) => TablesModel.fromJson(x)));

String tablesModelToJson(List<TablesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TablesModel {
  TablesModel({
    this.accId,
    this.tbId,
    this.btCount,
    this.btDate,
    this.btStartTime,
    this.btEndTime,
    this.btDateCheckIn,
    this.btTel,
    this.btStatus,
    this.message,
  });

  int accId;
  int tbId;
  int btCount;
  String btDate;
  String btStartTime;
  String btEndTime;
  String btDateCheckIn;
  String btTel;
  int btStatus;
  String message;

  factory TablesModel.fromJson(Map<String, dynamic> json) => TablesModel(
      accId: json["acc_id"],
      tbId: json["tb_id"],
      btCount: json["bt_count"],
      btDate: json["bt_date"],
      btStartTime: json["bt_start_time"],
      btEndTime: json["bt_end_time"],
      btDateCheckIn: json["bt_date_check_in"],
      btTel: json["bt_tel"],
      btStatus: json["bt_status"],
      message: json["message"]);

  Map<String, dynamic> toJson() => {
        "acc_id": accId,
        "tb_id": tbId,
        "bt_count": btCount,
        "bt_date": btDate,
        "bt_start_time": btStartTime,
        "bt_end_time": btEndTime,
        "bt_date_check_in": btDateCheckIn,
        "bt_tel": btTel,
        "bt_status": btStatus,
        "message": message,
      };
}

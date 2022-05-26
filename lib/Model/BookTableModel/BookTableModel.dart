import 'dart:convert';

List<BookTableModel> bookTableModelFromJson(String str) => List<BookTableModel>.from(json.decode(str).map((x) => BookTableModel.fromJson(x)));

String bookTableModelToJson(List<BookTableModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookTableModel {
  BookTableModel({
    this.btId,
    this.accId,
    this.tbId,
    this.btCount,
    this.btDate,
    this.btStartTime,
    this.btEndTime,
    this.btDateCheckIn,
    this.btTel,
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
  BtTel btTel;
  int btStatus;

  factory BookTableModel.fromJson(Map<String, dynamic> json) => BookTableModel(
    btId: json["bt_id"],
    accId: json["acc_id"] == null ? null : json["acc_id"],
    tbId: json["tb_id"] == null ? null : json["tb_id"],
    btCount: json["bt_count"],
    btDate: DateTime.parse(json["bt_date"]),
    btStartTime: json["bt_start_time"],
    btEndTime: json["bt_end_time"],
    btDateCheckIn: json["bt_date_check_in"],
    btTel: btTelValues.map[json["bt_tel"]],
    btStatus: json["bt_status"],
  );

  Map<String, dynamic> toJson() => {
    "bt_id": btId,
    "acc_id": accId == null ? null : accId,
    "tb_id": tbId == null ? null : tbId,
    "bt_count": btCount,
    "bt_date": btDate.toIso8601String(),
    "bt_start_time": btStartTime,
    "bt_end_time": btEndTime,
    "bt_date_check_in": btDateCheckIn,
    "bt_tel": btTelValues.reverse[btTel],
    "bt_status": btStatus,
  };
}

enum BtTel { THE_0990269620, EMPTY, THE_0922, THE_0982259465, THE_09822, THE_0123456789 }

final btTelValues = EnumValues({
  "": BtTel.EMPTY,
  "0123456789": BtTel.THE_0123456789,
  "0922": BtTel.THE_0922,
  "09822": BtTel.THE_09822,
  "0982259465": BtTel.THE_0982259465,
  "0990269620": BtTel.THE_0990269620
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}

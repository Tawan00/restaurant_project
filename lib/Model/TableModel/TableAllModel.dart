import 'dart:convert';

List<TableAllModel> tableallModelFromJson(String str) =>
    List<TableAllModel>.from(
        json.decode(str).map((x) => TableAllModel.fromJson(x)));

String tableallModelToJson(List<TableAllModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TableAllModel {
  TableAllModel({
    this.tbId,
    this.tbNumber,
    this.tbCount,
    this.tbStatus,
  });

  int tbId;
  int tbNumber;
  int tbCount;
  int tbStatus;

  factory TableAllModel.fromJson(Map<String, dynamic> json) => TableAllModel(
      tbId: json["tb_id"],
      tbNumber: json["tb_number"],
      tbCount: json["tb_count"],
      tbStatus: json["tb_status"]);

  Map<String, dynamic> toJson() => {
        "tb_id": tbId,
        "tb_number": tbNumber,
        "tb_count": tbCount,
        "tb_status": tbStatus,
      };
}

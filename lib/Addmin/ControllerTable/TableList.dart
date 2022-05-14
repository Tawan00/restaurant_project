import 'package:restaurant_project/Addmin/ControllerTable/addTable.dart';
import 'package:restaurant_project/Addmin/ControllerTable/editTable.dart';
import 'package:restaurant_project/Addmin/MainAdmin.dart';
import 'package:restaurant_project/Model/MessageModel.dart';
import 'package:restaurant_project/Model/TableModel/TableAllModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class TableList extends StatefulWidget {
  @override
  _TableListState createState() => _TableListState();
}

class _TableListState extends State<TableList> {
  @override
  void initState() {
    super.initState();
    GetTable();
  }

  List<String> tablestatus;
  List<String> tempArray = [];
  List<TableAllModel> _tableallModel;
  Future<Null> GetTable() async {
    var url = "http://itoknode@itoknode.comsciproject.com/table/ShowTable";
    final response = await http.get(Uri.parse(url));
    //print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() {
        final String responseString = response.body;
        _tableallModel = tableallModelFromJson(responseString);
      });
      print(_tableallModel.length);
    }
  }

  Future<MessageModel> updateNewstatus(String tb_id, String tb_status) async {
    final url = "http://itoknode.comsciproject.com/table/UpdateStatusTable";
    final response = await http
        .post(Uri.parse(url), body: {"tb_id": tb_id, "tb_status": tb_status});
    if (response.statusCode == 200) {
      String responseString = response.body;
      return messageModelFromJson(responseString);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFCFAF8),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "จัดการข้อมูลโต๊ะ",
          style: GoogleFonts.kanit(textStyle: TextStyle(color: Colors.black)),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => MainAdmin()));
            // Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AddTable()));
            },
          ),
        ],
      ),
      body: (_tableallModel == null)
          ? Material(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Text(
                      //   "Initialization",
                      //   style: TextStyle(
                      //     fontSize: 32,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // SizedBox(height: 20),
                      CircularProgressIndicator()
                    ],
                  ),
                ],
              ),
            )
          : ListView(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: [
                          DataColumn(
                              label: Text(
                            'โต๊ะที่',
                            style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                    color: Color(0xFFD17E50),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600)),
                          )),
                          DataColumn(
                              label: Text(
                            'สถานะ',
                            style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                    color: Color(0xFFD17E50),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600)),
                          )),
                          DataColumn(
                              label: Text(
                            'แก้ไข',
                            style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                    color: Color(0xFFD17E50),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600)),
                          )),
                        ],
                        rows: List<DataRow>.generate(
                            _tableallModel.length,
                            (index) => DataRow(
                                  cells: <DataCell>[
                                    DataCell(Center(
                                      child: Text(
                                        '${_tableallModel[index].tbId}',
                                        style: GoogleFonts.kanit(
                                            textStyle:
                                                TextStyle(color: Colors.black)),
                                      ),
                                    )),
                                    DataCell(
                                      Center(
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: LiteRollingSwitch(
                                              value: (_tableallModel[index]
                                                          .tbStatus !=
                                                      0)
                                                  ? false
                                                  : true,
                                              textOn: "ว่าง",
                                              textOff: "ไม่ว่าง",
                                              colorOn: Colors.green,
                                              colorOff: Colors.redAccent,
                                              iconOn: Icons.done,
                                              iconOff: Icons.alarm_off,
                                              textSize: 13.0,
                                              onChanged: (bool position) async {
                                                if (position == true) {
                                                  final MessageModel UPDATE =
                                                      await updateNewstatus(
                                                          _tableallModel[index]
                                                              .tbId
                                                              .toString(),
                                                          "0");
                                                  if (UPDATE.message ==
                                                      'Success') {
                                                    print("Updete Success");
                                                  } else {
                                                    print('Update Failed');
                                                  }
                                                } else {
                                                  final MessageModel UPDATE =
                                                      await updateNewstatus(
                                                          _tableallModel[index]
                                                              .tbId
                                                              .toString(),
                                                          "1");
                                                  if (UPDATE.message ==
                                                      'Success') {
                                                    print("Updete Success");
                                                  } else {
                                                    print('Update Failed');
                                                  }
                                                }

                                                // if (position == true) {
                                                //   final MessageModel UPDATE =
                                                //       await updateStatus("1");
                                                //   if (UPDATE.message ==
                                                //       "Success") {
                                                //     print("Updete Success");
                                                //   } else {
                                                //     print('Update Failed');
                                                //   }
                                                // } else {
                                                //   final MessageModel UPDATE =
                                                //       await updateStatus("0");
                                                //   if (UPDATE.message ==
                                                //       "Success") {
                                                //     print("Updete Success");
                                                //   } else {
                                                //     print('Update Failed');
                                                //   }
                                                // }
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(Center(
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.edit,
                                          color: Colors.green[600],
                                        ),
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      editTable(
                                                          tb_id: _tableallModel[
                                                                  index]
                                                              .tbId,
                                                          tb_count:
                                                              _tableallModel[
                                                                      index]
                                                                  .tbCount,
                                                          tb_status:
                                                              _tableallModel[
                                                                      index]
                                                                  .tbStatus)));
                                        },
                                      ),
                                    )),
                                  ],
                                )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

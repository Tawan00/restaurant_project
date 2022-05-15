import 'package:restaurant_project/Addmin/ControllerOrder/TableOrderList.dart';
import 'package:restaurant_project/Model/AEModel/EditModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_project/Model/TableModel/TableAllModel.dart';

class editOrder extends StatefulWidget {
  @override
  _editOrderState createState() => _editOrderState();
  int id;
  String name;
  int person;
  var checkin;
  var starttime;
  var endtime;

  editOrder(
      {this.id,
      this.name,
      this.person,
      this.checkin,
      this.starttime,
      this.endtime});
}

class _editOrderState extends State<editOrder> {
  @override
  void initState() {
    super.initState();
    GetTable();
    btId.text = this.widget.id.toString();
    btCount.text = this.widget.person.toString();
    //tbcheckin.text = this.widget.checkin;
    accName.text = this.widget.name;
    dateslit = this.widget.checkin.toString();
    dt = dateslit.split("T");
    tbcheckin.text =
        "${dt[0]} / ${this.widget.starttime} / ${this.widget.endtime}";
  }

  var dateslit;
  var dt;
  var btId = TextEditingController();
  var accName = TextEditingController();
  var btCount = TextEditingController();
  var tbtel = TextEditingController();
  var tbcheckin = TextEditingController();
  var tbtable = TextEditingController();
  int selectvalue;
  String dropdownValue = 'เลือกโต๊ะ';
  List numbertable;

  Future<EditModel> EditOrder(String bt_id, String tb_id) async {
    final String url =
        "http://itoknode@itoknode.comsciproject.com/bookor/UpdateOrder";
    final response = await http.post(Uri.parse(url), body: {
      "bt_id": bt_id,
      "tb_id": tb_id,
    });

    print(response.statusCode);
    if (response.statusCode == 200) {
      String responseString = response.body;
      return editModelFromJson(responseString);
    } else {
      return null;
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent[400],
        elevation: 0,
        centerTitle: true,
        title: Text(
          "ยืนยันการสั่งจองโต๊ะ",
          style: GoogleFonts.prompt(textStyle: TextStyle(color: Colors.white)),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => TableOrderList()));
          },
        ),
      ),
      body: (_tableallModel == null)
          ? Material(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[CircularProgressIndicator()],
                  ),
                ],
              ),
            )
          : ListView(
              children: [
                Container(
                  height: 550,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 16.0, bottom: 16.0, left: 16.0, right: 16.0),
                    child: InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3.0,
                                  blurRadius: 5.0),
                            ],
                            color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 15.0, left: 20.0),
                                          child: Text(
                                            'ชื่อ',
                                            style: GoogleFonts.kanit(
                                              textStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15.0),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            child: TextField(
                                              controller: accName,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 20.0),
                                          child: Text(
                                            'จำนวนคน',
                                            style: GoogleFonts.kanit(
                                              textStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15.0),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            child: TextField(
                                              controller: btCount,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 20.0),
                                          child: Text(
                                            "วัน-เวลาเช็คอิน",
                                            style: GoogleFonts.kanit(
                                              textStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15.0),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            child: TextField(
                                              controller: tbcheckin,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 16.0,
                                          bottom: 16.0,
                                          right: 60,
                                          left: 60),
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: 16.0, right: 16.0),
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(15.0)),
                                        child: DropdownButton(
                                          hint: Text("เลือกโต๊ะ"),
                                          dropdownColor: Colors.white,
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.black,
                                          ),
                                          iconSize: 24,
                                          isExpanded: true,
                                          style: const TextStyle(
                                              color: Colors.black),
                                          underline: SizedBox(),
                                          value: selectvalue,
                                          items:
                                              _tableallModel.map((valueItem) {
                                            if (valueItem.tbId
                                                .toString()
                                                .isEmpty) {
                                            } else {
                                              return DropdownMenuItem(
                                                value: valueItem.tbId,
                                                child: Text(
                                                    valueItem.tbId.toString()),
                                              );
                                            }
                                          }).toList(),
                                          onChanged: (newValue) {
                                            setState(() {
                                              selectvalue = newValue;
                                              tbtable.text =
                                                  newValue.toString();
                                              print(tbtable.text);
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 120,
                      height: 45,
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: Colors.blue,
                        child: Text(
                          'บันทึก',
                          style: GoogleFonts.kanit(
                              textStyle: TextStyle(color: Colors.white)),
                        ),
                        onPressed: () async {
                          final EditModel edit =
                              await EditOrder(btId.text, tbtable.text);
                          if (edit.message == "Success") {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => TableOrderList()));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}

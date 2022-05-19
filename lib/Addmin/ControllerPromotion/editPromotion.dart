import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_project/Addmin/ControllerPromotion/ListPromotion.dart';
import 'package:restaurant_project/Model/AEModel/EditModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'dialogPro.dart';

class editPro extends StatefulWidget {
  @override
  _editProState createState() => _editProState();
  int pro_id;
  String pro_name;
  String pro_desc;
  int pro_discount;
  String pro_start_date;
  String pro_end_date;
  int pro_status;

  editPro(
      {this.pro_id,
      this.pro_name,
      this.pro_desc,
      this.pro_discount,
      this.pro_start_date,
      this.pro_end_date,
      this.pro_status});
}

class _editProState extends State<editPro> {
  DateTime ConDateStart;
  DateTime ConDateEnd;
  var startdate;
  var enddate;

  @override
  void initState() {
    super.initState();
    proId.text = this.widget.pro_id.toString();
    proName.text = this.widget.pro_name;
    proDesc.text = this.widget.pro_desc;
    proDis.text = this.widget.pro_discount.toString();
    proStatus.text = this.widget.pro_status.toString();
    ConvertDate();

    print("A:"+startdate);
    print("B:"+enddate);
    st = startdate;
    et = enddate;
  }

  void ConvertDate(){
    ConDateStart = DateFormat("yyyy-MM-dd").parse(widget.pro_start_date);
    ConDateEnd = DateFormat("yyyy-MM-dd").parse(widget.pro_end_date);
    startdate = DateFormat("yyyy-MM-dd").format(ConDateStart);
    enddate = DateFormat("yyyy-MM-dd").format(ConDateStart);
  }

  Color greenColor = Color(0xFF5B8842);
  Color orangeColor = Color(0xFFF17532);
  var proId = TextEditingController();
  var proName = TextEditingController();
  var proDesc = TextEditingController();
  var proDis = TextEditingController();
  var proStart = TextEditingController();
  var proEnd = TextEditingController();
  var proStatus = TextEditingController();

  var sd;
  var ed;
  String dropdownValue = 'เปิดใช้งาน';
  List<String> typestatus = ["เปิดใช้งาน", "ปิดใช้งาน"];

  Future<EditModel> Edit(
      String proId,
      String proName,
      String proDesc,
      String proDiscount,
      String proStartDate,
      String proEndDate,
      String proStatus) async {
    final String url =
        "http://itoknode@itoknode.comsciproject.com/pro/UpdatePro";
    final response = await http.post(Uri.parse(url), body: {
      "pro_id": proId,
      "pro_name": proName,
      "pro_desc": proDesc,
      "pro_discount": proDiscount,
      "pro_start_date": proStartDate,
      "pro_end_date": proEndDate,
      "pro_status": proStatus
    });

    print(response.statusCode);
    if (response.statusCode == 200) {
      String responseString = response.body;
      return editModelFromJson(responseString);
    } else {
      String responseString = response.body;
      return editModelFromJson(responseString);
    }
  }

  DateTime date = DateTime.now();
  DateTime date2 = DateTime.now();
  var st;
  var et;

  Future<Null> selectTimePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime.now().subtract(Duration(days: 0)),
        lastDate: DateTime(2030));
    if (picked != null && picked != date) {
      setState(() {
        date = picked;
        st = "${date.year}-${date.month}-${date.day}";
        proStart.text = "${date.year}-${date.month}-${date.day}";
        print("date " + st);
      });
    }
  }

  Future<Null> selectTimePicker2(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: date2,
        firstDate: DateTime.now().subtract(Duration(days: 0)),
        lastDate: DateTime(2030));
    if (picked != null && picked != date2) {
      setState(() {
        date2 = picked;
        et = "${date2.year}-${date2.month}-${date2.day}";
        proEnd.text = "${date.year}-${date.month}-${date.day}";
        print("date " + et);
      });
    }
  }

////////////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: orangeColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "แก้ไขข้อมูลโปรโมชัน",
          style: GoogleFonts.prompt(textStyle: TextStyle(color: Colors.white)),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ListPro()));
          },
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: 600,
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
                        padding: EdgeInsets.only(top: 15.0, left: 20.0),
                        child: Text(
                          'ชื่อ',
                          style: GoogleFonts.kanit(
                            textStyle:
                                TextStyle(color: Colors.black, fontSize: 15.0),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: TextField(
                            controller: proName,
                            decoration: InputDecoration(
                                labelStyle: GoogleFonts.kanit(
                                    textStyle:
                                        TextStyle(color: Colors.green[700])),
                                fillColor: Colors.black12,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          'รายละเอียด',
                          style: GoogleFonts.kanit(
                            textStyle:
                                TextStyle(color: Colors.black, fontSize: 15.0),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: TextField(
                            controller: proDesc,
                            decoration: InputDecoration(
                                labelStyle: GoogleFonts.kanit(
                                    textStyle:
                                        TextStyle(color: Colors.green[700])),
                                fillColor: Colors.black12,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          'ส่วนลด %',
                          style: GoogleFonts.kanit(
                            textStyle:
                                TextStyle(color: Colors.black, fontSize: 15.0),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: TextField(
                            controller: proDis,
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(3)
                            ],
                            decoration: InputDecoration(
                                labelStyle: GoogleFonts.kanit(
                                    textStyle:
                                        TextStyle(color: Colors.green[700])),
                                fillColor: Colors.black12,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Container(
                          color: orangeColor,
                          height: 1.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: Text(
                                st,
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                      fontSize: 15.0, color: Colors.black),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Text(
                                et,
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                      fontSize: 15.0, color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // SizedBox(
                            //   width: 10,
                            // ),
                            Container(
                              height: 30,
                              width: 70,
                              child: IconButton(
                                icon: Icon(Icons.calendar_today_outlined),
                                onPressed: () {
                                  selectTimePicker(context);
                                },
                              ),
                            ),
                            Container(
                              height: 30,
                              width: 70,
                              child: IconButton(
                                icon: Icon(Icons.alarm),
                                onPressed: () {
                                  selectTimePicker2(context);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          'สถานะ',
                          style: GoogleFonts.kanit(
                            textStyle:
                                TextStyle(color: Colors.black, fontSize: 15.0),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 30, right: 30, top: 5, bottom: 10),
                        child: Container(
                          padding: EdgeInsets.only(left: 16.0, right: 16.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(15.0)),
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                            ),
                            iconSize: 24,
                            isExpanded: true,
                            style: const TextStyle(color: Colors.black),
                            underline: SizedBox(),
                            onChanged: (value) {
                              setState(() {
                                dropdownValue = value;
                                proStatus.text =
                                    typestatus.indexOf(value).toString();
                                print(proStatus.text);
                              });
                            },
                            items: typestatus
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 120,
                            height: 45,
                            child: GestureDetector(
                              onTap: () async {
                                proStart.text = st;
                                proEnd.text = et;

                                print(proStart.text);
                                print(proEnd.text);
                                if (proName.text.isEmpty ||
                                    proDesc.text.isEmpty ||
                                    proDis.text.isEmpty ||
                                    proStart.text.isEmpty ||
                                    proEnd.text.isEmpty) {
                                  showEnterDialog(context);
                                } else {
                                  DateTime statDate =
                                      new DateFormat("yyyy-MM-dd")
                                          .parse(proStart.text);
                                  DateTime endDate =
                                      new DateFormat("yyyy-MM-dd")
                                          .parse(proEnd.text);

                                  if(int.parse(proDis.text)>100){
                                    showProDisDialog(context);
                                  }
                                  else if (endDate.isBefore(statDate)) {
                                    showDateDialog(context);
                                  }else{
                                    final EditModel edit = await Edit(
                                        proId.text,
                                        proName.text,
                                        proDesc.text,
                                        proDis.text,
                                        proStart.text,
                                        proEnd.text,
                                        proStatus.text);
                                    if (edit.message == "Success") {
                                      showEditPassDialog(context);
                                    } else {
                                      showEditFailDialog(context);
                                    }
                                  }
                                }
                              },
                              child: Container(
                                height: 50,
                                child: Material(
                                  borderRadius: BorderRadius.circular(25.0),
                                  shadowColor: Colors.orangeAccent,
                                  color: orangeColor,
                                  elevation: 7.0,
                                  child: Center(
                                    child: Text(
                                      'ตกลง',
                                      style: GoogleFonts.kanit(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

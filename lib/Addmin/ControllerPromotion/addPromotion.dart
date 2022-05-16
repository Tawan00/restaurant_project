import 'package:restaurant_project/Addmin/ControllerPromotion/ListPromotion.dart';
import 'package:restaurant_project/Model/AEModel/TkAddModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class AddPro extends StatefulWidget {
  @override
  _AddProState createState() => _AddProState();
}

class _AddProState extends State<AddPro> {
  Future<TkAddModel> Add(String pro_name, String pro_desc, String pro_discount,
      String pro_start_date, String pro_end_date, String pro_status) async {
    final String url = "http://itoknode@itoknode.comsciproject.com/pro/AddPro";
    final response = await http.post(Uri.parse(url), body: {
      "pro_name": pro_name,
      "pro_desc": pro_desc,
      "pro_discount": pro_discount,
      "pro_start_date": pro_start_date,
      "pro_end_date": pro_end_date,
      "pro_status": pro_status
    });

    print(response.statusCode);
    if (response.statusCode == 200) {
      String responseString = response.body;
      return tkAddModelFromJson(responseString);
    } else {
      return null;
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
        firstDate: DateTime(1940),
        lastDate: DateTime(2030));
    if (picked != null && picked != date) {
      setState(() {
        date = picked;
        st = "${date.year}-${date.month}-${date.day}";
        print("date " + st);
      });
    }
  }

  Future<Null> selectTimePicker2(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: date2,
        firstDate: DateTime(1940),
        lastDate: DateTime(2030));
    if (picked != null && picked != date2) {
      setState(() {
        date2 = picked;
        et = "${date2.year}-${date2.month}-${date2.day}";
        print("date " + et);
      });
    }
  }

  Color greenColor = Color(0xFF5B8842);
  Color orangeColor = Color(0xFFF17532);
  var proName = TextEditingController();
  var proDesc = TextEditingController();
  var proDis = TextEditingController();
  var proStart = TextEditingController();
  var proEnd = TextEditingController();
  var proStatus = TextEditingController();
  String dropdownValue = 'เปิดใช้งาน';
  List<String> typestatus = ["เปิดใช้งาน", "ปิดใช้งาน"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: orangeColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "เพิ่มโปรโมชัน",
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
                                child: (proStart.text == null ||
                                        proStart.text == "")
                                    ? Text(
                                        "${date.year}-${date.month}-${date.day}",
                                        style: GoogleFonts.kanit(
                                          textStyle: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black),
                                        ),
                                      )
                                    : Text(
                                        "เลือกวันที่",
                                        style: GoogleFonts.kanit(
                                          textStyle: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black),
                                        ),
                                      )),
                            Container(
                                margin: EdgeInsets.only(left: 20),
                                child:
                                    (proEnd.text == null || proEnd.text == "")
                                        ? Text(
                                            "${date2.year}-${date2.month}-${date2.day}",
                                            style: GoogleFonts.kanit(
                                              textStyle: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.black),
                                            ),
                                          )
                                        : Text(
                                            "เลือกวันที่",
                                            style: GoogleFonts.kanit(
                                              textStyle: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.black),
                                            ),
                                          )),
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
                                icon: Icon(Icons.calendar_today_outlined),
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
                            left: 30, right: 30, top: 5, bottom: 20),
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

                                final TkAddModel add = await Add(
                                    proName.text,
                                    proDesc.text,
                                    proDis.text,
                                    proStart.text,
                                    proEnd.text,
                                    proStatus.text);
                                if (add.message == "Success") {
                                  showPassDialog();
                                } else {
                                  showFaildDialog();
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

  Future showPassDialog() => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Center(
              child: Text(
            'เพิ่มข้อมูลเสร็จสมบูรณ์',
            style: GoogleFonts.kanit(
                textStyle: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w600)),
          )),
          actions: [
            FlatButton(
              child: Text(
                'ตกลง',
                style: GoogleFonts.kanit(
                    textStyle: TextStyle(
                  color: Colors.green[700],
                  fontWeight: FontWeight.w600,
                )),
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => ListPro()));
              },
            )
          ],
        ),
      );
  Future showFaildDialog() => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Center(
              child: Text(
            'มีข้อมูลอยู่แล้ว ไม่สามารถเพิ่มไขได้',
            style: GoogleFonts.kanit(
                textStyle: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w600)),
          )),
          actions: [
            FlatButton(
              child: Text(
                'ตกลง',
                style: GoogleFonts.kanit(
                    textStyle: TextStyle(
                  color: Colors.green[700],
                  fontWeight: FontWeight.w600,
                )),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
}

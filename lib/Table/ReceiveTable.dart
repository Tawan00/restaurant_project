import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:restaurant_project/Foods/Foods.dart';
import 'package:restaurant_project/Model/LRModel/LoginModel.dart';
import 'package:restaurant_project/Model/TableModel/TablesModel.dart';
import 'package:restaurant_project/Model/TableModel/TkTableModel.dart';
import 'package:restaurant_project/Model/UserModel/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_project/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:restaurant_project/Homepage/BottomBar.dart';
import 'package:restaurant_project/Homepage/HomePage.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ReceiveTables extends StatefulWidget {
  // String username;
  // ReceiveTales({this.username});
  @override
  _ReceiveTablesState createState() => _ReceiveTablesState();
}

class _ReceiveTablesState extends State<ReceiveTables> {
  String token = "";
  Future<Null> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString("token");
    getdata();
  }

  List<UserModel> userModel;
  var accName = TextEditingController();
  var accId = TextEditingController();
  var accTel = TextEditingController();
  var count = TextEditingController();
  Future<Null> getdata() async {
    final String url = "http://itoknode@itoknode.comsciproject.com/user/User";
    final response = await http
        .get(Uri.parse(url), headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      setState(() {
        var responseString = response.body;
        //print(response.body);
        userModel = userModelFromJson(responseString);
        accName.text = userModel[0].accName;
        accId.text = userModel[0].accId.toString();
        accTel.text = userModel[0].accTel;
        //print(loginModel[0].accName);
      });
    } else {
      return null;
    }
  }

  TimeOfDay timestart;
  TimeOfDay timeend;
  TimeOfDay pickedTimeStart;
  TimeOfDay pickedTimeEnd;

  @override
  void initState() {
    super.initState();
    //accName.text = this.widget.username;
    timestart = TimeOfDay.now();
    timeend = TimeOfDay.now();
    pickedTimeStart = TimeOfDay.now();
    pickedTimeEnd = TimeOfDay.now();
    st = "เลือกวันที่";
    pks = "9:00:00";
    pke = "11:00:00";
    getToken();
  }

  int dataToChange = 0;

  Color greenColor = Color(0xFF5B8842);
  Color orangeColor = Color(0xFFF17532);
  void changedataAdd() {
    setState(() {
      dataToChange += 1;
    });
  }

  void changedataReMov() {
    setState(() {
      dataToChange -= 1;
      if (dataToChange <= 0) {
        dataToChange = 0;
      }
    });
  }

  DateTime date = DateTime.now();
  var st;
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

////////////////////////////////////////////////////////////////////////////////////
  var pks;
  var pke;
  Future<Null> selectTimeStart(BuildContext context) async {
    pickedTimeStart =
        await showTimePicker(context: context, initialTime: timestart);
    if (pickedTimeStart != null) {
      setState(() {
        timestart = pickedTimeStart;
        pks = "${timestart.hour}:${timestart.minute}";
      });
    }
  }

  Future<Null> selectTimeEnd(BuildContext context) async {
    pickedTimeEnd =
        await showTimePicker(context: context, initialTime: timeend);
    if (pickedTimeEnd != null) {
      setState(() {
        timeend = pickedTimeEnd;
        pke = "${timeend.hour}:${timeend.minute}";
      });
    }
  }

////////////////////////////////////////////////////////////////////////////////

  List<TablesModel> tablemodel;

  TkTablesModel tktablesmodel;
  Future<TkTablesModel> CheckIn(
    String acc_id,
    String bt_count,
    String bt_start_time,
    String bt_end_time,
    String bt_date_check_in,
    String bt_tel,
  ) async {
    final String url =
        "http://itoknode@itoknode.comsciproject.com/table/addtable2";
    final response = await http.post(Uri.parse(url), body: {
      "acc_id": acc_id,
      "bt_count": bt_count,
      "bt_start_time": bt_start_time,
      "bt_end_time": bt_end_time,
      "bt_date_check_in": bt_date_check_in,
      "bt_tel": bt_tel
    });
    // var data = json.decode(response.body);
    if (response.statusCode == 200) {
      String responseString = response.body;
      //tktablesmodel = tkTablesModelFromJson(responseString);
      //String responseString = response.body;
      return tkTablesModelFromJson(responseString);
    } else {
      return null;
    }
  }

  var countController = TextEditingController();
  var startController = TextEditingController();
  var endController = TextEditingController();
  var checkController = TextEditingController();
  var telController = TextEditingController();

  int groupValue = 0;
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();

    return Scaffold(
      backgroundColor: Color(0xFFFCFAF8),
      appBar: AppBar(
        backgroundColor: Color(0xFFFCFAF8),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "สั่งจองโต๊ะ",
          style: GoogleFonts.prompt(textStyle: TextStyle(color: Colors.black)),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => HomePage(
                    // username: this.widget.username,
                    )));
          },
        ),
      ),
      body: (userModel == null)
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
                  height: 700,
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
                                  textStyle: TextStyle(
                                      color: Colors.black, fontSize: 15.0),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: TextField(
                                  enabled: false,
                                  controller: accName,

                                  style: GoogleFonts.kanit(
                                      textStyle:
                                          TextStyle(color: Colors.black)),
                                  //controller: nameController
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'ชื่อ',
                                    suffixIcon: Icon(
                                      Icons.check,
                                      color: Colors.green[700],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Text(
                                    'จำนวนลูกค้า',
                                    style: GoogleFonts.kanit(
                                        textStyle: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.black)),
                                  ),
                                ),
                                SizedBox(
                                  width: 100,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                children: [
                                  Container(
                                    height: 35,
                                    width: 50,
                                    child: RaisedButton(
                                      onPressed: changedataReMov,
                                      child: Text(
                                        '-',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Container(
                                    height: 20,
                                    child: Text(
                                      "$dataToChange",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Container(
                                    height: 35,
                                    width: 50,
                                    child: RaisedButton(
                                      onPressed: changedataAdd,
                                      child: Text(
                                        '+',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Container(
                                color: orangeColor,
                                height: 1.0,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
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
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Container(
                                color: orangeColor,
                                height: 1.0,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  child: Text(
                                    "เลือกเวลา",
                                    style: GoogleFonts.kanit(
                                      textStyle: TextStyle(
                                          fontSize: 15.0, color: Colors.black),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(10),
                                  child: CupertinoSlidingSegmentedControl<int>(
                                    backgroundColor: CupertinoColors.white,
                                    thumbColor: CupertinoColors.activeOrange,
                                    padding: EdgeInsets.all(4),
                                    groupValue: groupValue,
                                    children: {
                                      0: Text("9-11.00"),
                                      1: Text("11-13.00"),
                                      2: Text("13-15.00"),
                                      3: Text("15-17.00"),
                                    },
                                    onValueChanged: (groupValue) {
                                      print(groupValue);
                                      if (groupValue == 0) {
                                        pks = "9:00:00";
                                        pke = "11:00:00";
                                        print("${pks}-${pke}");
                                      } else if (groupValue == 1) {
                                        pks = "11:00:00";
                                        pke = "13:00:00";
                                        print("${pks}-${pke}");
                                      } else if (groupValue == 2) {
                                        pks = "13:00:00";
                                        pke = "15:00:00";
                                        print("${pks}-${pke}");
                                      } else {
                                        pks = "15:00:00";
                                        pke = "17:00:00";
                                        print("${pks}-${pke}");
                                      }
                                      setState(
                                          () => this.groupValue = groupValue);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Container(
                                color: orangeColor,
                                height: 1.0,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 15.0, left: 20.0),
                              child: Text(
                                'เบอร์ติดต่อ',
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                      color: Colors.black, fontSize: 15.0),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: TextField(
                                  controller: accTel,
                                  style: GoogleFonts.kanit(
                                      textStyle:
                                          TextStyle(color: Colors.black)),
                                  //controller: nameController
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'เบอร์ติดต่อ',
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 120,
                                  height: 45,
                                  child: GestureDetector(
                                    onTap: () async {
                                      countController.text =
                                          dataToChange.toString();
                                      startController.text = pks;
                                      endController.text = pke;
                                      checkController.text = st;

                                      print(accId.text);
                                      print(countController.text);
                                      print(startController.text);
                                      print(endController.text);
                                      print(checkController.text);
                                      print(accTel.text);
                                      final TkTablesModel booktable =
                                          await CheckIn(
                                              userModel[0].accId.toString(),
                                              countController.text,
                                              startController.text,
                                              endController.text,
                                              checkController.text,
                                              accTel.text);

                                      if (booktable.message == "Success") {
                                        SharedPreferences preferences =
                                            await SharedPreferences
                                                .getInstance();
                                        preferences.setString(
                                            "token", booktable.token);
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        Foods()),
                                                (route) => false);
                                      }
                                    },
                                    child: Container(
                                      height: 50,
                                      child: Material(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        shadowColor: Colors.orangeAccent,
                                        color: orangeColor,
                                        elevation: 7.0,
                                        child: Center(
                                          child: Text(
                                            'ตกลง',
                                            style: GoogleFonts.kanit(
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600)),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (context) => ReceiveTales()));
        },
        backgroundColor: Color(0xFFF17532),
        child: Icon(Icons.fastfood),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBar(),
    );
  }

  Widget buildSegment(String text) => Container(
        padding: EdgeInsets.all(12),
        child: Text(
          text,
          style: TextStyle(fontSize: 20),
        ),
      );
}

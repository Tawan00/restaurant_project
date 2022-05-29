import 'dart:convert';

import 'package:restaurant_project/Homepage/HomePage.dart';
import 'package:restaurant_project/Model/AEModel/TkAddModel.dart';
import 'package:restaurant_project/Model/MessageModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_project/Foods/Foods.dart';
import 'package:http/http.dart' as http;

class OrderList extends StatefulWidget {
  int bt_id;
  List<int> id = [];
  List<String> nameFood;
  List<int> priceFood;
  List<String> imgFood;
  int amount;
  OrderList(
      {this.bt_id,
      this.id,
      this.nameFood,
      this.imgFood,
      this.priceFood,
      this.amount});

  @override
  _OderListState createState() => _OderListState();
}

class _OderListState extends State<OrderList> {
  int sumpricefood = 0;
  int sumcount = 0;
  @override
  void initState() {
    super.initState();
    allprice();
  }

  var sum = TextEditingController();
  void allprice() {
    if (this.widget.priceFood != null) {
      for (var i = 0; i < this.widget.priceFood.length; i++) {
        sumpricefood += this.widget.priceFood[i];
        sum.text = sumpricefood.toString();
        sumcount = this.widget.id[i];
      }
    }
  }

  void clearText() {
    sum.text = sumpricefood.toString();
  }

  var btID = TextEditingController();

  List<TkAddModel> _addrmodel;
  Future<TkAddModel> Add(String bt_id, List food_id, List food_count) async {
    final String url =
        "http://itoknode@itoknode.comsciproject.com/bookor/AddBookorder";

    var data = {"bt_id": bt_id, "food_id": food_id, "food_count": food_count};
    print(jsonEncode(data));
    final response = await http.post(Uri.parse(url),
        body: jsonEncode(data), headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      String responseString = response.body;
      return tkAddModelFromJson(responseString);
    } else {
      return null;
    }
  }

  Future<MessageModel> AddTotal(String bt_id, String bt_total) async {
    final url = "http://itoknode.comsciproject.com/bookor/AddTotal";
    final response = await http
        .post(Uri.parse(url), body: {"bt_id": bt_id, "bt_total": bt_total});
    if (response.statusCode == 200) {
      String responseString = response.body;
      return messageModelFromJson(responseString);
    } else {
      return null;
    }
  }

  Color greenColor = Color(0xFF5B8842);
  Color orangeColor = Color(0xFFF17532);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFCFAF8),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "",
          style: GoogleFonts.prompt(textStyle: TextStyle(color: Colors.black)),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 70,
                      width: 145,
                      child: Text('My Order',
                          style: GoogleFonts.kanit(
                              textStyle: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: orangeColor))),
                    ),
                    Positioned(
                      top: 17,
                      left: 133.0,
                      child: Container(
                          height: 8.0,
                          width: 8.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: greenColor)),
                    )
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                Container(
                  height: 260,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: this.widget.id.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: ListTile(
                            leading: Image.network(this.widget.imgFood[index]),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    "${this.widget.amount} x ${this.widget.nameFood[index]}",
                                    style: GoogleFonts.kanit(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    )),
                                Text(
                                  "฿${this.widget.priceFood[index].toString()}",
                                  style: GoogleFonts.kanit(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey)),
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Color(0xFFFF4848),
                              ),
                              onPressed: () {
                                sum.text = (int.parse(sum.text) -
                                        this.widget.priceFood[index])
                                    .toString();
                                this.widget.id.removeAt(index);
                                this.widget.nameFood.removeAt(index);
                                this.widget.priceFood.removeAt(index);

                                setState(() {});
                              },
                            ),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "ราคารวม:",
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                              // fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 20.0)),
                    ),
                    new Text(
                      "฿${sum.text}",
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 20.0)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              color: Color(0xFFEBEBEB),
              height: 3.0,
            ),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: GestureDetector(
              onTap: () async {
                print(this.widget.bt_id);
                print(this.widget.id);
                print(this.widget.priceFood);
                final TkAddModel add = await Add(this.widget.bt_id.toString(),
                    this.widget.id, this.widget.priceFood);
                if (add.message == "Success") {
                  showPassDialog();
                } else {
                  showEndDialog();
                }
                final MessageModel UPDATE =
                    await AddTotal(this.widget.bt_id.toString(), sum.text);
                if (UPDATE.message == 'Success') {
                  print("Add Success");
                } else {
                  print('Add Failed');
                }
              },
              child: Container(
                height: 50.0,
                child: Material(
                  borderRadius: BorderRadius.circular(25.0),
                  shadowColor: Colors.orangeAccent,
                  color: orangeColor,
                  elevation: 7.0,
                  child: Center(
                    child: Text(
                      'ยืนยัน',
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600)),
                    ),
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
                    .push(MaterialPageRoute(builder: (context) => HomePage()));
              },
            )
          ],
        ),
      );
  Future showEndDialog() => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Center(
              child: Text(
            'ไม่สามารถเพิ่มได้',
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
                  color: Colors.red[700],
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

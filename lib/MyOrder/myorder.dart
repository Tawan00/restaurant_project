import 'package:restaurant_project/Homepage/HomePage.dart';
import 'package:restaurant_project/Model/MessageModel.dart';
import 'package:restaurant_project/Model/OrderModel/MyOrderModel.dart';
import 'package:restaurant_project/Model/OrderModel/OrderModel.dart';
import 'package:restaurant_project/Model/UserModel/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MyOrder extends StatefulWidget {
  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _tabControllor = TabController(length: 2, vsync: this);
    getToken();
  }

  TabController _tabControllor;
  String token = "";
  Future<Null> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString("token");
    getdata();
  }

  List<UserModel> userModel;
  var accID;
  Future<Null> getdata() async {
    final String url = "http://itoknode@itoknode.comsciproject.com/user/User";
    final response = await http
        .get(Uri.parse(url), headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      setState(() {
        var responseString = response.body;
        userModel = userModelFromJson(responseString);
        accID = userModel[0].accId;
      });
    } else {
      return null;
    }
    GetOrder(userModel[0].accId.toString());
    GetOrder2(userModel[0].accId.toString());
  }

  List<MyOrderModel> MyOrderData;
  List<MyOrderModel> MyOrderData2;

  List<MyOrderModel> filterItems2;
  Future<Null> GetOrder(String acc_id) async {
    var url = "http://itoknode@itoknode.comsciproject.com/bookor/MyOrder";
    final response = await http.post(Uri.parse(url), body: {"acc_id": acc_id});
    //print(response.statusCode);
    print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() {
        final String responseString = response.body;
        MyOrderData = myOrderModelFromJson(responseString);
        filterItems2 = MyOrderData;
      });
    }
  }

  List<MyOrderModel> filterItems;
  Future<Null> GetOrder2(String acc_id) async {
    var url = "http://itoknode@itoknode.comsciproject.com/bookor/MyOrder2";
    final response = await http.post(Uri.parse(url), body: {"acc_id": acc_id});
    //print(response.statusCode);
    print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() {
        final String responseString = response.body;
        MyOrderData2 = myOrderModelFromJson(responseString);
        filterItems = MyOrderData2;
      });
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
            "ออเดอร์ของฉัน",
            style:
                GoogleFonts.prompt(textStyle: TextStyle(color: Colors.black)),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
          bottom: TabBar(
            controller: _tabControllor,
            tabs: [
              Tab(
                child: Text(
                  "กำลังดำเนินการ",
                  style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.black)),
                ),
              ),
              Tab(
                child: Text("ตอบรับแล้ว",
                    style: GoogleFonts.kanit(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.black))),
              ),
            ],
          ),
        ),
        body: (MyOrderData == null || MyOrderData2 == null)
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
            : TabBarView(
                controller: _tabControllor,
                children: [_datawaiting(), _datadone()],
              ));
  }

  Widget _datawaiting() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: TextField(
            style: GoogleFonts.kanit(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w400, color: Colors.black)),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              hintText: "วันที่ หรือ ราคา",
              hintStyle: GoogleFonts.kanit(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w400, color: Colors.black54)),
              icon: Icon(
                Icons.search,
              ),
            ),
            onChanged: (value) {
              setState(() {
                filterItems2 = MyOrderData.where((u) => (u.btDate
                        .toString()
                        .toLowerCase()
                        .contains(value.toLowerCase()) ||
                    u.btTotal
                        .toString()
                        .toLowerCase()
                        .contains(value.toLowerCase()))).toList();
              });
            },
          ),
        ),
        Expanded(
          child: (MyOrderData == null)
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
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: filterItems2.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.receipt_long),
                          ],
                        ),
                        title: Text(
                            "${MyOrderData[index].btDate.day}/${MyOrderData[index].btDate.month}/${MyOrderData[index].btDate.year}",
                            style: GoogleFonts.kanit(
                                fontWeight: FontWeight.w500,
                                textStyle: TextStyle(color: Colors.black))),
                        subtitle: Text(
                            "ใบสั่งจองที่ ${MyOrderData[index].btId}",
                            style: GoogleFonts.kanit(
                                textStyle: TextStyle(color: Colors.black54))),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("รอดำเนินการ",
                                style: GoogleFonts.kanit(
                                    textStyle: TextStyle(color: Colors.red))),
                            Text("${MyOrderData[index].btTotal} ฿",
                                style: GoogleFonts.kanit(
                                    fontWeight: FontWeight.w700,
                                    textStyle: TextStyle(color: Colors.black))),
                          ],
                        ),
                        onTap: () {
                          CreateDialogForgetPass(
                            filterItems2[index].btId.toString(),
                            filterItems2[index].tbId.toString(),
                            filterItems2[index].accName,
                            filterItems2[index].btDateCheckIn.toString(),
                            filterItems2[index].btStartTime.toString(),
                            filterItems2[index].btEndTime.toString(),
                            filterItems2[index].btCount.toString(),
                            filterItems2[index].foodName,
                            filterItems2[index].foodCount.toString(),
                            filterItems2[index].btTotal.toString(),
                          );
                        },
                      ),
                    );
                  }),
        ),
      ],
    );
  }

  Widget _datadone() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: TextField(
            style: GoogleFonts.kanit(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w400, color: Colors.black)),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              hintText: "วันที่ หรือ ราคา",
              hintStyle: GoogleFonts.kanit(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w400, color: Colors.black54)),
              icon: Icon(
                Icons.search,
              ),
            ),
            onChanged: (value) {
              setState(() {
                filterItems = MyOrderData2.where((u) => (u.btDate
                        .toString()
                        .toLowerCase()
                        .contains(value.toLowerCase()) ||
                    u.btTotal
                        .toString()
                        .toLowerCase()
                        .contains(value.toLowerCase()))).toList();
              });
            },
          ),
        ),
        Expanded(
          child: (MyOrderData2 == null)
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
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: filterItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.receipt_long),
                          ],
                        ),
                        title: Text(
                            "${filterItems[index].btDate.day}/${filterItems[index].btDate.month}/${filterItems[index].btDate.year}",
                            style: GoogleFonts.kanit(
                                fontWeight: FontWeight.w500,
                                textStyle: TextStyle(color: Colors.black))),
                        subtitle: Text(
                            "ใบสั่งจองที่ ${filterItems[index].btId}",
                            style: GoogleFonts.kanit(
                                textStyle: TextStyle(color: Colors.black54))),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("รายการสำเร็จ",
                                style: GoogleFonts.kanit(
                                    textStyle: TextStyle(color: Colors.green))),
                            Text("${filterItems[index].btTotal} ฿",
                                style: GoogleFonts.kanit(
                                    fontWeight: FontWeight.w700,
                                    textStyle: TextStyle(color: Colors.black))),
                          ],
                        ),
                        onTap: () {
                          CreateDialogForgetPass(
                            filterItems[index].btId.toString(),
                            filterItems[index].tbId.toString(),
                            filterItems[index].accName,
                            filterItems[index].btDateCheckIn.toString(),
                            filterItems[index].btStartTime.toString(),
                            filterItems[index].btEndTime.toString(),
                            filterItems[index].btCount.toString(),
                            filterItems[index].foodName,
                            filterItems[index].foodCount.toString(),
                            filterItems[index].btTotal.toString(),
                          );
                        },
                      ),
                    );
                  }),
        ),
      ],
    );
  }

  Future CreateDialogForgetPass(
          String btid,
          String tbid,
          String accid,
          String date,
          String timecheckin,
          String timecheckout,
          String count,
          String foodname,
          String foodcount,
          String total) =>
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Container(
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "รายละเอียดการสั่งจอง",
                  style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "รหัสบิล : ",
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                      )),
                    ),
                    Text(
                      "${btid}",
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black54,
                      )),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "รหัสลูกค้า : ",
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                      )),
                    ),
                    Text(
                      "${accid}",
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black54,
                      )),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "วันที่จอง : ",
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                      )),
                    ),
                    Text(
                      date,
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black54,
                      )),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "เวลาที่จอง : ",
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                      )),
                    ),
                    Text(
                      "${timecheckin} - ${timecheckout}",
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black54,
                      )),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "จำนวน : ",
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                      )),
                    ),
                    Text(
                      "${count} คน",
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black54,
                      )),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "โต๊ะที่ : ",
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                      )),
                    ),
                    Text(
                      "${tbid}",
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black54,
                      )),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "อาหาร :",
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                      )),
                    ),
                    Text(
                      foodname,
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black54,
                      )),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "ราคาอาหาร :",
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                      )),
                    ),
                    Text(
                      "${foodcount}",
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black54,
                      )),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "ราคารวม : ",
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                      )),
                    ),
                    Text(
                      "${total} บาท",
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black54,
                      )),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            FlatButton(
              child: Text(
                'ออก',
                style: GoogleFonts.kanit(
                    textStyle: TextStyle(
                  color: Colors.red[400],
                  fontWeight: FontWeight.w600,
                )),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
}

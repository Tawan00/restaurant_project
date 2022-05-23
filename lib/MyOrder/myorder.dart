import 'package:restaurant_project/Homepage/HomePage.dart';
import 'package:restaurant_project/Model/AEModel/EditModel.dart';
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
  var getIndexfilterItems;
  List<UserModel> userModel;
  var accID;
  TabController _tabControllor;
  String token = "";

  @override
  void initState() {
    super.initState();
    _tabControllor = TabController(length: 3, vsync: this);
    getToken();
  }
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
    GetCancelOrder(userModel[0].accId.toString());
  }


  Future<Null> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString("token");
    getdata();
  }




  List<MyOrderModel> MyOrderData;
  List<MyOrderModel> filterItems;

  List<MyOrderModel> MyOrderData2;
  List<MyOrderModel> filterItems2;

  List<MyOrderModel> _OrderCancel;
  List<MyOrderModel> filterItemsCancel;

  Future<Null> GetOrder(String acc_id) async {
    var url = "http://itoknode@itoknode.comsciproject.com/bookor/MyOrder";
    final response = await http.post(Uri.parse(url), body: {"acc_id": acc_id});
    //print(response.statusCode);
    print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() {
        final String responseString = response.body;
        MyOrderData = myOrderModelFromJson(responseString);
        filterItems = MyOrderData;
        print(responseString);
      });
    }
  }


  Future<Null> GetOrder2(String acc_id) async {
    var url = "http://itoknode@itoknode.comsciproject.com/bookor/MyOrder2";
    final response = await http.post(Uri.parse(url), body: {"acc_id": acc_id});
    //print(response.statusCode);
    print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() {
        final String responseString = response.body;
        MyOrderData2 = myOrderModelFromJson(responseString);
        filterItems2 = MyOrderData2;
      });
    }
  }

  Future<Null> GetCancelOrder(String acc_id) async {
    var url = "http://itoknode.comsciproject.com/bookor/cancelMyOrders";
    final response = await http.post(Uri.parse(url), body: {"acc_id": acc_id});
    print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() {
        final String responseString = response.body;
        _OrderCancel = myOrderModelFromJson(responseString);
        filterItemsCancel = _OrderCancel;
      });
    }
  }

  Future<EditModel> CancelBooktable(String acc_id, String bt_id) async {
    final String url =
        "http://itoknode@itoknode.comsciproject.com/bookor/CancelBookTable";
    final response = await http.post(Uri.parse(url),
        body: {"acc_id": acc_id, "bt_id": bt_id});
    print(response.body);
    if (response.statusCode == 200) {
      String responseString = response.body;
      return editModelFromJson(responseString);
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
                  maxLines: 1,
                  softWrap: false,
                  style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.black)),
                ),
              ),
              Tab(
                child: Text("เสร็จสิ้น",
                    maxLines: 1,
                    softWrap: false,
                    style: GoogleFonts.kanit(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.black))),
              ),
              Tab(
                child: Text("ยกเลิก/ล้มเหลว",maxLines: 1,
                    softWrap: false,
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
                children: [_datawaiting(), _datadone(), _datacancel()],
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
                filterItems = MyOrderData.where((u) => (u.btDate
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
          child: (filterItems == null)
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
                        "${filterItems[index].btDate.day}-${filterItems[index].btDate.month}-${filterItems[index].btDate.year}",
                        style: GoogleFonts.kanit(
                            fontWeight: FontWeight.w500,
                            textStyle: TextStyle(color: Colors.black))),
                    subtitle: Text("ใบสั่งจองที่ ${filterItems[index].btId}",
                        style: GoogleFonts.kanit(
                            textStyle: TextStyle(color: Colors.black54))),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("รอดำเนินการ",
                            style: GoogleFonts.kanit(
                                textStyle: TextStyle(color: Colors.blueAccent))),
                        Text("${filterItems[index].btTotal} ฿",
                            style: GoogleFonts.kanit(
                                fontWeight: FontWeight.w700,
                                textStyle: TextStyle(color: Colors.black))),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        getIndexfilterItems = filterItems[index].btId;
                        DialogCancelOrder(
                          filterItems[index].btId.toString(),
                          filterItems[index].tbId.toString(),
                          filterItems[index].accId.toString(),
                          filterItems[index].btDateCheckIn.toString(),
                          filterItems[index].btStartTime.toString(),
                          filterItems[index].btEndTime.toString(),
                          filterItems[index].btCount.toString(),
                          filterItems[index].btTotal.toString(),
                        );
                      });

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
                filterItems2 = MyOrderData2.where((u) => (u.btDate
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
                            "${filterItems2[index].btDate.day}-${filterItems2[index].btDate.month}-${filterItems2[index].btDate.year}",
                            style: GoogleFonts.kanit(
                                fontWeight: FontWeight.w500,
                                textStyle: TextStyle(color: Colors.black))),
                        subtitle: Text(
                            "ใบสั่งจองที่ ${filterItems2[index].btId}",
                            style: GoogleFonts.kanit(
                                textStyle: TextStyle(color: Colors.black54))),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("สำเร็จ",
                                style: GoogleFonts.kanit(
                                    textStyle: TextStyle(color: Colors.green))),
                            Text("${filterItems2[index].btTotal} ฿",
                                style: GoogleFonts.kanit(
                                    fontWeight: FontWeight.w700,
                                    textStyle: TextStyle(color: Colors.black))),
                          ],
                        ),
                        onTap: () {
                          DialogDetailBookTable(
                            filterItems2[index].btId.toString(),
                            filterItems2[index].tbId.toString(),
                            filterItems2[index].accId.toString(),
                            filterItems2[index].btDateCheckIn.toString(),
                            filterItems2[index].btStartTime.toString(),
                            filterItems2[index].btEndTime.toString(),
                            filterItems2[index].btCount.toString(),
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

  Widget _datacancel() {
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
                filterItemsCancel = _OrderCancel.where((u) => (u.btDate
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
          child: (_OrderCancel == null)
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
              itemCount: filterItemsCancel.length,
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
                        "${filterItemsCancel[index].btDate.day}-${filterItemsCancel[index].btDate.month}-${filterItemsCancel[index].btDate.year}",
                        style: GoogleFonts.kanit(
                            fontWeight: FontWeight.w500,
                            textStyle: TextStyle(color: Colors.black))),
                    subtitle: Text(
                        "ใบสั่งจองที่ ${filterItemsCancel[index].btId}",
                        style: GoogleFonts.kanit(
                            textStyle: TextStyle(color: Colors.black54))),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("ยกเลิก",
                            style: GoogleFonts.kanit(
                                textStyle: TextStyle(color: Colors.red))),
                        Text("${filterItemsCancel[index].btTotal} ฿",
                            style: GoogleFonts.kanit(
                                fontWeight: FontWeight.w700,
                                textStyle: TextStyle(color: Colors.black))),
                      ],
                    ),
                    onTap: () {
                      DialogDetailBookTable(
                        filterItemsCancel[index].btId.toString(),
                        filterItemsCancel[index].tbId.toString(),
                        filterItemsCancel[index].accId.toString(),
                        filterItemsCancel[index].btDateCheckIn.toString(),
                        filterItemsCancel[index].btStartTime.toString(),
                        filterItemsCancel[index].btEndTime.toString(),
                        filterItemsCancel[index].btCount.toString(),
                        filterItemsCancel[index].btTotal.toString(),
                      );
                    },
                  ),
                );
              }),
        ),
      ],
    );
  }

  Future DialogDetailBookTable(
      String btid,
      String tbid,
      String accid,
      String date,
      String timecheckin,
      String timecheckout,
      String count,
      String total) =>
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Container(
            height: 200,
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



  Future DialogCancelOrder(
          String btid,
          String tbid,
          String accid,
          String date,
          String timecheckin,
          String timecheckout,
          String count,
          String total) =>
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Container(
            height: 200,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FlatButton(
                  child: Text(
                    'ยกเลิกการสั่งจอง',
                    style: GoogleFonts.kanit(
                        textStyle: TextStyle(
                          color: Colors.red[400],
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                  onPressed: () {
                    setState(() {
                      confirmDialog();
                    });

                  },
                ),

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
          ],
        ),
      );

  Future confirmDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text('ยกเลิกการสั่งจอง',textAlign: TextAlign.center,style: GoogleFonts.kanit(
              textStyle: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ))),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('คุณแน่ใจหรือไม่ ?',textAlign: TextAlign.center,style: GoogleFonts.kanit(
                    textStyle: TextStyle(
                      color: Colors.black,
                    ))),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FlatButton(
                child: Text(
                  'ยกเลิก',
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
              FlatButton(
                child: Text(
                  'ยืนยัน',
                  style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                        color: Colors.red[400],
                        fontWeight: FontWeight.w600,
                      )),
                ),
                onPressed: () {
                  setState(() {
                    CancelBooktable(userModel[0].accId.toString(),getIndexfilterItems.toString());
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => this.widget));
                  });
                },
              ),
            ],)
          ],
        );
      },
    );
  }


}

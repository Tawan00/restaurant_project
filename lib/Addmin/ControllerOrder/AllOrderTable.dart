import 'package:flutter/material.dart';
import 'package:restaurant_project/Addmin/ControllerOrder/main_order.dart';
import 'package:restaurant_project/Foods/OrderList.dart';
import 'package:restaurant_project/Model/OrderModel/MyOrderModel.dart';
import 'package:restaurant_project/Model/OrderModel/OrderModel.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class AllOrderTable extends StatefulWidget {
  @override
  _AllOrderTableState createState() => _AllOrderTableState();
}

class _AllOrderTableState extends State<AllOrderTable>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _tabControllor = TabController(length: 2, vsync: this);
    ApprveOrder();
    DisapproveOrder();
  }

  TabController _tabControllor;

  List<MyOrderModel> _OrderApprove;
  List<MyOrderModel> filterItemsApprove;

  List<MyOrderModel> _Orderdisapprove;
  List<MyOrderModel> filterItemsdisapprove;

  Future<Null> ApprveOrder() async {
    var url = "http://itoknode.comsciproject.com/bookor/ApproveOrders";
    final response = await http.get(Uri.parse(url));
    print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() {
        final String responseString = response.body;
        _OrderApprove = myOrderModelFromJson(responseString);
        filterItemsApprove = _OrderApprove;

        for (var i = 0; i < _OrderApprove.length; i++) {
          var num = filterItemsApprove
              .where((food) => _OrderApprove[i]
                  .foodName
                  .toLowerCase()
                  .contains(_OrderApprove[i].foodName.toLowerCase()))
              .length;
          print(num);
        }
      });
    }
  }

  Future<Null> DisapproveOrder() async {
    var url = "http://itoknode.comsciproject.com/bookor/disapproveOrders";
    final response = await http.get(Uri.parse(url));
    print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() {
        final String responseString = response.body;
        _Orderdisapprove = myOrderModelFromJson(responseString);
        filterItemsdisapprove = _Orderdisapprove;
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
          "ออเดอร์ทั้งหมด",
          style: GoogleFonts.prompt(textStyle: TextStyle(color: Colors.black)),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => MainOrder()));
          },
        ),
        bottom: TabBar(
          controller: _tabControllor,
          tabs: [
            Tab(
              child: Text(
                "อนุมัติแล้ว",
                style: GoogleFonts.kanit(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.black),
                ),
              ),
            ),
            Tab(
              child: Text(
                "ยังไม่อนุมัติ",
                style: GoogleFonts.kanit(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
      body: (_OrderApprove == null || _Orderdisapprove == null)
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
            ),
    );
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
                filterItemsApprove = _OrderApprove.where((u) => (u.btDate
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
          child: (_OrderApprove == null)
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
                  itemCount: filterItemsApprove.length,
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
                            "${_OrderApprove[index].btDate.day}/${_OrderApprove[index].btDate.month}/${_OrderApprove[index].btDate.year}",
                            style: GoogleFonts.kanit(
                                fontWeight: FontWeight.w500,
                                textStyle: TextStyle(color: Colors.black))),
                        subtitle: Text(
                            "ใบสั่งจองที่ ${_OrderApprove[index].btId}",
                            style: GoogleFonts.kanit(
                                textStyle: TextStyle(color: Colors.black54))),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("อนุมัติแล้ว",
                                style: GoogleFonts.kanit(
                                    textStyle: TextStyle(color: Colors.green))),
                            Text("${_OrderApprove[index].btTotal} ฿",
                                style: GoogleFonts.kanit(
                                    fontWeight: FontWeight.w700,
                                    textStyle: TextStyle(color: Colors.black))),
                          ],
                        ),
                        onTap: () {
                          CreateDialogForgetPass(
                            _OrderApprove[index].btId.toString(),
                            _OrderApprove[index].tbId.toString(),
                            _OrderApprove[index].accName.toString(),
                            _OrderApprove[index].btDateCheckIn.toString(),
                            _OrderApprove[index].btStartTime.toString(),
                            _OrderApprove[index].btEndTime.toString(),
                            _OrderApprove[index].btCount.toString(),
                            _OrderApprove[index].foodName.toString(),
                            _OrderApprove[index].foodCount.toString(),
                            _OrderApprove[index].btTotal.toString(),
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
                filterItemsdisapprove = _Orderdisapprove.where((u) => (u.btDate
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
          child: (_Orderdisapprove == null)
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
                  itemCount: filterItemsdisapprove.length,
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
                            "${_Orderdisapprove[index].btDate.day}/${_Orderdisapprove[index].btDate.month}/${_Orderdisapprove[index].btDate.year}",
                            style: GoogleFonts.kanit(
                                fontWeight: FontWeight.w500,
                                textStyle: TextStyle(color: Colors.black))),
                        subtitle: Text(
                            "ใบสั่งจองที่ ${filterItemsdisapprove[index].btId}",
                            style: GoogleFonts.kanit(
                                textStyle: TextStyle(color: Colors.black54))),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("รออนุมัติ",
                                style: GoogleFonts.kanit(
                                    textStyle: TextStyle(color: Colors.red))),
                            Text("${filterItemsdisapprove[index].btTotal} ฿",
                                style: GoogleFonts.kanit(
                                    fontWeight: FontWeight.w700,
                                    textStyle: TextStyle(color: Colors.black))),
                          ],
                        ),
                        onTap: () {
                          CreateDialogForgetPass(
                            filterItemsdisapprove[index].btId.toString(),
                            filterItemsdisapprove[index].tbId.toString(),
                            filterItemsdisapprove[index].accName,
                            filterItemsdisapprove[index]
                                .btDateCheckIn
                                .toString(),
                            filterItemsdisapprove[index].btStartTime.toString(),
                            filterItemsdisapprove[index].btEndTime.toString(),
                            filterItemsdisapprove[index].btCount.toString(),
                            filterItemsdisapprove[index].foodName.toString(),
                            filterItemsdisapprove[index].foodCount.toString(),
                            filterItemsdisapprove[index].btTotal.toString(),
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
          String accname,
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
                      btid.toString(),
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
                      accname,
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
                      "อาหาร : ",
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
                      "ราคา : ",
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

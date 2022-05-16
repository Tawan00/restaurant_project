import 'package:restaurant_project/Addmin/MainAdmin.dart';
import 'package:restaurant_project/Addmin/ControllerOrder/editOrder.dart';
import 'package:flutter/material.dart';

import 'package:restaurant_project/Homepage/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:restaurant_project/Model/OrderModel/OrderModel.dart';

class TableOrderList extends StatefulWidget {
  @override
  _TableOrderListState createState() => _TableOrderListState();
}

class _TableOrderListState extends State<TableOrderList> {
  @override
  void initState() {
    super.initState();
    GetOrder();
  }

  var _name = TextEditingController();
  var _tel = TextEditingController();
  var _person = TextEditingController();
  var _checkin = TextEditingController();

  List<OrderModel> OrderData;
  List<OrderModel> filterItems;

  Future<Null> GetOrder() async {
    var url = "http://itoknode@itoknode.comsciproject.com/bookor/AllOrder";
    final response = await http.get(Uri.parse(url));
    //print(response.statusCode);
    print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() {
        final String responseString = response.body;
        OrderData = orderModelFromJson(responseString);
        filterItems = OrderData;
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
            "จัดการออเดอร์",
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
            },
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextField(
                style: GoogleFonts.kanit(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w400, color: Colors.black)),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  hintText: "ชื่อ หรือ เวลาเช็คอิน",
                  hintStyle: GoogleFonts.kanit(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w400, color: Colors.black54)),
                  icon: Icon(
                    Icons.search,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    filterItems = OrderData.where((u) => (u.accName
                            .toString()
                            .toLowerCase()
                            .contains(value.toLowerCase()) ||
                        u.btDateCheckIn
                            .toString()
                            .toLowerCase()
                            .contains(value.toLowerCase()))).toList();
                  });
                },
              ),
            ),
            Expanded(
              child: (OrderData == null)
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
                                      'ชื่อ',
                                      style: GoogleFonts.kanit(
                                          textStyle: TextStyle(
                                              color: Color(0xFFD17E50),
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w600)),
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'จำนวนคน',
                                      style: GoogleFonts.kanit(
                                          textStyle: TextStyle(
                                              color: Color(0xFFD17E50),
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w600)),
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'วันที่เข้า',
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
                                      filterItems.length,
                                      (index) => DataRow(
                                            cells: <DataCell>[
                                              DataCell(Center(
                                                child: Text(
                                                  filterItems[index].accName,
                                                  style: GoogleFonts.kanit(
                                                      textStyle: TextStyle(
                                                          color: Colors.black)),
                                                ),
                                              )),
                                              DataCell(Center(
                                                child: Text(
                                                  '${filterItems[index].btCount}',
                                                  style: GoogleFonts.kanit(
                                                      textStyle: TextStyle(
                                                          color: Colors.black)),
                                                ),
                                              )),
                                              DataCell(Center(
                                                child: Text(
                                                  filterItems[index]
                                                      .btDateCheckIn,
                                                  style: GoogleFonts.kanit(
                                                      textStyle: TextStyle(
                                                          color: Colors.black)),
                                                ),
                                              )),
                                              DataCell(Center(
                                                child: ListTile(
                                                  leading: Icon(
                                                    Icons.edit,
                                                    color: Colors.green[600],
                                                  ),
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    editOrder(
                                                                      id: filterItems[
                                                                              index]
                                                                          .btId,
                                                                      name: filterItems[
                                                                              index]
                                                                          .accName,
                                                                      person: filterItems[
                                                                              index]
                                                                          .btCount,
                                                                      checkin: filterItems[
                                                                              index]
                                                                          .btDateCheckIn,
                                                                      starttime:
                                                                          filterItems[index]
                                                                              .btStartTime,
                                                                      endtime: filterItems[
                                                                              index]
                                                                          .btEndTime,
                                                                    )));
                                                  },
                                                ),
                                              )),
                                            ],
                                          )),
                                )),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ));
  }
}

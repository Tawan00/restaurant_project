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

  Future<Null> GetOrder() async {
    var url = "http://itoknode@itoknode.comsciproject.com/bookor/AllOrder";
    final response = await http.get(Uri.parse(url));
    //print(response.statusCode);
    print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() {
        final String responseString = response.body;
        OrderData = orderModelFromJson(responseString);
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
      body: (OrderData == null)
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
                              OrderData.length,
                              (index) => DataRow(
                                    cells: <DataCell>[
                                      DataCell(Center(
                                        child: Text(
                                          OrderData[index].accName,
                                          style: GoogleFonts.kanit(
                                              textStyle: TextStyle(
                                                  color: Colors.black)),
                                        ),
                                      )),
                                      DataCell(Center(
                                        child: Text(
                                          '${OrderData[index].btCount}',
                                          style: GoogleFonts.kanit(
                                              textStyle: TextStyle(
                                                  color: Colors.black)),
                                        ),
                                      )),
                                      DataCell(Center(
                                        child: Text(
                                          OrderData[index].btDateCheckIn,
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
                                                    builder: (context) =>
                                                        editOrder(
                                                          id: OrderData[index]
                                                              .btId,
                                                          name: OrderData[index]
                                                              .accName,
                                                          person:
                                                              OrderData[index]
                                                                  .btCount,
                                                          checkin: OrderData[
                                                                  index]
                                                              .btDateCheckIn,
                                                          starttime:
                                                              OrderData[index]
                                                                  .btStartTime,
                                                          endtime:
                                                              OrderData[index]
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
    );
  }
}

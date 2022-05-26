import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_project/Addmin/ControllerOrder/AllOrderTable.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_project/Addmin/ControllerOrder/ControllerOrderfood/BookFoods/AdminAddBookOrder.dart';
import 'package:restaurant_project/Addmin/ControllerOrder/ControllerOrderfood/BookFoods/AdminEditBookOrder.dart';
import 'package:restaurant_project/Addmin/ControllerOrder/main_order.dart';
import 'package:restaurant_project/Model/ReceiveModel/ReceiptModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AdminAllBookOrder extends StatefulWidget {


  @override
  State<AdminAllBookOrder> createState() => _AdminAllBookOrderState();
}

class _AdminAllBookOrderState extends State<AdminAllBookOrder> {

  List<ReceiptModel> ReceiptData;
  List<ReceiptModel> filterItems;

  Future<Null> GetReceipt() async {
    var url = "http://itoknode@itoknode.comsciproject.com/receipt/AllReceipt";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        final String responseString = response.body;
        ReceiptData = receiptModelFromJson(responseString);
        filterItems = ReceiptData;
        // print(responseString);
      });
    }
  }

  String token = "";
  Future<Null> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString("token");
  }
  @override
  void initState() {
    getToken();
    GetReceipt();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFCFAF8),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "ใบสั่งจองอาหาร",
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

        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AdminAddBookOrder()));
            },
          ),
        ],
      ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextField(
                  style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w400, color: Colors.black)),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    hintText: "รหัสใบสั่งจอง",
                    hintStyle: GoogleFonts.kanit(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w400, color: Colors.black54)),
                    icon: Icon(
                      Icons.search,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      filterItems = ReceiptData.where((u) => (u.boId
                          .toString()
                          .toLowerCase()
                          .contains(value.toLowerCase()))).toList();
                    });
                  },
                ),
              ),
              Expanded(
                child: (ReceiptData == null)
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
                            horizontalMargin: 0,
                            columnSpacing: 10,
                            columns: [
                              DataColumn(
                                  label: Text(
                                    'รหัสใบสั่งจอง',
                                    style: GoogleFonts.kanit(
                                        textStyle: TextStyle(
                                            color: Color(0xFFD17E50),
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w600)),
                                  )),
                              DataColumn(
                                  label: Text(
                                    'รหัสใบสั่งจองโต๊ะ',
                                    style: GoogleFonts.kanit(
                                        textStyle: TextStyle(
                                            color: Color(0xFFD17E50),
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w600)),
                                  )),
                              DataColumn(
                                  label: Text(
                                    'วันที่สั่งจอง',
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
                                        filterItems[index].boId.toString(),
                                        style: GoogleFonts.kanit(
                                            textStyle: TextStyle(
                                                color: Colors.black)),
                                      ),
                                    )),
                                    DataCell(Center(
                                      child: Text(
                                        '${filterItems[index].btId}',
                                        style: GoogleFonts.kanit(
                                            textStyle: TextStyle(
                                                color: Colors.black)),
                                      ),
                                    )),
                                    DataCell(Center(
                                      child: Text(
                                        "${filterItems[index].date.day}-${filterItems[index].date.month}-${filterItems[index].date.year}",
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
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(builder: (context) => AdminEditBookOrder(filterItems[index].boId , filterItems[index].btId )));
                                        },
                                      ),
                                    )),
                                  ],
                                )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}

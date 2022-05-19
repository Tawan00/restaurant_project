import 'package:restaurant_project/Addmin/ControllerFood/AllFoods.dart';
import 'package:restaurant_project/Addmin/ControllerFood/ListFoods.dart';
import 'package:restaurant_project/Addmin/ControllerPromotion/ControllFoodtoPro/addFoodtoPro.dart';
import 'package:restaurant_project/Addmin/ControllerPromotion/addPromotion.dart';
import 'package:restaurant_project/Addmin/ControllerPromotion/editPromotion.dart';
import 'package:restaurant_project/Model/PromotionModel/ProModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class ListPro extends StatefulWidget {
  @override
  _ListProState createState() => _ListProState();
}

class _ListProState extends State<ListPro> {
  @override
  void initState() {
    super.initState();
    GetPro();
  }

  Color greenColor = Color(0xFF5B8842);
  Color orangeColor = Color(0xFFF17532);
  var date = TextEditingController();

  var status;
  String check;
  var startdate;
  var enddate;
  var sd;
  var ed;
  var st = TextEditingController();
  List<PromotionModel> filterItems;
  List<PromotionModel> _Prodata;
  Future<Null> GetPro() async {
    var url = "http://itoknode.comsciproject.com/pro/ProAll";
    final response = await http.get(Uri.parse(url));
    print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() {
        final String responseString = response.body;
        _Prodata = promotionModelFromJson(responseString);
        filterItems = _Prodata;
      });
    }
    print(_Prodata);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFCFAF8),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "รายการโปรโมชัน",
          style: GoogleFonts.kanit(textStyle: TextStyle(color: Colors.black)),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ListFoods()));
            // Navigator.of(context).pop();
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
                  .push(MaterialPageRoute(builder: (context) => AddPro()));
            },
          ),
        ],
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
                hintText: "ชื่อโปรโมชัน",
                hintStyle: GoogleFonts.kanit(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w400, color: Colors.black54)),
                icon: Icon(
                  Icons.search,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  filterItems = _Prodata.where((u) => (u.proName
                          .toString()
                          .toLowerCase()
                          .contains(value.toLowerCase()) ||
                      u.proEndDate.day
                          .toString()
                          .toLowerCase()
                          .contains(value.toLowerCase()) ||
                      u.proStartDate.day
                          .toString()
                          .toLowerCase()
                          .contains(value.toLowerCase()))).toList();
                });
              },
            ),
          ),
          Expanded(
            child: (_Prodata == null)
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
                                  'ชื่อโปรโมชัน',
                                  style: GoogleFonts.kanit(
                                      textStyle: TextStyle(
                                          color: Color(0xFFD17E50),
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w600)),
                                )),
                                DataColumn(
                                    label: Center(
                                  child: Text(
                                    'ช่วงเวลา',
                                    style: GoogleFonts.kanit(
                                        textStyle: TextStyle(
                                            color: Color(0xFFD17E50),
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                )),
                                DataColumn(
                                    label: Text(
                                  'สถานะ',
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
                                DataColumn(
                                    label: Text(
                                  'อาหาร',
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
                                    DataCell(Container(
                                      child: Text(
                                        filterItems[index].proName,
                                        style: GoogleFonts.kanit(
                                            textStyle:
                                                TextStyle(color: Colors.black)),
                                      ),
                                    )),
                                    DataCell(Center(
                                      child: Text(
                                        "${filterItems[index].proStartDate.day}/${_Prodata[index].proStartDate.month}/${_Prodata[index].proStartDate.year} - ${_Prodata[index].proEndDate.day}/${_Prodata[index].proEndDate.month}/${_Prodata[index].proEndDate.year}",
                                        style: GoogleFonts.kanit(
                                            textStyle:
                                                TextStyle(color: Colors.black)),
                                      ),
                                    )),
                                    DataCell(Center(
                                        child: (filterItems[index].proStatus ==
                                                1)
                                            ? Text(
                                                "ไม่ใช้งาน",
                                                style: GoogleFonts.kanit(
                                                    textStyle: TextStyle(
                                                        color: Colors.red)),
                                              )
                                            : Text(
                                                "ใช้งาน",
                                                style: GoogleFonts.kanit(
                                                    textStyle: TextStyle(
                                                        color:
                                                            Colors.green[700])),
                                              ))),
                                    DataCell(
                                      Center(
                                        child: ListTile(
                                          leading: Icon(
                                            Icons.edit,
                                            color: Colors.green[600],
                                          ),
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) => editPro(
                                                  pro_id:
                                                      filterItems[index].proId,
                                                  pro_name: filterItems[index]
                                                      .proName,
                                                  pro_desc: filterItems[index]
                                                      .proDesc,
                                                  pro_discount:
                                                      filterItems[index]
                                                          .proDiscount,
                                                  pro_start_date:
                                                      filterItems[index]
                                                          .proStartDate
                                                          .toString(),
                                                  pro_end_date:
                                                      filterItems[index]
                                                          .proEndDate
                                                          .toString(),
                                                  pro_status: filterItems[index]
                                                      .proStatus,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Center(
                                        child: ListTile(
                                          leading: Icon(
                                            Icons.add,
                                            color: Colors.green[600],
                                          ),
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    AddFoodToPro(
                                                        pro_id:
                                                            filterItems[index]
                                                                .proId,
                                                        pro_discount:
                                                            filterItems[index]
                                                                .proDiscount),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

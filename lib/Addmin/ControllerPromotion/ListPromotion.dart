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
  List<PromotionModel> _Prodata;
  Future<Null> GetPro() async {
    var url = "http://itoknode.comsciproject.com/pro/ProAll";
    final response = await http.get(Uri.parse(url));
    print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() {
        final String responseString = response.body;
        _Prodata = promotionModelFromJson(responseString);
        // startdate = _Prodata[0].proStartDate;
        // enddate = _Prodata[0].proEndDate;
        // sd = startdate.split("T");
        // ed = enddate.split("T");
        // date.text = "${sd[0]} - ${ed[0]}";
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
      body: (_Prodata == null)
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
                            _Prodata.length,
                            (index) => DataRow(
                                  cells: <DataCell>[
                                    DataCell(Container(
                                      child: Text(
                                        _Prodata[index].proName,
                                        style: GoogleFonts.kanit(
                                            textStyle:
                                                TextStyle(color: Colors.black)),
                                      ),
                                    )),
                                    DataCell(Center(
                                      child: Text(
                                        "${_Prodata[index].proStartDate.day}/${_Prodata[index].proStartDate.month}/${_Prodata[index].proStartDate.year} - ${_Prodata[index].proEndDate.day}/${_Prodata[index].proEndDate.month}/${_Prodata[index].proEndDate.year}",
                                        style: GoogleFonts.kanit(
                                            textStyle:
                                                TextStyle(color: Colors.black)),
                                      ),
                                    )),
                                    DataCell(Center(
                                        child: (_Prodata[index].proStatus == 1)
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
                                    DataCell(Center(
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.edit,
                                          color: Colors.green[600],
                                        ),
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) => editPro(
                                                        pro_id: _Prodata[index]
                                                            .proId,
                                                        pro_name:
                                                            _Prodata[index]
                                                                .proName,
                                                        pro_desc:
                                                            _Prodata[index]
                                                                .proDesc,
                                                        pro_discount:
                                                            _Prodata[index]
                                                                .proDiscount,
                                                        pro_start_date:
                                                            _Prodata[index]
                                                                .proStartDate
                                                                .toString(),
                                                        pro_end_date:
                                                            _Prodata[index]
                                                                .proEndDate
                                                                .toString(),
                                                        pro_status:
                                                            _Prodata[index]
                                                                .proStatus,
                                                      )));
                                        },
                                      ),
                                    )),
                                    DataCell(Center(
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
                                                              _Prodata[index]
                                                                  .proId,
                                                          pro_discount: _Prodata[
                                                                  index]
                                                              .proDiscount)));
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
    );
  }
}

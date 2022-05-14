import 'package:restaurant_project/Addmin/ControllerFood/AddFoods.dart';
import 'package:restaurant_project/Addmin/ControllerFood/ListFoods.dart';
import 'package:restaurant_project/Model/FoodModel/FoodsModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'editFoods.dart';

class AllFoods extends StatefulWidget {
  @override
  _AllFoodsState createState() => _AllFoodsState();
}

class _AllFoodsState extends State<AllFoods> {
  @override
  void initState() {
    super.initState();
    Getfoods();
  }

  Color greenColor = Color(0xFF5B8842);
  Color orangeColor = Color(0xFFF17532);
  List<FoodsModel> items;
  Future<Null> Getfoods() async {
    var url = "http://itoknode@itoknode.comsciproject.com/foods/Foods";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        final String responseString = response.body;
        items = foodsModelFromJson(responseString);
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
          "อาหารทั้งหมด",
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
                  .push(MaterialPageRoute(builder: (context) => AddFoods()));
            },
          ),
        ],
      ),
      body: (items == null)
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
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      horizontalMargin: 0,
                      // columnSpacing: 0,
                      columns: [
                        DataColumn(
                            label: Text(
                          'รหัส',
                          style: GoogleFonts.kanit(
                              textStyle: TextStyle(
                                  color: Color(0xFFD17E50),
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600)),
                        )),
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
                          'ราคา',
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
                          items.length,
                          (index) => DataRow(
                                cells: <DataCell>[
                                  DataCell(Center(
                                    child: Text(
                                      "${items[index].foodId}",
                                      style: GoogleFonts.kanit(
                                          textStyle:
                                              TextStyle(color: Colors.black)),
                                    ),
                                  )),
                                  DataCell(Container(
                                    width: 100,
                                    child: Text(
                                      items[index].foodName,
                                      style: GoogleFonts.kanit(
                                          textStyle:
                                              TextStyle(color: Colors.black)),
                                    ),
                                  )),
                                  DataCell(Center(
                                    child: Text(
                                      "${items[index].foodPrice}",
                                      style: GoogleFonts.kanit(
                                          textStyle:
                                              TextStyle(color: Colors.black)),
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
                                            .push(MaterialPageRoute(
                                                builder: (context) => editFoods(
                                                      food_id:
                                                          items[index].foodId,
                                                      type_id:
                                                          items[index].typeId,
                                                      food_name:
                                                          items[index].foodName,
                                                      food_img:
                                                          items[index].foodImg,
                                                      food_price: items[index]
                                                          .foodPrice,
                                                      food_status: items[index]
                                                          .foodStatus,
                                                    )));
                                      },
                                    ),
                                  )),
                                ],
                              )),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

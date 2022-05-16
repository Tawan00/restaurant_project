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

  List<FoodsModel> filterItems;
  List<FoodsModel> items;
  Future<Null> Getfoods() async {
    var url = "http://itoknode@itoknode.comsciproject.com/foods/Foods";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        final String responseString = response.body;
        items = foodsModelFromJson(responseString);
        filterItems = items;
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
                hintText: "ชื่อ หรือ ราคา",
                hintStyle: GoogleFonts.kanit(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w400, color: Colors.black54)),
                icon: Icon(
                  Icons.search,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  filterItems = items
                      .where((u) => (u.foodName
                              .toString()
                              .toLowerCase()
                              .contains(value.toLowerCase()) ||
                          u.foodPrice
                              .toString()
                              .toLowerCase()
                              .contains(value.toLowerCase())))
                      .toList();
                });
              },
            ),
          ),
          Expanded(
            child: (items == null)
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
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
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
                                  filterItems.length,
                                  (index) => DataRow(
                                        cells: <DataCell>[
                                          DataCell(Center(
                                            child: Text(
                                              "${filterItems[index].foodId}",
                                              style: GoogleFonts.kanit(
                                                  textStyle: TextStyle(
                                                      color: Colors.black)),
                                            ),
                                          )),
                                          DataCell(Container(
                                            width: 100,
                                            child: Text(
                                              filterItems[index].foodName,
                                              style: GoogleFonts.kanit(
                                                  textStyle: TextStyle(
                                                      color: Colors.black)),
                                            ),
                                          )),
                                          DataCell(Center(
                                            child: Text(
                                              "${filterItems[index].foodPrice}",
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
                                                                editFoods(
                                                                  food_id: filterItems[
                                                                          index]
                                                                      .foodId,
                                                                  type_id: filterItems[
                                                                          index]
                                                                      .typeId,
                                                                  food_name: filterItems[
                                                                          index]
                                                                      .foodName,
                                                                  food_img: filterItems[
                                                                          index]
                                                                      .foodImg,
                                                                  food_price: filterItems[
                                                                          index]
                                                                      .foodPrice,
                                                                  food_status:
                                                                      filterItems[
                                                                              index]
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
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

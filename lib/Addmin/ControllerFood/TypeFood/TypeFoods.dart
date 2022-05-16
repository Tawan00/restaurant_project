import 'package:restaurant_project/Addmin/ControllerFood/ListFoods.dart';
import 'package:restaurant_project/Addmin/ControllerFood/TypeFood/addType.dart';
import 'package:restaurant_project/Addmin/ControllerFood/TypeFood/editType.dart';
import 'package:restaurant_project/Addmin/ControllerTable/addTable.dart';
import 'package:restaurant_project/Model/FoodModel/TypeFoodsModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class TypeFoods extends StatefulWidget {
  @override
  _TypeFoodsState createState() => _TypeFoodsState();
}

class _TypeFoodsState extends State<TypeFoods> {
  @override
  void initState() {
    super.initState();
    Getfoods();
  }

  List<TypeFoodsModel> filterItems;
  List<TypeFoodsModel> _typeFoods;
  Future<Null> Getfoods() async {
    var url = "http://itoknode@itoknode.comsciproject.com/foods/TypeFoods";
    final response = await http.get(Uri.parse(url));

    print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() {
        final String responseString = response.body;
        _typeFoods = typeFoodsModelFromJson(responseString);
        filterItems = _typeFoods;
      });
      print(_typeFoods);
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
            "ประเภทอาหาร",
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
                    .push(MaterialPageRoute(builder: (context) => addType()));
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
                  hintText: "ชื่อ",
                  hintStyle: GoogleFonts.kanit(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w400, color: Colors.black54)),
                  icon: Icon(
                    Icons.search,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    filterItems = _typeFoods
                        .where((u) => (u.tfName
                            .toString()
                            .toLowerCase()
                            .contains(value.toLowerCase())))
                        .toList();
                  });
                },
              ),
            ),
            Expanded(
              child: (_typeFoods == null)
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
                                    'รหัส',
                                    style: GoogleFonts.kanit(
                                        textStyle: TextStyle(
                                            color: Color(0xFFD17E50),
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w600)),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    'ประเภท',
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
                                                "${filterItems[index].tfId}",
                                                style: GoogleFonts.kanit(
                                                    textStyle: TextStyle(
                                                        color: Colors.black)),
                                              ),
                                            )),
                                            DataCell(Text(
                                              filterItems[index].tfName,
                                              style: GoogleFonts.kanit(
                                                  textStyle: TextStyle(
                                                      color: Colors.black)),
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
                                                          builder: (context) => editType(
                                                              tf_id:
                                                                  filterItems[
                                                                          index]
                                                                      .tfId,
                                                              tf_name:
                                                                  filterItems[
                                                                          index]
                                                                      .tfName)));
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
        ));
  }
}

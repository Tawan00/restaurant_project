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

  List<TypeFoodsModel> _typeFoods;
  Future<Null> Getfoods() async {
    var url = "http://itoknode@itoknode.comsciproject.com/foods/TypeFoods";
    final response = await http.get(Uri.parse(url));

    print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() {
        final String responseString = response.body;
        _typeFoods = typeFoodsModelFromJson(responseString);
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
      body: (_typeFoods == null)
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
                            _typeFoods.length,
                            (index) => DataRow(
                                  cells: <DataCell>[
                                    DataCell(Center(
                                      child: Text(
                                        "${_typeFoods[index].tfId}",
                                        style: GoogleFonts.kanit(
                                            textStyle:
                                                TextStyle(color: Colors.black)),
                                      ),
                                    )),
                                    DataCell(Text(
                                      _typeFoods[index].tfName,
                                      style: GoogleFonts.kanit(
                                          textStyle:
                                              TextStyle(color: Colors.black)),
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
                                                      editType(
                                                          tf_id:
                                                              _typeFoods[index]
                                                                  .tfId,
                                                          tf_name:
                                                              _typeFoods[index]
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
    );
  }
}

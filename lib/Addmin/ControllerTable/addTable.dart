import 'package:flutter/services.dart';
import 'package:restaurant_project/Addmin/ControllerTable/TableList.dart';
import 'package:restaurant_project/Model/AEModel/TkAddModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

import 'dialogTable.dart';

class AddTable extends StatefulWidget {
  @override
  _AddTableState createState() => _AddTableState();
}

class _AddTableState extends State<AddTable> {
  Future<TkAddModel> Add(String tb_number, String tb_count) async {
    final String url = "http://itoknode@itoknode.comsciproject.com/table/Add";
    final response = await http.post(Uri.parse(url),
        body: {"tb_number": tb_number, "tb_count": tb_count});

    print(response.statusCode);
    if (response.statusCode == 200) {
      String responseString = response.body;
      return tkAddModelFromJson(responseString);
    } else {
      return null;
    }
  }

  Color greenColor = Color(0xFF5B8842);
  Color orangeColor = Color(0xFFF17532);
  var tbNumber = TextEditingController();
  var tbCount = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: orangeColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "เพิ่มโต๊ะ",
          style: GoogleFonts.prompt(textStyle: TextStyle(color: Colors.white)),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => TableList()));
          },
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: 400,
            child: Padding(
              padding: EdgeInsets.only(
                  top: 16.0, bottom: 16.0, left: 16.0, right: 16.0),
              child: InkWell(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3.0,
                            blurRadius: 5.0),
                      ],
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 15.0, left: 20.0),
                                    child: Text(
                                      'เบอร์โต๊ะ',
                                      style: GoogleFonts.kanit(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.0),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: TextField(
                                        controller: tbNumber,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                          LengthLimitingTextInputFormatter(3),],
                                        decoration: InputDecoration(
                                            labelStyle: GoogleFonts.kanit(
                                                textStyle: TextStyle(
                                                    color: Colors.green[700])),
                                            fillColor: Colors.black12,
                                            filled: true,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20))),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      'จำนวนที่นั่ง',
                                      style: GoogleFonts.kanit(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.0),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: TextField(
                                        controller: tbCount,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                          LengthLimitingTextInputFormatter(2),],
                                        decoration: InputDecoration(
                                            labelStyle: GoogleFonts.kanit(
                                                textStyle: TextStyle(
                                                    color: Colors.green[700])),
                                            fillColor: Colors.black12,
                                            filled: true,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20))),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 120,
                            height: 45,
                            child: GestureDetector(
                              onTap: () async {
                                if(tbNumber.text.isEmpty || tbCount.text.isEmpty){
                                  showEnterAllDialog(context);
                                }else if(int.parse(tbCount.text) <= 0){
                                  showAddEnterCountDialog(context);
                                } else{
                                  final TkAddModel add =
                                      await Add(tbNumber.text, tbCount.text);
                                  if (add.message == "Success") {
                                    showAddEndDialog(context);
                                  }else{
                                    showAddFailDialog(context);
                                  }
                                }
                              },
                              child: Container(
                                height: 50,
                                child: Material(
                                  borderRadius: BorderRadius.circular(25.0),
                                  shadowColor: Colors.orangeAccent,
                                  color: orangeColor,
                                  elevation: 7.0,
                                  child: Center(
                                    child: Text(
                                      'ตกลง',
                                      style: GoogleFonts.kanit(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


}

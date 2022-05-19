import 'package:flutter/services.dart';
import 'package:restaurant_project/Addmin/ControllerTable/TableList.dart';
import 'package:restaurant_project/Model/AEModel/EditModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'dialogTable.dart';

class editTable extends StatefulWidget {
  @override
  _editTableState createState() => _editTableState();
  int tb_id;
  int tb_count;
  int tb_status;

  editTable({this.tb_id, this.tb_count, this.tb_status});
}

class _editTableState extends State<editTable> {
  @override
  void initState() {
    super.initState();
    tbId.text = this.widget.tb_id.toString();
    tbCount.text = this.widget.tb_count.toString();
    tbStatus.text = this.widget.tb_status.toString();
  }

  Color greenColor = Color(0xFF5B8842);
  Color orangeColor = Color(0xFFF17532);
  var tbId = TextEditingController();
  var tbCount = TextEditingController();
  var tbStatus = TextEditingController();
  List<String> tablestatus = ["ว่าง", "ไม่ว่าง"];
  String value;
  String dropdownValue = 'สถานะ';
  Future<EditModel> Edit(
      String tb_id, String tb_count, String tb_status) async {
    final String url =
        "http://itoknode@itoknode.comsciproject.com/table/UpdateTable";
    final response = await http.post(Uri.parse(url),
        body: {"tb_id": tb_id, "tb_count": tb_count, "tb_status": tb_status});

    print(response.statusCode);
    if (response.statusCode == 200) {
      String responseString = response.body;
      return editModelFromJson(responseString);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: orangeColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "แก้ไขโต๊ะ",
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
                                  Padding(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      'สถานะ',
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
                                        controller: tbStatus,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 120,
                            height: 45,
                            child: GestureDetector(
                              onTap: () async {

                                if(tbCount.text.isEmpty || tbStatus.text.isEmpty){
                                  showEnterAllDialog(context);
                                }else if(int.parse(tbStatus.text) > 2 ){
                                  showEditEnterCountDialog(context);
                                }
                                else{
                                  final EditModel edit = await Edit(
                                      tbId.text, tbCount.text, tbStatus.text);
                                  if (edit.message == "Success") {
                                    showEditEndDialog(context);
                                  }else{

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

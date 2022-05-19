import 'package:restaurant_project/Addmin/ControllerFood/TypeFood/TypeFoods.dart';
import 'package:restaurant_project/Model/AEModel/EditModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'dialogType.dart';

class editType extends StatefulWidget {
  @override
  _editTypeState createState() => _editTypeState();
  int tf_id;
  String tf_name;
  editType({this.tf_id, this.tf_name});
}

class _editTypeState extends State<editType> {
  @override
  void initState() {
    super.initState();
    tfId.text = this.widget.tf_id.toString();
    tfName.text = this.widget.tf_name;
  }

  Color greenColor = Color(0xFF5B8842);
  Color orangeColor = Color(0xFFF17532);
  var tfId = TextEditingController();
  var tfName = TextEditingController();
  Future<EditModel> Edit(String tf_id, String tf_name) async {
    final String url =
        "http://itoknode@itoknode.comsciproject.com/foods/UpdateType";
    final response = await http
        .post(Uri.parse(url), body: {"tf_id": tf_id, "tf_name": tf_name});

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
          "แก้ไขประเภทอาหาร",
          style: GoogleFonts.prompt(textStyle: TextStyle(color: Colors.white)),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => TypeFoods()));
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
                                      'รหัส',
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
                                        enabled: false,
                                        controller: tfId,
                                        decoration: InputDecoration(
                                          labelStyle: GoogleFonts.kanit(
                                              textStyle: TextStyle(
                                                  color: Colors.green[700])),
                                          fillColor: Colors.black12,
                                          filled: true,
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          suffixIcon: Icon(
                                            Icons.check,
                                            color: Colors.green[700],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      'ชื่อประเภทอาหาร',
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
                                        controller: tfName,
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
                                try{
                                  if(tfName.text.isEmpty){
                                    showEnterAllDialog(context);
                                  }else{
                                    final EditModel edit = await Edit(tfId.text, tfName.text);
                                    if (edit.message == "Success") {
                                      showEditEndDialog(context);
                                    }else{
                                      showFailDialog(context);
                                    }
                                  }
                                }catch (e){
                                  showFailDialog(context);
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

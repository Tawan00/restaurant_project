import 'package:restaurant_project/Login/Login.dart';
import 'package:restaurant_project/Model/AEModel/TkAddModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class ResetPass extends StatefulWidget {
  int Id;
  String Name;
  ResetPass({this.Id, this.Name});

  @override
  _ResetPassState createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  var IdControl = TextEditingController();
  var NameControl = TextEditingController();
  var PassControl = TextEditingController();

  @override
  void initState() {
    super.initState();
    IdControl.text = this.widget.Id.toString();
    NameControl.text = this.widget.Name;
  }

  Future<TkAddModel> ResetPassword(String acc_id, String acc_pass) async {
    final String url =
        "http://itoknode@itoknode.comsciproject.com/forget/forgetpass";
    final response = await http
        .post(Uri.parse(url), body: {"acc_id": acc_id, "acc_pass": acc_pass});

    if (response.statusCode == 200) {
      String responseString = response.body;
      return tkAddModelFromJson(responseString);
    } else {
      String responseString = response.body;
      return tkAddModelFromJson(responseString);
    }
  }

  @override
  Widget build(BuildContext context) {
    Color greenColor = Color(0xFF5B8842);
    Color orangeColor = Color(0xFFF17532);
    return Scaffold(
      backgroundColor: Color(0xFFFCFAF8),
      appBar: AppBar(
        backgroundColor: Color(0xFFFCFAF8),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "รีเซ็ตรหัสผ่าน",
          style: GoogleFonts.prompt(textStyle: TextStyle(color: Colors.black)),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (context) => HomePage(
            //         // username: this.widget.username,
            //         )));
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
                        padding: EdgeInsets.only(top: 15.0, left: 20.0),
                        child: Text(
                          'ชื่อผู้ใช้งาน',
                          style: GoogleFonts.kanit(
                            textStyle:
                                TextStyle(color: Colors.black, fontSize: 15.0),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: TextField(
                            enabled: false,
                            controller: NameControl,

                            style: GoogleFonts.kanit(
                                textStyle: TextStyle(color: Colors.black)),
                            //controller: nameController
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'ชื่อผู้ใช้งาน',
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
                          'รหัสผ่านใหม่',
                          style: GoogleFonts.kanit(
                            textStyle:
                                TextStyle(color: Colors.black, fontSize: 15.0),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: TextField(
                            controller: PassControl,
                            style: GoogleFonts.kanit(
                                textStyle: TextStyle(color: Colors.black)),
                            //controller: nameController
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'รหัสผ่านใหม่',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 120,
                            height: 45,
                            child: GestureDetector(
                              onTap: () async {
                                if (PassControl.text != "") {
                                  final TkAddModel reset = await ResetPassword(
                                      IdControl.text, PassControl.text);

                                  if (reset.message == "Success") {
                                    showPassDialog();
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
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.refresh_rounded,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          'รีเซ็ต',
                                          style: GoogleFonts.kanit(
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600)),
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

  Future showPassDialog() => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Center(
              child: Text(
            'รีเซ็ตรหัสผ่านเรียบร้อย',
            style: GoogleFonts.kanit(
                textStyle: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w600)),
          )),
          actions: [
            FlatButton(
              child: Text(
                'ยกเลิก',
                style: GoogleFonts.kanit(
                    textStyle: TextStyle(
                  color: Colors.red[400],
                  fontWeight: FontWeight.w600,
                )),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                'ใช่',
                style: GoogleFonts.kanit(
                    textStyle: TextStyle(
                  color: Colors.green[400],
                  fontWeight: FontWeight.w600,
                )),
              ),
              onPressed: () async {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => Login()),
                    (route) => false);
              },
            ),
          ],
        ),
      );
}

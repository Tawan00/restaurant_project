import 'package:restaurant_project/Model/StroreModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class EditStore extends StatefulWidget {
  @override
  State<EditStore> createState() => _EditStoreState();
}

class _EditStoreState extends State<EditStore> {
  @override
  void initState() {
    super.initState();
    getDatastore();
  }

  var _nameStore = TextEditingController();
  var _nameMg = TextEditingController();
  var _snameMg = TextEditingController();
  var _addr = TextEditingController();
  var _email = TextEditingController();
  var _tel = TextEditingController();
  var _opentime = TextEditingController();
  var _closetime = TextEditingController();
  var _status = TextEditingController();

  List<StoreModel> _dataStore;
  Future<Null> getDatastore() async {
    var url = "http://itoknode.comsciproject.com/store/DataStore";
    final response = await http.get(Uri.parse(url));
    print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() {
        final String responseString = response.body;
        _dataStore = storeModelFromJson(responseString);
        _nameStore.text = _dataStore[0].shopName;
        _nameMg.text = _dataStore[0].shopMgName;
        _snameMg.text = _dataStore[0].shopMgSname;
        _addr.text = _dataStore[0].shopAddr;
        _email.text = _dataStore[0].shopEmail;
        _tel.text = _dataStore[0].shopTel;
        _opentime.text = _dataStore[0].shopOpentime;
        _closetime.text = _dataStore[0].shopClosetime;
      });
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCFAF8),
      appBar: AppBar(
        backgroundColor: Color(0xFFFCFAF8),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "แก้ไขข้อมูลร้าน",
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
      body: (_dataStore == null)
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
                  height: 650,
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
                                'ชื่อร้าน',
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                      color: Colors.black, fontSize: 15.0),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: TextField(
                                  controller: _nameStore,
                                  style: GoogleFonts.kanit(
                                      textStyle:
                                          TextStyle(color: Colors.black)),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'ชื่อร้าน',
                                    suffixIcon: Icon(
                                      Icons.check,
                                      color: Colors.green[700],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Padding(
                            //   padding: EdgeInsets.only(top: 5.0, left: 20.0),
                            //   child: Text(
                            //     'เจ้าของร้าน',
                            //     style: GoogleFonts.kanit(
                            //       textStyle: TextStyle(
                            //           color: Colors.black, fontSize: 15.0),
                            //     ),
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: TextField(
                                  controller: _nameMg,
                                  style: GoogleFonts.kanit(
                                      textStyle:
                                          TextStyle(color: Colors.black)),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'ชื่อเจ้าของร้าน',
                                    suffixIcon: Icon(
                                      Icons.check,
                                      color: Colors.green[700],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: TextField(
                                  controller: _snameMg,
                                  style: GoogleFonts.kanit(
                                      textStyle:
                                          TextStyle(color: Colors.black)),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'นามสกุลเจ้าของร้าน',
                                    suffixIcon: Icon(
                                      Icons.check,
                                      color: Colors.green[700],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: TextField(
                                  controller: _addr,
                                  style: GoogleFonts.kanit(
                                      textStyle:
                                          TextStyle(color: Colors.black)),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'สถานที่ตั้งร้าน',
                                    suffixIcon: Icon(
                                      Icons.check,
                                      color: Colors.green[700],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: TextField(
                                  controller: _email,
                                  style: GoogleFonts.kanit(
                                      textStyle:
                                          TextStyle(color: Colors.black)),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'อีเมล',
                                    suffixIcon: Icon(
                                      Icons.check,
                                      color: Colors.green[700],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: TextField(
                                  controller: _tel,
                                  style: GoogleFonts.kanit(
                                      textStyle:
                                          TextStyle(color: Colors.black)),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'เบอร์ติดต่อ',
                                    suffixIcon: Icon(
                                      Icons.check,
                                      color: Colors.green[700],
                                    ),
                                  ),
                                ),
                              ),
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

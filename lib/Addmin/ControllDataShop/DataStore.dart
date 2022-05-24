import 'package:flutter/services.dart';
import 'package:restaurant_project/Addmin/MainAdmin.dart';
import 'package:restaurant_project/Model/MessageModel.dart';
import 'package:restaurant_project/Model/StroreModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class DataStore extends StatefulWidget {
  @override
  _DataStoreState createState() => _DataStoreState();
}

class _DataStoreState extends State<DataStore> {
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
  bool isButtonActive = true;

  List<StoreModel> _dataStore;
  Future<Null> getDatastore() async {
    var url = "http://itoknode.comsciproject.com/store/DataStore";
    final response = await http.get(Uri.parse(url));
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

  Future<MessageModel> updateStore(String nameStore, String nameMg,
      String snameMg, String addr, String email, String tel) async {
    final String url =
        "http://itoknode@itoknode.comsciproject.com/store/UpdateStore";
    final response = await http.post(Uri.parse(url), body: {
      "shop_name": nameStore,
      "shop_mg_name": nameMg,
      "shop_mg_sname": snameMg,
      "shop_addr": addr,
      "shop_email": email,
      "shop_tel": tel
    });

    print(response.statusCode);
    if (response.statusCode == 200) {
      String responseString = response.body;
      return messageModelFromJson(responseString);
    } else {
      return null;
    }
  }

  Future<MessageModel> updateStatus(String status) async {
    final String url =
        "http://itoknode@itoknode.comsciproject.com/store/UpdateStatusStore";
    final response =
        await http.post(Uri.parse(url), body: {"shop_status": status});
    print(response.statusCode);
    if (response.statusCode == 200) {
      String responseString = response.body;
      return messageModelFromJson(responseString);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "จัดการข้อมูลร้านค้า",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => MainAdmin()));
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
                  height: 700,
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
                                'ข้อมูลร้าน',
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
                                  keyboardType: TextInputType.emailAddress,
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
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(10)],
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
                            Center(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 5),
                                    child: SizedBox(
                                      width: 200,
                                      height: 40,
                                      child: RaisedButton(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 30),
                                        onPressed: () async {
                                          final MessageModel UPDATE =
                                              await updateStore(
                                                  _nameStore.text,
                                                  _nameMg.text,
                                                  _snameMg.text,
                                                  _addr.text,
                                                  _email.text,
                                                  _tel.text);
                                          if (UPDATE.message == "Success") {
                                            print("Updete Success");
                                            Navigator.of(context).push(MaterialPageRoute(
                                                builder: (context) => MainAdmin()));
                                          } else {
                                            print('Update Failed');
                                          }
                                        },
                                        color: Colors.green,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)),
                                        ),
                                        child: Text(
                                          "ยืนยัน",
                                          style: GoogleFonts.kanit(
                                            textStyle:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: LiteRollingSwitch(
                                      value: _dataStore[0].shopStatus == 0
                                          ? false
                                          : true,
                                      textOn: "On",
                                      textOff: "Off",
                                      colorOn: Colors.greenAccent,
                                      colorOff: Colors.redAccent,
                                      iconOn: Icons.done,
                                      iconOff: Icons.alarm_off,
                                      textSize: 18.0,
                                      onChanged: (bool position) async {
                                        if (position == true) {
                                          final MessageModel UPDATE =
                                              await updateStatus("1");
                                          if (UPDATE.message == "Success") {
                                            print("Updete Success");
                                          } else {
                                            print('Update Failed');
                                          }
                                        } else {
                                          final MessageModel UPDATE =
                                              await updateStatus("0");
                                          if (UPDATE.message == "Success") {
                                            print("Updete Success");
                                          } else {
                                            print('Update Failed');
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                ],
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

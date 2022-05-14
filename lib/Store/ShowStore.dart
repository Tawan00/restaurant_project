import 'package:restaurant_project/Homepage/HomePage.dart';
import 'package:restaurant_project/Model/StroreModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Showstore extends StatefulWidget {
  @override
  State<Showstore> createState() => _ShowstoreState();
}

class _ShowstoreState extends State<Showstore> {
  @override
  void initState() {
    super.initState();
    getDatastore();
  }

  Color greenColor = Color(0xFF5B8842);
  Color orangeColor = Color(0xFFF17532);

  List<StoreModel> _dataStore;
  Future<Null> getDatastore() async {
    var url = "http://itoknode.comsciproject.com/store/DataStore";
    final response = await http.get(Uri.parse(url));
    print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() {
        final String responseString = response.body;
        _dataStore = storeModelFromJson(responseString);
      });
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
          "ข้อมูลร้าน",
          style: GoogleFonts.kanit(textStyle: TextStyle(color: Colors.white)),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomePage()));
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
                  width: double.infinity,
                  height: 180,
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                      color: Color(0xfff6f6f6),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(90, 20, 20, 20),
                          blurRadius: 0.8,
                          offset: Offset(9, 9),
                        )
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 45,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 42,
                          backgroundImage: AssetImage("assets/images/222.jpg"),
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        _dataStore[0].shopName,
                        style: GoogleFonts.kanit(
                            textStyle: TextStyle(
                          color: greenColor,
                          fontSize: 18,
                        )),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(_dataStore[0].shopAddr,
                          style: GoogleFonts.kanit(
                              textStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ))),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 150,
                  margin: EdgeInsets.symmetric(
                    // vertical: 3,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                      color: Color(0xfff6f6f6),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(90, 20, 20, 20),
                          blurRadius: 0.8,
                          offset: Offset(9, 9),
                        )
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ผู้จัดการร้าน",
                        style: GoogleFonts.kanit(
                            textStyle: TextStyle(
                          color: greenColor,
                          fontSize: 18,
                        )),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                          "${_dataStore[0].shopMgName} ${_dataStore[0].shopMgSname}",
                          style: GoogleFonts.kanit(
                              textStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ))),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        _dataStore[0].shopEmail,
                        style: GoogleFonts.kanit(
                            textStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        )),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        _dataStore[0].shopTel,
                        style: GoogleFonts.kanit(
                            textStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        )),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 150,
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                      color: Color(0xfff6f6f6),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(90, 20, 20, 20),
                          blurRadius: 0.8,
                          offset: Offset(9, 9),
                        )
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "เวลาเปิดให้บริการ",
                        style: GoogleFonts.kanit(
                            textStyle: TextStyle(
                          color: greenColor,
                          fontSize: 18,
                        )),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                          "${_dataStore[0].shopOpentime} - ${_dataStore[0].shopClosetime}",
                          style: GoogleFonts.kanit(
                              textStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ))),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

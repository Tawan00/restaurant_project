import 'package:restaurant_project/Addmin/ControllDataShop/DataStore.dart';
import 'package:restaurant_project/Addmin/ControllerFood/ListFoods.dart';
import 'package:restaurant_project/Addmin/ControllerOrder/main_order.dart';
import 'package:restaurant_project/Addmin/ControllerTable/TableList.dart';
import 'package:restaurant_project/Addmin/ControllerOrder/TableOrderList.dart';
import 'package:restaurant_project/Addmin/ControllerUser/UserList.dart';
import 'package:restaurant_project/Model/UserModel/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:restaurant_project/Login/Login.dart';
import 'package:http/http.dart' as http;

class MainAdmin extends StatefulWidget {
  @override
  _MainAdminState createState() => _MainAdminState();
}

class _MainAdminState extends State<MainAdmin> {
  @override
  void initState() {
    super.initState();
    getToken();
  }

  String token = "";
  Future<Null> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString("token");
    getdata();
  }

  List<UserModel> userModel;
  Future<Null> getdata() async {
    final String url = "http://itoknode@itoknode.comsciproject.com/user/User";
    final response = await http
        .get(Uri.parse(url), headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      setState(() {
        var responseString = response.body;
        userModel = userModelFromJson(responseString);
      });
    } else {
      return null;
    }
  }

  Color greenColor = Color(0xFF5B8842);
  Color orangeColor = Color(0xFFF17532);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        elevation: 0,
        centerTitle: true,
        title: Text(
          "ADMIN STATION",
          style: GoogleFonts.prompt(textStyle: TextStyle(color: Colors.white)),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app_outlined),
            color: Colors.white,
            onPressed: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.clear();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (BuildContext context) => Login()),
                  (route) => false);
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(left: 30.0, right: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 125.0,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Text('E&E',
                          style: GoogleFonts.kanit(
                              textStyle: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: orangeColor))),
                      Positioned(
                          top: 50.0,
                          child: Text(
                            'Restaurant',
                            style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF5B8842))),
                          )),
                      Positioned(
                        top: 95.0,
                        left: 250.0,
                        child: Container(
                            height: 10.0,
                            width: 10.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: orangeColor)),
                      )
                    ],
                  ),
                ),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  children: [
                    Card(
                      margin: EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => UserList()));
                        },
                        splashColor: Colors.green,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.person,
                                size: 70.0,
                                color: Colors.teal,
                              ),
                              Text("จัดการผู้ใช้งาน",
                                  style: GoogleFonts.kanit(
                                    textStyle: TextStyle(
                                        color: Color(0xFFD17E50),
                                        fontSize: 17.0),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ListFoods()));
                        },
                        splashColor: Colors.green,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.fastfood,
                                color: Colors.orange,
                                size: 70.0,
                              ),
                              Text("จัดการอาหาร",
                                  style: GoogleFonts.kanit(
                                    textStyle: TextStyle(
                                        color: Color(0xFFD17E50),
                                        fontSize: 17.0),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DataStore()));
                        },
                        splashColor: Colors.green,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.storefront,
                                size: 70.0,
                                color: Colors.green[700],
                              ),
                              Text("จัดการข้อมูลร้าน",
                                  style: GoogleFonts.kanit(
                                    textStyle: TextStyle(
                                        color: Color(0xFFD17E50),
                                        fontSize: 17.0),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TableList()));
                        },
                        splashColor: Colors.green,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.deck_outlined,
                                size: 70.0,
                                color: Colors.brown,
                              ),
                              Text("จัดการข้อมูลโต๊ะ",
                                  style: GoogleFonts.kanit(
                                    textStyle: TextStyle(
                                        color: Color(0xFFD17E50),
                                        fontSize: 17.0),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MainOrder()));
                        },
                        splashColor: Colors.green,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.room_service,
                                  size: 70.0, color: Color(0xFFA7226F)),
                              Text("ออเดอร์ลูกค้า",
                                  style: GoogleFonts.kanit(
                                    textStyle: TextStyle(
                                        color: Color(0xFFD17E50),
                                        fontSize: 17.0),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () async {
                          SharedPreferences preferences =
                              await SharedPreferences.getInstance();
                          preferences.clear();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (BuildContext context) => Login()),
                              (route) => false);
                        },
                        splashColor: Colors.green,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.exit_to_app,
                                size: 70.0,
                                color: Colors.red,
                              ),
                              Text("ออกจากระบบ",
                                  style: GoogleFonts.kanit(
                                    textStyle: TextStyle(
                                        color: Color(0xFFD17E50),
                                        fontSize: 17.0),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

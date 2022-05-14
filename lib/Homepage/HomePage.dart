import 'dart:io';

import 'package:restaurant_project/Model/FoodModel/FoodProModel.dart';
import 'package:restaurant_project/Model/FoodModel/FoodsModel.dart';
import 'package:restaurant_project/Model/LRModel/LoginModel.dart';
import 'package:restaurant_project/Model/ReviewModel/reviewModel.dart';
import 'package:restaurant_project/Search/search.dart';
import 'package:restaurant_project/Search/searchfood.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_project/Login/Login.dart';
import 'package:restaurant_project/Homepage/NavBar.dart';
import 'package:restaurant_project/Table/ReceiveTable.dart';
import 'package:restaurant_project/Homepage/BottomBar.dart';
import 'package:restaurant_project/Addmin/ControllerUser/UserList.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_project/Model/UserModel/UserModel.dart';
import 'package:restaurant_project/Addmin/MainAdmin.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getToken();
  }

  Color greenColor = Color(0xFF5B8842);
  Color orangeColor = Color(0xFFF17532);

  List<UserModel> userModel;
  List<FoodProModel> Proitems;
  List<ReviewModel> Review;
  //******************************************************************************************

  String token = "";
  Future<Null> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString("token");
    getdata();
    foodsProJson();
    getReview();
  }

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

  Future<Null> foodsProJson() async {
    var url = "http://itoknode@itoknode.comsciproject.com/Pro/FoodProAll";
    final response = await http.get(Uri.parse(url));
    print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() {
        final String responseString = response.body;
        Proitems = foodProModelFromJson(responseString);
      });
    }
    print("length" + Proitems.length.toString());
  }

  Future<Null> getReview() async {
    var url = "http://itoknode@itoknode.comsciproject.com/review/ShowReview";
    final response = await http.get(Uri.parse(url));
    print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() {
        final String responseString = response.body;
        Review = reviewModelFromJson(responseString);
      });
    }
    print(Review);
  }

  //******************************************************************************************
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    return Scaffold(
      backgroundColor: Color(0xFFFCFAF8),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        //title: Text("E&E Restaurant"),
        backgroundColor: Color(0xFFFCFAF8),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app_outlined),
            color: Colors.black,
            onPressed: () async {
              // SharedPreferences preferences =
              //     await SharedPreferences.getInstance();
              // preferences.clear();
              // Navigator.of(context).pushAndRemoveUntil(
              //     MaterialPageRoute(builder: (BuildContext context) => Login()),
              //     (route) => false);
              if (token != "" && token != null) {
                showExitDialog();
              } else {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Login()));
              }
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: NavBar(
          token: token,
        ),
      ),
      body: (Proitems == null || Review == null)
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
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 125.0,
                        width: 300.0,
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
                                      shape: BoxShape.circle,
                                      color: orangeColor)),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.0, right: 5.0),
                        child: TextFormField(
                          // onTap: () =>
                          //     showSearch(context: context, delegate: Search()),
                          onTap: () async {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SearchFood()));
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Search Food",
                            hintStyle: GoogleFonts.kanit(
                                textStyle: TextStyle(color: Colors.grey)),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              //borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Review ToDay',
                        style: GoogleFonts.kanit(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 17.0)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(Review[0].rvDesc,
                                    style: GoogleFonts.kanit(
                                        textStyle: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ))),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(Review[1].rvDesc,
                                    style: GoogleFonts.kanit(
                                        textStyle: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ))),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    '${Review[0].rvDate.day}/${Review[0].rvDate.month}/${Review[0].rvDate.year}',
                                    style: GoogleFonts.kanit(
                                        textStyle: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFFE67D57),
                                    ))),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                    '${Review[1].rvDate.day}/${Review[1].rvDate.month}/${Review[1].rvDate.year}',
                                    style: GoogleFonts.kanit(
                                        textStyle: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFFE67D57),
                                    ))),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Promotion Today',
                        style: GoogleFonts.kanit(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 17.0)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 7.0,
                ),
                Container(
                  height: 250.0,
                  child: ListView.builder(
                      itemCount: Proitems.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return _buildCard(
                            Proitems[index].foodName,
                            Proitems[index].foodPriceNew.toString(),
                            Proitems[index].foodImg.toString(),
                            Proitems[index].proDiscount);
                      }),
                )
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (context) => ReceiveTales()));
          if (token != "" && token != null) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ReceiveTables()));
          } else {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Login()));
          }
        },
        backgroundColor: Color(0xFFF17532),
        child: Icon(Icons.fastfood),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBar(
          // username: this.widget.username,
          ),
    );
  }

  @override
  Widget _buildCard(String name, String price, String imgPath, int discount) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0, top: 10.0, bottom: 30.0),
      child: Container(
        height: 200.0,
        width: 200.0,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                  blurRadius: 6.0,
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5.0)
            ]),
        child: Stack(
          children: [
            // Container(
            //   height: 140.0,
            //   decoration: BoxDecoration(
            //       gradient: LinearGradient(
            //           colors: [Colors.white, Color(0xFFACBEA3)],
            //           begin: Alignment.topLeft,
            //           end: Alignment.bottomRight),
            //       borderRadius: BorderRadius.only(
            //           topLeft: Radius.circular(10.0),
            //           topRight: Radius.circular(10.0))),
            // ),
            Hero(
              tag: name,
              child: Container(
                height: 130.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(imgPath), fit: BoxFit.contain),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0))),
              ),
            ),
            Positioned(
              top: 130.0,
              right: 20.0,
              child: Material(
                elevation: 2.0,
                borderRadius: BorderRadius.circular(15.0),
                child: Container(
                  height: 30.0,
                  width: 30.0,
                  child: Center(
                    child: Text(
                      "${discount}%",
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                              color: Colors.red,
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.white),
                ),
              ),
            ),
            Positioned(
                top: 160.0,
                left: 10.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 14.0)),
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                    Container(
                      width: 175.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                '4.9',
                                style: GoogleFonts.kanit(
                                    textStyle: TextStyle(
                                        color: Colors.grey, fontSize: 12.0)),
                              ),
                              SizedBox(width: 3.0),
                              Icon(
                                Icons.star,
                                color: Color(0xFFF4C464),
                                size: 14.0,
                              ),
                              Icon(
                                Icons.star,
                                color: Color(0xFFF4C464),
                                size: 14.0,
                              ),
                              Icon(
                                Icons.star,
                                color: Color(0xFFF4C464),
                                size: 14.0,
                              ),
                              Icon(
                                Icons.star,
                                color: Color(0xFFF4C464),
                                size: 14.0,
                              ),
                              Icon(
                                Icons.star,
                                color: Color(0xFFF4C464),
                                size: 14.0,
                              ),
                            ],
                          ),
                          Text(price,
                              style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0,
                                      color: Colors.black))),
                        ],
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Future showExitDialog() => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Center(
              child: Text(
            'ต้องการออกจากระบบ?',
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
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                preferences.clear();
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

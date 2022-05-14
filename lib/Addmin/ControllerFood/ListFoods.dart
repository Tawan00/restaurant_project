import 'package:restaurant_project/Addmin/ControllerFood/AllFoods.dart';
import 'package:restaurant_project/Addmin/ControllerPromotion/ListPromotion.dart';
import 'package:restaurant_project/Addmin/MainAdmin.dart';

import 'package:restaurant_project/Addmin/ControllerFood/TypeFood/TypeFoods.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_project/Addmin/ControllerFood/AddFoods.dart';
import 'package:google_fonts/google_fonts.dart';

class ListFoods extends StatefulWidget {
  @override
  _ListFoodsState createState() => _ListFoodsState();
}

class _ListFoodsState extends State<ListFoods> {
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
          "จัดการอาหาร",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => MainAdmin()));
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
        child: GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          children: [
            Card(
              margin: EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () async {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AllFoods()));
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
                      Text("อาหารทั้งหมด",
                          style: GoogleFonts.kanit(
                            textStyle: TextStyle(
                                color: Color(0xFFD17E50), fontSize: 17.0),
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
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => TypeFoods()));
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
                      Text("ประเภทอาหาร",
                          style: GoogleFonts.kanit(
                            textStyle: TextStyle(
                                color: Color(0xFFD17E50), fontSize: 17.0),
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
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => ListPro()));
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
                      Text("โปรโมชัน",
                          style: GoogleFonts.kanit(
                            textStyle: TextStyle(
                                color: Color(0xFFD17E50), fontSize: 17.0),
                          )),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {},
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
                      Text("อาหารโปรโมชัน",
                          style: GoogleFonts.kanit(
                            textStyle: TextStyle(
                                color: Color(0xFFD17E50), fontSize: 17.0),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

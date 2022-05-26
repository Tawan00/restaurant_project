import 'package:restaurant_project/Addmin/ControllerFood/AllFoods.dart';
import 'package:restaurant_project/Addmin/ControllerOrder/AllOrderTable.dart';
import 'package:restaurant_project/Addmin/ControllerOrder/ControllerOrderfood/AdminAllBookOrder.dart';
import 'package:restaurant_project/Addmin/ControllerOrder/TableOrderList.dart';
import 'package:restaurant_project/Addmin/ControllerPromotion/ListPromotion.dart';
import 'package:restaurant_project/Addmin/MainAdmin.dart';

import 'package:restaurant_project/Addmin/ControllerFood/TypeFood/TypeFoods.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_project/Addmin/ControllerFood/AddFoods.dart';
import 'package:google_fonts/google_fonts.dart';

class MainOrder extends StatefulWidget {
  @override
  _MainOrderState createState() => _MainOrderState();
}

class _MainOrderState extends State<MainOrder> {
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
          "จัดการออเดอร์",
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
                      MaterialPageRoute(builder: (context) => AllOrderTable()));
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
                      Text("ออเดอร์ทั้งหมด",
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
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TableOrderList()));
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
                      Text("ออเดอร์ล่าสุด",
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
                      .push(MaterialPageRoute(builder: (context) => AdminAllBookOrder()));
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
                      Text("จัดการใบสั่งจองอาหาร",
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

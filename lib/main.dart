import 'package:restaurant_project/Addmin/ControllerPromotion/ListPromotion.dart';
import 'package:restaurant_project/Addmin/MainAdmin.dart';
import 'package:restaurant_project/Addmin/ControllerTable/TableList.dart';

import 'package:restaurant_project/Addmin/ControllerFood/AllFoods.dart';
import 'package:restaurant_project/Foods/Foods_page.dart';
import 'package:restaurant_project/Addmin/ControllerFood/TypeFood/TypeFoods.dart';
import 'package:restaurant_project/Homepage/NavBar.dart';
import 'package:restaurant_project/Homepage/maindrawer.dart';
import 'package:restaurant_project/Register/Signin.dart';
import 'package:restaurant_project/ReviewPage/review_page.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_project/Homepage/maindrawer.dart';
import 'package:restaurant_project/Profile/profile.dart';
import 'package:restaurant_project/Homepage/NavBar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'Login/Login.dart';
import 'package:restaurant_project/Homepage/HomePage.dart';
import 'package:restaurant_project/Table/ReceiveTable.dart';

import 'package:restaurant_project/Addmin/ControllerFood/AddFoods.dart';
import 'package:restaurant_project/Addmin/ControllerFood/ListFoods.dart';
import 'package:restaurant_project/Foods/Foods.dart';
import 'package:restaurant_project/Foods/Foods.dart';
import 'package:restaurant_project/Foods/Foods_Pro.dart';
import 'package:restaurant_project/Homepage/BottomBar.dart';

import 'package:restaurant_project/Addmin/ControllerUser/UserList.dart';
import 'package:restaurant_project/Foods/OrderList.dart';
import 'package:restaurant_project/Addmin/ControllerOrder/TableOrderList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int val = 0;
  void add() {
    setState(() {
      val += 1;
    });
  }

  Color greenColor = Color(0xFF5B8842);
  Color orangeColor = Color(0xFFF17532);
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

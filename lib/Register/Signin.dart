import 'package:restaurant_project/Login/Login.dart';
import 'package:restaurant_project/Model/AEModel/TkAddModel.dart';
import 'package:restaurant_project/main.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:restaurant_project/Homepage/maindrawer.dart';
import 'package:restaurant_project/Model/LRModel/RegisterModel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:restaurant_project/Homepage/HomePage.dart';

class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController nameController = TextEditingController();
  TextEditingController snameController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  Color greenColor = Color(0xFF5B8842);
  Color orangeColor = Color(0xFFF17532);
  TkAddModel tkaddmodel;
  Future<TkAddModel> registers(String acc_name, String acc_sname,
      String acc_email, String acc_user, String acc_pass) async {
    final String url =
        "http://itoknode@itoknode.comsciproject.com/register/regis";
    final response = await http.post(Uri.parse(url), body: {
      "acc_name": acc_name,
      "acc_sname": acc_sname,
      "acc_email": acc_email,
      "acc_user": acc_user,
      "acc_pass": acc_pass
    });

    if (response.statusCode == 200) {
      String responseString = response.body;
      return tkAddModelFromJson(responseString);
    } else {
      return null;
    }
  }

  _buildLoginForm() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      child: ListView(
        children: [
          SizedBox(
            height: 30.0,
          ),
          Container(
            height: 125.0,
            width: 200.0,
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
          SizedBox(height: 25.0),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
                labelText: 'ชื่อ',
                labelStyle: TextStyle(
                    fontFamily: 'Trueno',
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.withOpacity(0.5)),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: greenColor),
                )),
          ),
          TextField(
            controller: snameController,
            decoration: InputDecoration(
                labelText: 'นามสกุล',
                labelStyle: TextStyle(
                    fontFamily: 'Trueno',
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.withOpacity(0.5)),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: greenColor),
                )),
          ),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
                labelText: 'อีเมล',
                labelStyle: TextStyle(
                    fontFamily: 'Trueno',
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.withOpacity(0.5)),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: greenColor),
                )),
          ),
          TextField(
            controller: userController,
            decoration: InputDecoration(
                labelText: 'ผู้ใช้งาน',
                labelStyle: TextStyle(
                    fontFamily: 'Trueno',
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.withOpacity(0.5)),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: greenColor),
                )),
          ),
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
                labelText: 'รหัสผ่าน',
                labelStyle: TextStyle(
                    fontFamily: 'Trueno',
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.withOpacity(0.5)),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: greenColor),
                )),
          ),
          SizedBox(height: 50.0),
          GestureDetector(
            onTap: () async {
              if (userController.text != "" && passwordController != "") {
                final TkAddModel Register = await registers(
                  nameController.text,
                  snameController.text,
                  emailController.text,
                  userController.text,
                  passwordController.text,
                );

                if (Register.message == "Success") {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Login()));
                } else {
                  print("register message:" + Register.message);
                }
              }
            },
            child: Container(
              height: 50.0,
              child: Material(
                borderRadius: BorderRadius.circular(25.0),
                shadowColor: Colors.orangeAccent,
                color: orangeColor,
                elevation: 7.0,
                child: Center(
                  child: Text(
                    'สมัคร',
                    style: GoogleFonts.kanit(
                        textStyle: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 25.0),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFCFAF8),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "สมัครสมาชิก",
          style: GoogleFonts.prompt(textStyle: TextStyle(color: Colors.black)),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Login()));
          },
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Form(
          child: _buildLoginForm(),
        ),
      ),
    );
  }
}

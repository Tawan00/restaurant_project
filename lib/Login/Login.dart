import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_project/Addmin/MainAdmin.dart';
import 'package:restaurant_project/Homepage/HomePage.dart';
import 'package:restaurant_project/Login/ResetPass.dart';
import 'package:restaurant_project/Model/AEModel/TkAddModel.dart';
import 'package:restaurant_project/Model/LRModel/TkLoginModel.dart';
import 'package:restaurant_project/Register/Signin.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //@override
  // void initState() {
  //   super.initState();
  //   checkPreference();
  // }
  // List<String> data;

  Future<TkLoginModel> CheckAuth(String acc_user, String acc_pass) async {
    final String url = "http://itoknode@itoknode.comsciproject.com/login/log";
    final response = await http.post(Uri.parse(url),
        body: {"acc_user": acc_user, "acc_pass": acc_pass});

    if (response.statusCode == 200) {
      String responseString = response.body;
      return tkLoginModelFromJson(responseString);
    } else {
      String responseString = response.body;
      return tkLoginModelFromJson(responseString);
    }
  }

  Future<TkAddModel> ForgetPassword(String acc_user, String acc_email) async {
    final String url = "http://itoknode@itoknode.comsciproject.com/forget/for";
    final response = await http.post(Uri.parse(url),
        body: {"acc_user": acc_user, "acc_email": acc_email});

    if (response.statusCode == 200) {
      String responseString = response.body;
      return tkAddModelFromJson(responseString);
    } else {
      String responseString = response.body;
      return tkAddModelFromJson(responseString);
    }
  }

  // List<UserModel> userModel;
  String token = "";
  Future<String> checkPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return null == preferences.getString("token")
        ? ""
        : preferences.getString("token");
  }

  var userController = TextEditingController();
  var passController = TextEditingController();
  var type = TextEditingController();
  var status = TextEditingController();
  Color greenColor = Color(0xFF5B8842);
  Color orangeColor = Color(0xFFF17532);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCFAF8),
      body: FutureBuilder(
        future: checkPreference(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != "" && snapshot.data != null) {
              return HomePage();
            } else {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Form(
                  child: _buildLoginForm(),
                ),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  _buildLoginForm() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      child: ListView(
        children: [
          SizedBox(
            height: 75.0,
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
            controller: userController,
            decoration: InputDecoration(
                labelText: 'ผู้ใช้งาน',
                labelStyle: GoogleFonts.kanit(
                    textStyle: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.withOpacity(0.5))),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: greenColor),
                )),
          ),
          TextField(
            controller: passController,
            obscureText: true,
            decoration: InputDecoration(
                labelText: 'รหัสผ่าน',
                labelStyle: GoogleFonts.kanit(
                    textStyle: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.withOpacity(0.5))),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: greenColor),
                )),
          ),
          SizedBox(height: 5.0),
          GestureDetector(
            onTap: () {
              CreateDialogForgetPass();
            },
            child: Container(
              alignment: Alignment(1.0, 0.0),
              padding: EdgeInsets.only(top: 15.0, left: 20.0),
              child: InkWell(
                child: Text(
                  'ลืมรหัสผ่านใช่หรือไม่',
                  style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                          color: orangeColor,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline)),
                ),
              ),
            ),
          ),
          SizedBox(height: 50.0),
          GestureDetector(
            onTap: () async {
              if (userController.text != "" && passController.text != "") {
                final TkLoginModel Login =
                    await CheckAuth(userController.text, passController.text);
                print(Login.message);
                print(Login.status);
                print(Login.type);
                if (Login.message == "Success") {
                  if (Login.type == 1 && Login.status == 1) {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    preferences.setString("token", Login.token);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) => MainAdmin()),
                        (route) => false);
                  } else if (Login.type == 0 && Login.status == 1) {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    preferences.setString("token", Login.token);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) => HomePage()),
                        (route) => false);
                  } else if (Login.status == 0) {
                    showEndDialog();
                  }

                  // SharedPreferences preferences =
                  //     await SharedPreferences.getInstance();
                  // preferences.setString("token", Login.token);
                  // Navigator.of(context).pushAndRemoveUntil(
                  //     MaterialPageRoute(
                  //         builder: (BuildContext context) => HomePage()),
                  //     (route) => false);
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
                    'เข้าสู่ระบบ',
                    style: GoogleFonts.kanit(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 25.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "ยังไม่มีบัญชีใช่หรือไม่ ?",
                style: GoogleFonts.kanit(
                    textStyle: TextStyle(color: Colors.black)),
              ),
              SizedBox(width: 5.0),
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => SignIn()));
                },
                child: Text(
                  'สร้างบัญชีใหม่',
                  style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                          color: orangeColor,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline)),
                ),
              ),
            ],
          ),
          SizedBox(height: 30.0),
          Center(
            child: InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: Text(
                'ข้าม',
                style: GoogleFonts.kanit(
                    textStyle: TextStyle(
                        color: orangeColor,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future showEndDialog() => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text('บัญชีนี้ถูกปิดใช้บริการแล้ว'),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('ตกลง'),
              ),
            )
          ],
        ),
      );
  var user = TextEditingController();
  var email = TextEditingController();
  Future CreateDialogForgetPass() => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Container(
            height: 70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ลืมรหัสผ่านหรอ",
                  style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
                ),
                Text(
                  "ยืนยัน Username และ Email ของคุณเพื่อตั้งรหัสผ่านใหม่",
                  style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                    fontSize: 12.0,
                    color: Colors.black54,
                  )),
                ),
              ],
            ),
          ),
          content: Container(
            height: 150,
            child: Column(
              children: [
                TextField(
                  controller: user,
                  decoration: InputDecoration(
                      labelText: 'Enter your Username',
                      labelStyle: GoogleFonts.kanit(
                          textStyle: TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey.withOpacity(0.5))),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      icon: Icon(
                        Icons.person,
                        size: 20,
                      )),
                ),
                TextField(
                  controller: email,
                  decoration: InputDecoration(
                      labelText: 'Enter your email',
                      labelStyle: GoogleFonts.kanit(
                          textStyle: TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey.withOpacity(0.5))),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      icon: Icon(
                        Icons.email,
                        size: 20,
                      )),
                ),
              ],
            ),
          ),
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
                'ยืนยัน',
                style: GoogleFonts.kanit(
                    textStyle: TextStyle(
                  color: Colors.green[400],
                  fontWeight: FontWeight.w600,
                )),
              ),
              onPressed: () async {
                if (user.text != "" && email.text != "") {
                  final TkAddModel forget =
                      await ForgetPassword(user.text, email.text);
                  print(forget.message);
                  print(forget.accId);
                  print(forget.accName);
                  if (forget.message == "Success") {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ResetPass(
                              Id: forget.accId,
                              Name: forget.accName,
                            )));
                  }
                }
              },
            ),
          ],
        ),
      );
}

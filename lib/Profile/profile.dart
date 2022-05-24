import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant_project/Addmin/ControllerUser/UserList.dart';
import 'package:restaurant_project/Homepage/HomePage.dart';
import 'package:restaurant_project/Model/LRModel/LoginModel.dart';
import 'package:restaurant_project/Model/MessageModel.dart';
import 'package:restaurant_project/Model/UserModel/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    getToken();
  }

  Color greenColor = Color(0xFF5B8842);
  Color orangeColor = Color(0xFFF17532);
  var accId = TextEditingController();
  var accName = TextEditingController();
  var accSname = TextEditingController();
  var accImg = TextEditingController();
  var accAddr = TextEditingController();
  var accTel = TextEditingController();
  var accEmail = TextEditingController();
  var accUser = TextEditingController();
  var accPass = TextEditingController();
  var accLine = TextEditingController();
  var accFB = TextEditingController();
  var accType = TextEditingController();
  var accStatus = TextEditingController();

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
    print(response.body);
    if (response.statusCode == 200) {
      setState(() {
        var responseString = response.body;
        userModel = userModelFromJson(responseString);
        accId.text = userModel[0].accId.toString();
        accName.text = userModel[0].accName;
        accSname.text = userModel[0].accSname;
        accAddr.text = userModel[0].accAddr;
        accImg.text = userModel[0].accImg.toString();
        accTel.text = userModel[0].accTel;
        accEmail.text = userModel[0].accEmail;
        accUser.text = userModel[0].accUser;
        accPass.text = userModel[0].accPass;
        accLine.text = userModel[0].accLine;
        accFB.text = userModel[0].accFB;
        accType.text = userModel[0].accType.toString();
        accStatus.text = userModel[0].accStatus.toString();
      });
    } else {
      return null;
    }
  }

  Future<MessageModel> editProfile(
      String id,
      String name,
      String surname,
      String img,
      String adress,
      String phone,
      String email,
      String line,
      String facebook) async {
    final url = 'http://itoknode.comsciproject.com/register/UpdateUser';
    final response = await http.post(Uri.parse(url), body: {
      'acc_id': id,
      'acc_name': name,
      'acc_sname': surname,
      'acc_img': img,
      'acc_addr': adress,
      'acc_tel': phone,
      'acc_email': email,
      'acc_line': line,
      'acc_fb': facebook
    });
    if (response.statusCode == 200) {
      String responseString = response.body;
      return messageModelFromJson(responseString);
    } else {
      return null;
    }
  }

  File _image;
  final picker = ImagePicker();
  String BaseNoImage =
      "http://itoknode.comsciproject.com/images/users/BaseNoImage.png";

  _upload() {
    if (_image == null) return "";
    String base64Image = base64Encode(_image.readAsBytesSync());
    String fileName = _image.path.split("/").last;
    print(fileName);
    http.post("http://itoknode@itoknode.comsciproject.com/user/images", body: {
      "image": base64Image,
      "name": fileName,
    }).then((res) {
      print("status :" + res.statusCode.toString());
      print("fileName :" + fileName);
    }).catchError((err) {
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Profile",
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
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => HomePage(
                    // username: this.widget.username,
                    )));
          },
        ),
      ),
      body: (userModel == null)
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
          : Padding(
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 150,
                      width: 150,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          (_image == null)
                              ? Image.network(accImg.text)
                              : Image.file(_image),
                          Positioned(
                            left: 100,
                            bottom: 0,
                            child: SizedBox(
                              height: 50,
                              width: 50,
                              child: FlatButton(
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  side: BorderSide(color: Colors.black),
                                ),
                                color: Color(0xFFF5F6F9),
                                onPressed: () async {
                                  final pickedImage = await picker.getImage(
                                      source: ImageSource.gallery);
                                  setState(() {
                                    if (pickedImage != null) {
                                      _image = File(pickedImage.path);
                                      Image.file(_image);
                                      String filename =
                                          _image.path.split("/").last;
                                      String urlImg = 'http://' +
                                          'itoknode' +
                                          '.comsciproject.com/images/users/' +
                                          filename;
                                      accImg.text = urlImg;
                                      print("image ::" + filename.toString());
                                      print("urlImg ::" + urlImg);
                                    } else {
                                      accImg.text = BaseNoImage;
                                    }
                                  });
                                },
                                child: Icon(
                                  Icons.camera_alt_rounded,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: TextField(
                        enabled: false,
                        controller: accName,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: 'Name',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: TextField(
                        enabled: false,
                        controller: accSname,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: 'Surname',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: TextField(
                        controller: accEmail,
                        enabled: false,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: 'Email',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: TextField(
                        controller: accTel,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: 'Phone',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: TextField(
                        controller: accAddr,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: 'Address',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: TextField(
                        controller: accLine,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: 'Line',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: TextField(
                        controller: accFB,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: 'Facebook',
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 120,
                          height: 45,
                          child: RaisedButton(
                            textColor: Colors.white,
                            color: Colors.green[400],
                            child: Text(
                              'บันทึก',
                              style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600)),
                            ),
                            onPressed: () async {
                              _upload();
                              final MessageModel edit = await editProfile(
                                  accId.text,
                                  accName.text,
                                  accSname.text,
                                  accImg.text,
                                  accAddr.text,
                                  accTel.text,
                                  accEmail.text,
                                  accLine.text,
                                  accFB.text);
                              if (edit.message == "Success") {
                                showPassDialog();
                              }
                            },
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(30)),
                        SizedBox(
                          width: 120,
                          height: 45,
                          child: RaisedButton(
                            textColor: Colors.white,
                            color: Colors.red[400],
                            child: Text(
                              'ยกเลิก',
                              style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600)),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => HomePage()));
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Future showPassDialog() => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Center(
              child: Text(
            'แก้ไขข้อมูลเสร็จสมบูรณ์',
            style: GoogleFonts.kanit(
                textStyle: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w600)),
          )),
          actions: [
            FlatButton(
              child: Text(
                'ตกลง',
                style: GoogleFonts.kanit(
                    textStyle: TextStyle(
                  color: Colors.green[700],
                  fontWeight: FontWeight.w600,
                )),
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Profile()));
              },
            )
          ],
        ),
      );
}

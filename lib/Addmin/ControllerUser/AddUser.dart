import 'dart:convert';
import 'dart:typed_data';

import 'package:restaurant_project/Addmin/ControllerUser/UserList.dart';
import 'package:restaurant_project/Model/AEModel/TkAddModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_project/Model/UserModel/AddUserModel.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'dart:io' as IO;
import 'package:restaurant_project/Model/LRModel/RegisterModel.dart';
import 'package:image_utils_class/image_utils_class.dart';

class AddUser extends StatefulWidget {
  String username;

  AddUser({this.username});

  @override
  _AddUserState createState() => _AddUserState();
}

AdduserModel datamodel;
TkAddModel tkaddmodel;

class _AddUserState extends State<AddUser> {
  Future<TkAddModel> add(
    String acc_name,
    String acc_sname,
    String acc_img,
    String acc_addr,
    String acc_tel,
    String acc_email,
    String acc_user,
    String acc_pass,
    String acc_line,
    String acc_fb,
  ) async {
    final String url =
        "http://itoknode@itoknode.comsciproject.com/user/addUser";
    final response = await http.post(Uri.parse(url), body: {
      "acc_name": acc_name,
      "acc_sname": acc_sname,
      "acc_img": acc_img,
      "acc_addr": acc_addr,
      "acc_tel": acc_tel,
      "acc_email": acc_email,
      "acc_user": acc_user,
      "acc_pass": acc_pass,
      "acc_line": acc_line,
      "acc_fb": acc_fb
    });

    if (response.statusCode == 200) {
      String responseString = response.body;
      return tkAddModelFromJson(responseString);
    } else {
      return null;
    }
    // });
  }

  var nameController = TextEditingController();
  var snameController = TextEditingController();
  var imgController = TextEditingController();
  var addrController = TextEditingController();
  var telController = TextEditingController();
  var emailController = TextEditingController();
  var userController = TextEditingController();
  var passController = TextEditingController();
  var lineController = TextEditingController();
  var faceController = TextEditingController();

  Color greenColor = Color(0xFF5B8842);
  Color orangeColor = Color(0xFFF17532);
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
        backgroundColor: Color(0xFFFCFAF8),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "เพิ่มข้อมูลผู้ใช้งาน",
          style: GoogleFonts.kanit(textStyle: TextStyle(color: Colors.black)),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => UserList()));
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

  _buildLoginForm() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      child: ListView(
        children: [
          SizedBox(
            height: 150,
            width: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                (_image == null)
                    ? Icon(
                        Icons.photo,
                        size: 150,
                      )
                    : Image.file(_image),
                Positioned(
                  right: 100,
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
                              String filename = _image.path.split("/").last;
                              String urlImg = 'http://' +
                                  'itoknode' +
                                  '.comsciproject.com/images/users/' +
                                  filename;
                              imgController.text = urlImg;
                              print("image ::" + filename.toString());
                              print("urlImg ::" + urlImg);
                            } else {
                              // imgController.text = BaseNoImage;
                            }
                          });
                        },
                        child: const Icon(
                          Icons.camera_alt_rounded,
                        )),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 25.0),
          textField(nameController, 'ชิ่อ'),
          textField(snameController, 'นามสกุล'),
          textField(addrController, 'ที่อยู่'),
          textFieldTel(telController, 'เบอร์โทร'),
          textFieldEmail(emailController, 'email'),
          textField(userController, 'ชื่อผู้ใช้งาน'),
          textFieldPass(passController, 'รหัสผ่าน'),
          textField(lineController, 'line'),
          textField(faceController, 'facebook'),
          SizedBox(height: 15.0),
          GestureDetector(
            onTap: () async {
              if (nameController.text.isEmpty)
                showEnterDialog('กรุณากรอกชื่อ');
              else if (snameController.text.isEmpty)
                showEnterDialog('กรุณากรอกนามสกุล');
              else if (emailController.text.isEmpty)
                showEnterDialog('กรุณากรอกอีเมล');
              else if (userController.text.isEmpty)
                showEnterDialog('กรุณากรอกชื่อผู้ใช้งาน');
              else if (passController.text.isEmpty)
                showEnterDialog('กรุณากรอกรหัสผ่าน');

              if (imgController.text.isEmpty) {
                imgController.text = BaseNoImage;
                _upload();
                final TkAddModel addUser = await add(
                    nameController.text,
                    snameController.text,
                    imgController.text,
                    addrController.text,
                    telController.text,
                    emailController.text,
                    userController.text,
                    passController.text,
                    lineController.text,
                    faceController.text);
                if (addUser.message == "Success") {
                  showPassDialog();
                } else {
                  showFaildDialog();
                }
              } else {
                _upload();
                final TkAddModel addUser = await add(
                    nameController.text,
                    snameController.text,
                    imgController.text,
                    addrController.text,
                    telController.text,
                    emailController.text,
                    userController.text,
                    passController.text,
                    lineController.text,
                    faceController.text);
                if (addUser.message == "Success") {
                  showPassDialog();
                } else {
                  showFaildDialog();
                }
              }

              print(nameController.text);
              print(snameController.text);
              print(imgController.text);
              print(addrController.text);
              print(telController.text);
              print(emailController.text);
              print(userController.text);
              print(passController.text);
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
                    'เพิ่ม',
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
        ],
      ),
    );
  }

  textField(TextEditingController ETstr, String str) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: TextField(
        controller: ETstr,
        decoration: InputDecoration(
            labelText: str,
            labelStyle:
                GoogleFonts.kanit(textStyle: TextStyle(color: Colors.black)),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      ),
    );
  }

  textFieldEmail(TextEditingController ETstr, String str) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: TextField(
        controller: ETstr,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            labelText: str,
            labelStyle:
                GoogleFonts.kanit(textStyle: TextStyle(color: Colors.black)),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      ),
    );
  }

  textFieldPass(TextEditingController ETstr, String str) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: TextField(
        obscureText: true,
        controller: ETstr,
        decoration: InputDecoration(
            labelText: str,
            labelStyle:
                GoogleFonts.kanit(textStyle: TextStyle(color: Colors.black)),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      ),
    );
  }

  textFieldTel(TextEditingController ETstr, String str) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: TextField(
        controller: ETstr,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(10),
        ],
        decoration: InputDecoration(
            labelText: str,
            labelStyle:
                GoogleFonts.kanit(textStyle: TextStyle(color: Colors.black)),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      ),
    );
  }

  Future showEnterDialog(String str) => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Center(
              child: Text(
            str,
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
              onPressed: () async {
                Navigator.pop(context);
              },
            )
          ],
        ),
      );

  Future showPassDialog() => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Center(
              child: Text(
            'เพิ่มข้อมูลผู้ใช้สำเร็จ',
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
              onPressed: () async {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => UserList()));
              },
            )
          ],
        ),
      );

  Future showFaildDialog() => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Center(
              child: Text(
            'มีข้อมูลผู้ใช้นี้แล้ว ไม่สามารถเพิ่มได้',
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
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
}

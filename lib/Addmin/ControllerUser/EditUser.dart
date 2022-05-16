import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_project/Model/UserModel/UserModel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_project/Addmin/ControllerUser/UserList.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:restaurant_project/Model/UserModel/EditUserModel.dart';

class EditUser extends StatefulWidget {
  String username1;
  int id;
  String name;
  String lname;
  String img;
  String addr;
  String tel;
  String email;
  String username;
  String pass;
  String line;
  String face;
  int typeuser;
  int status;

  EditUser(
      {this.username1,
      this.id,
      this.name,
      this.lname,
      this.img,
      this.addr,
      this.tel,
      this.email,
      this.username,
      this.pass,
      this.line,
      this.face,
      this.typeuser,
      this.status});

  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  @override
  void initState() {
    super.initState();
    setValueData();
  }

  void setValueData() {
    accId.text = widget.id.toString();
    accName.text = widget.name;
    accSname.text = widget.lname;
    accImg.text = widget.img;
    accAddr.text = widget.addr;
    accTel.text = widget.tel;
    accEmail.text = widget.email;
    accUser.text = widget.username;
    accPass.text = widget.pass;
    accLine.text = widget.line;
    accFB.text = widget.face;
    accType.text = widget.typeuser.toString();
    accStatus.text = widget.status.toString();
  }

  Future<EditUserModel> edit(
      String acc_id,
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
      String acc_type,
      String acc_status) async {
    var url = "http://itoknode@itoknode.comsciproject.com/user/UpdateUser";
    final response = await http.post(Uri.parse(url), body: {
      "acc_id": acc_id,
      "acc_name": acc_name,
      "acc_sname": acc_sname,
      "acc_img": acc_img,
      "acc_addr": acc_addr,
      "acc_tel": acc_tel,
      "acc_email": acc_email,
      "acc_user": acc_user,
      "acc_pass": acc_pass,
      "acc_line": acc_line,
      "acc_fb": acc_fb,
      "acc_type": acc_type,
      "acc_status": acc_status
    });

    print(response.statusCode);
    if (response.statusCode == 200) {
      String responseString = response.body;
      return edituserModelFromJson(responseString);
    } else {
      return null;
    }
  }

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
  String BaseNoImage =
      "http://itoknode.comsciproject.com/images/foods/BaseNoImage.png";
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

  Color greenColor = Color(0xFF5B8842);
  Color orangeColor = Color(0xFFF17532);
  File _image;
  var valueAccType = ['ลูกค้า', 'ผู้ดูแล'];
  var valueAccStatus = ['เปิดการใช้งาน', 'ปิดการใช้งาน'];
  final picker = ImagePicker();

  _buildEditForm() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        children: [
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
                              accImg.text = urlImg;
                              print("image ::" + filename.toString());
                              print("urlImg ::" + urlImg);
                            } else {
                              accImg.text = BaseNoImage;
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
          textFieldDisable(accName, 'ชื่อ'),
          textFieldDisable(accSname, 'นามสกุล'),
          textField(accAddr, 'ที่อยู่'),
          textFieldTel(accTel, 'เบอร์โทร'),
          textFieldDisable(accEmail, 'อีเมล'),
          textFieldDisable(accUser, 'ผู้ใช้งาน'),
          textFieldPass(accPass, 'รหัสผ่าน'),
          textField(accLine, 'Line'),
          textField(accFB, 'Facebook'),
          dropDownType(),
          dropDownStatus(),
          SizedBox(height: 15),
          GestureDetector(
            onTap: () async {
              // print(accId.text);
              _upload();
              final EditUserModel editData = await edit(
                accId.text,
                accName.text,
                accSname.text,
                accImg.text,
                accAddr.text,
                accTel.text,
                accEmail.text,
                accUser.text,
                accPass.text,
                accLine.text,
                accFB.text,
                accType.text,
                accStatus.text,
              );
              if (editData.message == "Success") {
                showEndDialog();
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
                    'ตกลง',
                    style: GoogleFonts.kanit(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18.0)),
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

  Future showEnterDialog() => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Center(
              child: Text(
            'กรุณากรอกข้อมูลให้ครบ',
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

  Future showEndDialog() => showDialog(
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
                    .push(MaterialPageRoute(builder: (context) => UserList()));
              },
            )
          ],
        ),
      );

  dropDownType() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: DropdownButtonFormField(
        value: valueAccType[widget.typeuser].toString(),
        items: valueAccType.map((document) {
          if (document.isEmpty) {
          } else {
            return DropdownMenuItem<String>(
              value: document,
              child: Text(document),
            );
          }
        }).toList(),
        onChanged: (String value) async {
          setState(() {
            accType.text = valueAccType.indexOf(value).toString();
            ;
            print(accType.text);
          });
        },
        isExpanded: true,
        decoration: InputDecoration(
          fillColor: Colors.black12,
          filled: true,
          labelText: "ประเภทผู้ใช้งาน",
          labelStyle:
              GoogleFonts.kanit(textStyle: TextStyle(color: Colors.black)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  dropDownStatus() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: DropdownButtonFormField(
        value: valueAccStatus[widget.status].toString(),
        items: valueAccStatus.map((document) {
          if (document.isEmpty) {
          } else {
            return DropdownMenuItem<String>(
              value: document,
              child: Text(document),
            );
          }
        }).toList(),
        onChanged: (String value) async {
          setState(() {
            accStatus.text = valueAccStatus.indexOf(value).toString();
            print(accStatus.text);
          });
        },
        isExpanded: true,
        decoration: InputDecoration(
          fillColor: Colors.black12,
          filled: true,
          labelText: "สถานะผู้ใช้งาน",
          labelStyle:
              GoogleFonts.kanit(textStyle: TextStyle(color: Colors.black)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
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
          "แก้ไขข้อมูลผู้ใช้งาน",
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
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => UserList()));
            },
          ),
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.black,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Form(
          child: _buildEditForm(),
        ),
      ),
    );
  }

  textField(TextEditingController ETstr, String str) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: TextField(
        controller: ETstr,
        decoration: InputDecoration(
            fillColor: Colors.black12,
            filled: true,
            labelText: str,
            labelStyle:
                GoogleFonts.kanit(textStyle: TextStyle(color: Colors.black)),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      ),
    );
  }

  textFieldDisable(TextEditingController ETstr, String str) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: TextField(
        enabled: false,
        controller: ETstr,
        decoration: InputDecoration(
            fillColor: Colors.black12,
            filled: true,
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
            fillColor: Colors.black12,
            filled: true,
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
            fillColor: Colors.black12,
            filled: true,
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
            fillColor: Colors.black12,
            filled: true,
            labelText: str,
            labelStyle:
                GoogleFonts.kanit(textStyle: TextStyle(color: Colors.black)),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      ),
    );
  }
}

import 'dart:convert';
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

EditUserModel editdatamodel;

class _EditUserState extends State<EditUser> {
  @override
  void initState() {
    super.initState();
    accId.text = this.widget.id.toString();
    accName.text = this.widget.name;
    accSname.text = this.widget.lname;
    accAddr.text = this.widget.addr;
    accTel.text = this.widget.tel;
    accEmail.text = this.widget.email;
    accUser.text = this.widget.username;
    accPass.text = this.widget.pass;
    accLine.text = this.widget.line;
    accFB.text = this.widget.face;
    accType.text = this.widget.typeuser.toString();
    accStatus.text = this.widget.status.toString();
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
    final String url =
        "http://itoknode@itoknode.comsciproject.com/user/UpdateUser";
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
  Color greenColor = Color(0xFF5B8842);
  Color orangeColor = Color(0xFFF17532);
  File _image;
  var deimg = Icon(
    Icons.photo,
    size: 150,
  );
  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print("show image");
      } else {
        print('No image selected.');
      }
    });
  }

  _buildEditForm() {
    return Padding(
      padding: const EdgeInsets.all(13.0),
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
                  left: 180,
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
                        // img = await ImagePicker.pickImage(
                        //     source: ImageSource.gallery);
                        // String bit = base64Encode(img.readAsBytesSync());
                        // imgController.text = bit;
                        // print("IMG = " + imgController.text);
                        final pickedFile =
                            await picker.getImage(source: ImageSource.gallery);

                        setState(() {
                          if (pickedFile != null) {
                            _image = File(pickedFile.path);
                            // String bit = base64Encode(_image.readAsBytesSync());
                            Image.file(_image);

                            accImg.text = _image.path;
                            print(accImg.text);
                            // print("IMG = " + bit.);
                          } else {}
                        });
                      },
                      child: Image.asset(
                        'assets/images/camera.png',
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 25.0),
          TextField(
            controller: accName,
            decoration: InputDecoration(
                labelText: 'ชื่อ',
                labelStyle: GoogleFonts.kanit(
                    textStyle: TextStyle(color: Colors.green[700])),
                fillColor: Colors.black12,
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
          SizedBox(height: 10.0),
          TextField(
            //enabled: false,
            controller: accSname,
            decoration: InputDecoration(
                labelText: 'นามสกุล',
                labelStyle: GoogleFonts.kanit(
                    textStyle: TextStyle(color: Colors.green[700])),
                fillColor: Colors.black12,
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
          SizedBox(height: 10.0),
          TextField(
            //enabled: false,
            controller: accAddr,
            decoration: InputDecoration(
                labelText: 'ที่อยู่',
                labelStyle: GoogleFonts.kanit(
                    textStyle: TextStyle(color: Colors.green[700])),
                fillColor: Colors.black12,
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
          SizedBox(height: 10.0),
          TextField(
            //enabled: false,
            controller: accTel,
            decoration: InputDecoration(
                labelText: 'เบอร์โทร',
                labelStyle: GoogleFonts.kanit(
                    textStyle: TextStyle(color: Colors.green[700])),
                fillColor: Colors.black12,
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
          SizedBox(height: 10.0),
          TextField(
            //enabled: false,
            controller: accEmail,
            decoration: InputDecoration(
                labelText: 'อีเมล',
                labelStyle: GoogleFonts.kanit(
                    textStyle: TextStyle(color: Colors.green[700])),
                fillColor: Colors.black12,
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
          SizedBox(height: 10.0),
          TextField(
            enabled: false,
            controller: accUser,
            decoration: InputDecoration(
                labelText: 'ผู้ใช้งาน',
                labelStyle: GoogleFonts.kanit(
                    textStyle: TextStyle(color: Colors.green[700])),
                fillColor: Colors.black12,
                suffixIcon: Icon(
                  Icons.check,
                  color: Colors.green[700],
                ),
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
          SizedBox(height: 10.0),
          TextField(
            //enabled: false,
            controller: accPass,
            obscureText: true,
            decoration: InputDecoration(
                labelText: 'รหัสผ่าน',
                labelStyle: GoogleFonts.kanit(
                    textStyle: TextStyle(color: Colors.green[700])),
                fillColor: Colors.black12,
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
          SizedBox(height: 10.0),
          TextField(
            //enabled: false,
            controller: accLine,
            decoration: InputDecoration(
                labelText: 'Line',
                labelStyle: GoogleFonts.kanit(
                    textStyle: TextStyle(color: Colors.green[700])),
                fillColor: Colors.black12,
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
          SizedBox(height: 10.0),
          TextField(
            //enabled: false,
            controller: accFB,
            decoration: InputDecoration(
                labelText: 'Facebook',
                labelStyle: GoogleFonts.kanit(
                    textStyle: TextStyle(color: Colors.green[700])),
                fillColor: Colors.black12,
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
          SizedBox(height: 10.0),
          TextField(
            //enabled: false,
            controller: accType,
            decoration: InputDecoration(
                labelText: 'ประเภทผู้ใช้งาน',
                labelStyle: GoogleFonts.kanit(
                    textStyle: TextStyle(color: Colors.green[700])),
                fillColor: Colors.black12,
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
          SizedBox(height: 10.0),
          TextField(
            //enabled: false,
            controller: accStatus,
            decoration: InputDecoration(
                labelText: 'สถานะ',
                labelStyle: GoogleFonts.kanit(
                    textStyle: TextStyle(color: Colors.green[700])),
                fillColor: Colors.black12,
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
          SizedBox(height: 50.0),
          GestureDetector(
            onTap: () async {
              // if (user.text != "" && pass.text != "") {
              //   final UserModel response = await Adduser(
              //       name.text,
              //       sname.text,
              //       img.text,
              //       addr.text,
              //       tel.text,
              //       email.text,
              //       user.text,
              //       pass.text,
              //       line.text,
              //       face.text,
              //       stype.text);
              // }
              print(accId.text);
              final EditUserModel Register = await edit(
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
              if (Register.message == "Success") {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => UserList()));
              }
              // final RegisterModel Register = await registers(
              //   nameController.text,
              //   snameController.text,
              //   emailController.text,
              //   userController.text,
              //   passwordController.text,
              // );

              // if (Register.message == "Success") {
              //   Navigator.of(context)
              //       .push(MaterialPageRoute(builder: (context) => Login()));
              // } else {
              //   print("register message:" + Register.message);
              // }
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
}

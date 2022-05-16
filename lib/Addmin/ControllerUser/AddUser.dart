import 'dart:convert';
import 'dart:typed_data';

import 'package:restaurant_project/Addmin/ControllerUser/UserList.dart';
import 'package:restaurant_project/Model/AEModel/TkAddModel.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_project/Model/MessageModel.dart';
import 'package:restaurant_project/Model/UserModel/AddUserModel.dart';
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
  Future<MessageModel> add(
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
  ) async {
    final String url = "http://itoknode@itoknode.comsciproject.com/user/upload";
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
      "acc_fb": acc_fb,
      "acc_type": acc_type,
    });

    if (response.statusCode == 200) {
      String responseString = response.body;
      return messageModelFromJson(responseString);
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
  var typeController = TextEditingController();

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

  // var base64 = TextEditingController();
  Future uploadimg() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    // final bytes = IO.File(image.path).readAsBytesSync();
    // List<int> bytes = await image.readAsBytes();
    // Uint8List bytes = utf8.encode(image.readAsStringSync());
    // String xx = base64.encode(bytes);

    // imgController.text = base64Encode(bytes);

    // // final pickedFile = await picker.getImage(source: ImageSource.gallery);

    // var xx = Base64Encoder().convert(bytes);
    // print(bytes);
    // // Uint8List _bytesImage = Base64Decoder().convert(xx);

    setState(() {
      if (image != null) {
        _image = File(image.path);
        Image.file(_image);
        String filename = _image.path.split("/").last;
        String urlImg =
            'http://' + 'itoknode' + '.comsciproject.com/images/' + filename;
        imgController.text = urlImg;
        print(urlImg);
        // prinimg64t("IMG = " + bit.);
      } else {}
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
                        // final pickedFile =
                        //     await picker.getImage(source: ImageSource.gallery);
                        // List<int> bytes = await pickedFile.readAsBytes();
                        // String xx = base64Encode(bytes);
                        // //_bytesImage = Base64Decoder().convert(xx);

                        // setState(() {
                        //   if (pickedFile != null) {
                        //     _image = File(pickedFile.path);
                        //     Image.file(_image);

                        //     imgController.text = xx;
                        //     print(imgController.text);
                        //     // print("IMG = " + bit.);
                        //   } else {}
                        // });
                        uploadimg();
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
            controller: imgController,
            decoration: InputDecoration(
                labelText: 'รูป',
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
            controller: addrController,
            decoration: InputDecoration(
                labelText: 'ที่อยู่',
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
            controller: telController,
            decoration: InputDecoration(
                labelText: 'เบอร์โทร',
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
                labelText: 'email',
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
                labelText: 'ชื่อผู้ใช้งาน',
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
            controller: passController,
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
          TextField(
            controller: lineController,
            decoration: InputDecoration(
                labelText: 'line',
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
            controller: faceController,
            decoration: InputDecoration(
                labelText: 'facebook',
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
            controller: typeController,
            decoration: InputDecoration(
                labelText: 'type',
                labelStyle: TextStyle(
                    fontFamily: 'Trueno',
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.withOpacity(0.5)),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: greenColor),
                )),
          ),
          SizedBox(height: 15.0),
          GestureDetector(
            onTap: () async {
              final MessageModel addUser = await add(
                nameController.text,
                snameController.text,
                imgController.text,
                addrController.text,
                telController.text,
                emailController.text,
                userController.text,
                passController.text,
                lineController.text,
                faceController.text,
                typeController.text,
              );
              if (addUser.message == "Success") {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => UserList()));
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
}

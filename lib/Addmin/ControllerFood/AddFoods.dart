import 'package:restaurant_project/Addmin/ControllerFood/AllFoods.dart';
import 'package:restaurant_project/Model/AEModel/TkAddModel.dart';
import 'package:restaurant_project/Model/FoodModel/TypeFoodsModel.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:restaurant_project/Model/FoodModel/FoodsModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dialogFood.dart';

class AddFoods extends StatefulWidget {
  @override
  _AddFoodsState createState() => _AddFoodsState();
}

class _AddFoodsState extends State<AddFoods> {
  var type_id = TextEditingController();
  var food_name = TextEditingController();
  var food_img = TextEditingController();
  var food_price = TextEditingController();
  var food_status = TextEditingController();

  // int index = 0;
  // var tf_id = TextEditingController();
  // var tf_name = TextEditingController();

  List typeFood;
  String statusname;
  String BaseNoImage =
      "http://itoknode.comsciproject.com/images/foods/BaseNoImage.png";

  // List data;

  Future<Null> TypeFoods() async {
    final String url =
        "http://itoknode@itoknode.comsciproject.com/foods/TypeFoods";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      typeFood = json.decode(response.body);

      // print();
      setState(() {
        // data = typeFood;
        // print("data: " + data.toString());
      });
    }
  }

  Future<TkAddModel> AddFoods(String type_id, String food_name, String food_img,
      String food_price, String food_status) async {
    String url = "http://itoknode@itoknode.comsciproject.com/foods/add";
    //try {
    final response = await http.post(Uri.parse(url), body: {
      "type_id": type_id,
      "food_name": food_name,
      "food_img": food_img,
      "food_price": food_price,
      "food_status": food_status
    });

    if (response.statusCode == 200) {
      String responseString = response.body;
      return tkAddModelFromJson(responseString);
    } else {
      return null;
    }
  }

  _upload() {
    if (_image == null) return "";
    String base64Image = base64Encode(_image.readAsBytesSync());
    String fileName = _image.path.split("/").last;
    print(fileName);
    http.post("http://itoknode@itoknode.comsciproject.com/foods/images", body: {
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
  void initState() {
    super.initState();
    TypeFoods();
    // AddFoods();
  }

  var img;
  int priceint;
  int statusint;
  String value;
  File _image;

  final String nodeEnd = "";

  List<String> foodstatus = ["เหลืออยู่", "หมดแล้ว", "ยกเลิกเมนูแล้ว"];

  var deimg = Icon(
    Icons.photo,
    size: 150,
  );
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    Color greenColor = Color(0xFF5B8842);
    Color orangeColor = Color(0xFFF17532);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: orangeColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "เพิ่มอาหาร",
          style: GoogleFonts.prompt(textStyle: TextStyle(color: Colors.white)),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AllFoods()));
          },
        ),
      ),
      body: (typeFood == null)
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
          : ListView(
              children: [
                Container(
                  height: 650,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3.0,
                                  blurRadius: 5.0),
                            ],
                            color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
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
                                              ? Icon(
                                                  Icons.photo,
                                                  size: 150,
                                                )
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
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  side: BorderSide(
                                                      color: Colors.black),
                                                ),
                                                color: Color(0xFFF5F6F9),
                                                onPressed: () async {
                                                  final pickedImage =
                                                      await picker.getImage(
                                                          source: ImageSource
                                                              .gallery);
                                                  setState(() {
                                                    if (pickedImage != null) {
                                                      _image = File(
                                                          pickedImage.path);
                                                      Image.file(_image);
                                                      String filename = _image
                                                          .path
                                                          .split("/")
                                                          .last;
                                                      String urlImg = 'http://' +
                                                          'itoknode' +
                                                          '.comsciproject.com/images/foods/' +
                                                          filename;
                                                      food_img.text = urlImg;
                                                      print("image ::" +
                                                          filename.toString());
                                                      print(
                                                          "urlImg ::" + urlImg);
                                                    } else {
                                                      // food_img.text = BaseNoImage;
                                                    }
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
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'ชื่อ',
                                          style: GoogleFonts.kanit(
                                            textStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15.0),
                                          ),
                                        ),
                                        TextField(
                                          controller: food_name,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          'ราคา',
                                          style: GoogleFonts.kanit(
                                            textStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15.0),
                                          ),
                                        ),
                                        TextField(
                                          keyboardType: TextInputType.number,
                                          controller: food_price,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          'ประเภทอาหาร',
                                          style: GoogleFonts.kanit(
                                            textStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15.0),
                                          ),
                                        ),
                                        DropdownButtonFormField(
                                          hint: Text("กรุณาเลือกประเภทอาหาร"),
                                          items: typeFood.map((document) {
                                            if (document.isEmpty) {
                                            } else {
                                              return DropdownMenuItem<String>(
                                                value: document['tf_id']
                                                    .toString(),
                                                child:
                                                    Text(document['tf_name']),
                                              );
                                            }
                                          }).toList(),
                                          onChanged: (String value) async {
                                            setState(() {
                                              type_id.text = value;
                                            });
                                          },
                                          isExpanded: true,
                                          decoration: InputDecoration(
                                            // labelText: "ชนิดอาหาร",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          'สถานะอาหาร',
                                          style: GoogleFonts.kanit(
                                            textStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15.0),
                                          ),
                                        ),
                                        DropdownButtonFormField(
                                          hint: Text("กรุณาเลือกสถานะอาหาร"),
                                          items: foodstatus.map((document) {
                                            return DropdownMenuItem<String>(
                                              value: document.toString(),
                                              child: Text(document),
                                            );
                                          }).toList(),
                                          onChanged: (String value) async {
                                            setState(() {
                                              food_status.text = foodstatus
                                                  .indexOf(value)
                                                  .toString();
                                              print(food_status.text);
                                            });
                                          },
                                          isExpanded: true,
                                          decoration: InputDecoration(
                                            // labelText: "ชนิดอาหาร",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 120,
                                  height: 45,
                                  child: GestureDetector(
                                    onTap: () async {
                                      print("type_id:" + type_id.text);
                                      print("food_name:" + food_name.text);
                                      print("food_img:" + food_img.text);
                                      print("food_price:" + food_price.text);
                                      print("food_status:" + food_status.text);

                                      if (type_id.text.isEmpty ||
                                          food_name.text.isEmpty ||
                                          food_price.text.isEmpty ||
                                          food_status.text.isEmpty) {
                                        showEnterDialog(context);
                                      } else if (food_img.text.isEmpty) {
                                        food_img.text = BaseNoImage;

                                        _upload();
                                        final TkAddModel add = await AddFoods(
                                            type_id.text,
                                            food_name.text,
                                            food_img.text,
                                            food_price.text,
                                            food_status.text);
                                        print(add.message);
                                        if (add.message == "Success") {
                                          showPassDialog(context);
                                        } else {
                                          showFaildDialog(context);
                                        }
                                      } else {
                                        _upload();
                                        final TkAddModel add = await AddFoods(
                                            type_id.text,
                                            food_name.text,
                                            food_img.text,
                                            food_price.text,
                                            food_status.text);
                                        print(add.message);
                                        if (add.message == "Success") {
                                          showPassDialog(context);
                                        } else {
                                          showFaildDialog(context);
                                        }
                                      }
                                    },
                                    child: Container(
                                      height: 50,
                                      child: Material(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        shadowColor: Colors.orangeAccent,
                                        color: orangeColor,
                                        elevation: 7.0,
                                        child: Center(
                                          child: Text(
                                            'ตกลง',
                                            style: GoogleFonts.kanit(
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }


}

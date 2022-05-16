import 'dart:convert';
import 'package:restaurant_project/Addmin/ControllerFood/AllFoods.dart';
import 'package:restaurant_project/Model/AEModel/EditModel.dart';
import 'package:restaurant_project/Model/FoodModel/FoodsModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class editFoods extends StatefulWidget {
  int food_id;
  int type_id;
  String food_name;
  String food_img;
  int food_price;
  int food_status;

  editFoods({
    this.food_id,
    this.type_id,
    this.food_name,
    this.food_img,
    this.food_price,
    this.food_status,
  });

  @override
  _editFoodsState createState() => _editFoodsState();
}

class _editFoodsState extends State<editFoods> {
  Color greenColor = Color(0xFF5B8842);
  Color orangeColor = Color(0xFFF17532);
  File _image;
  List<FoodsModel> food;
  List typeFood;
  final picker = ImagePicker();
  String statusname;
  String BaseNoImage =
      "http://itoknode.comsciproject.com/images/foods/BaseNoImage.png";

  List<String> foodstatus = ["เหลืออยู่", "หมดแล้ว", "ยกเลิกเมนูแล้ว"];

  Future<Null> TypeFoods() async {
    final String url =
        "http://itoknode@itoknode.comsciproject.com/foods/TypeFoods";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      typeFood = json.decode(response.body);
      print("typefood :" + typeFood.toString());

      // print();
      setState(() {
        // data = typeFood;
        // print("data: " + data.toString());
      });
    }
  }

  Future<EditModel> Edit(
    String food_id,
    String type_id,
    String food_name,
    String food_img,
    String food_price,
    String food_status,
  ) async {
    final String url =
        "http://itoknode@itoknode.comsciproject.com/foods/UpdateFood";
    final response = await http.post(Uri.parse(url), body: {
      "food_id": food_id,
      "type_id": type_id,
      "food_name": food_name,
      "food_img": food_img,
      "food_price": food_price,
      "food_status": food_status,
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      String responseString = response.body;
      return editModelFromJson(responseString);
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

  var food_id = TextEditingController();
  var type_id = TextEditingController();
  var food_name = TextEditingController();
  var food_img = TextEditingController();
  var food_price = TextEditingController();
  var food_status = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    TypeFoods();
    food_id.text = this.widget.food_id.toString();
    type_id.text = this.widget.type_id.toString();
    food_name.text = this.widget.food_name;
    food_img.text = this.widget.food_img;
    food_price.text = this.widget.food_price.toString();
    food_status.text = this.widget.food_status.toString();

    print(food_id.text);
    print(type_id.text);
    print(food_name.text);
    print(food_img.text);
    print(food_price.text);
    print(food_status.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: orangeColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "แก้ไขข้อมูลอาหาร",
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
      body: Container(
        child: _buildEditForm(),
      ),
    );
  }

  _buildEditForm() {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: (typeFood == null)
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
                SizedBox(
                  height: 150,
                  width: 150,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      (_image == null)
                          ? Image.network(BaseNoImage)
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
                              final pickedImage = await picker.getImage(
                                  source: ImageSource.gallery);
                              setState(() {
                                if (pickedImage != null) {
                                  _image = File(pickedImage.path);
                                  Image.file(_image);
                                  String filename = _image.path.split("/").last;
                                  String urlImg = 'http://' +
                                      'itoknode' +
                                      '.comsciproject.com/images/foods/' +
                                      filename;
                                  food_img.text = urlImg;
                                  print("image ::" + filename.toString());
                                  print("urlImg ::" + urlImg);
                                } else {
                                  food_img.text = BaseNoImage;
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
                SizedBox(height: 25.0),
                TextField(
                  controller: food_name,
                  decoration: InputDecoration(
                      labelText: 'ชื่ออาหาร',
                      labelStyle: GoogleFonts.kanit(
                          textStyle: TextStyle(color: Colors.green[700])),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                SizedBox(height: 20),

                DropdownButtonFormField(
                  value: widget.type_id.toString().isEmpty
                      ? widget.type_id.toString()
                      : widget.type_id.toString(),
                  items: typeFood.map((document) {
                    if (document.isEmpty) {
                    } else {
                      return DropdownMenuItem<String>(
                        value: document['tf_id'].toString(),
                        child: Text(document['tf_name']),
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
                    labelText: "ชนิดอาหาร",
                    labelStyle: GoogleFonts.kanit(
                        textStyle: TextStyle(color: Colors.green[700])),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),

                //*********** old ********************

                // DropdownButton<String>(
                //   hint: Text('ชนิดอาหาร'),
                //   isExpanded: true,
                //   icon: const Icon(Icons.arrow_downward),
                //   iconSize: 24,
                //   elevation: 16,
                //   style: const TextStyle(color: Colors.deepPurple),
                //   underline: Container(
                //     height: 2,
                //     // width: ,
                //     color: Colors.deepPurpleAccent,
                //   ),
                //   items: typeFood.map((item) {
                //     return new DropdownMenuItem<String>(
                //       child: new Text(item['tf_name']),
                //       value: item['tf_id'].toString(),
                //     );
                //   }).toList(),
                //   onChanged: (newVal) {
                //     print(newVal);
                //     setState(() {
                //       _mySelection = newVal;
                //       type_id.text = _mySelection;
                //     });
                //   },
                //   value: _mySelection,
                // ),

                SizedBox(height: 20.0),

                TextField(
                  //enabled: false,
                  keyboardType: TextInputType.number,
                  controller: food_price,
                  decoration: InputDecoration(
                      labelText: 'ราคา',
                      labelStyle: GoogleFonts.kanit(
                          textStyle: TextStyle(color: Colors.green[700])),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),

                SizedBox(height: 20.0),

                DropdownButtonFormField(
                  value: foodstatus[widget.food_status].toString(),
                  hint: Text("สถานะอาหาร"),
                  items: foodstatus.map((document) {
                    return DropdownMenuItem<String>(
                      value: document.toString(),
                      child: Text(document),
                    );
                  }).toList(),
                  onChanged: (String value) async {
                    setState(() {
                      food_status.text = foodstatus.indexOf(value).toString();
                      print(food_status.text);
                    });
                  },
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: "สถานะอาหาร",
                    labelStyle: GoogleFonts.kanit(
                        textStyle: TextStyle(color: Colors.green[700])),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),

                SizedBox(height: 20.0),

                Container(
                    height: 50.0,
                    child: ElevatedButton(
                      child: Text(
                        'ตกลง',
                        style: GoogleFonts.kanit(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18.0)),
                      ),
                      style: ElevatedButton.styleFrom(
                          shadowColor: Colors.orangeAccent,
                          primary: orangeColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () async {
                        print("food_id :" + food_id.text);
                        print("type_id :" + type_id.text);
                        print("food_name :" + food_name.text);
                        print("food_img :" + food_img.text);
                        print("food_price :" + food_price.text);
                        print("food_status :" + food_status.text);

                        if (type_id.text.isEmpty ||
                            food_name.text.isEmpty ||
                            food_price.text.isEmpty ||
                            food_status.text.isEmpty) {
                          showEnterDialog();
                        } else if (food_img.text.isEmpty) {
                          food_img.text = BaseNoImage;

                          _upload();
                          final EditModel edit = await Edit(
                              food_id.text,
                              type_id.text,
                              food_name.text,
                              food_img.text,
                              food_price.text,
                              food_status.text);

                          if (edit.message == "Success") {
                            showEndDialog();
                          } else {}
                        } else {
                          _upload();
                          final EditModel edit = await Edit(
                              food_id.text,
                              type_id.text,
                              food_name.text,
                              food_img.text,
                              food_price.text,
                              food_status.text);

                          if (edit.message == "Success") {
                            showEndDialog();
                          } else {}
                        }
                      },
                    )),
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
                    .push(MaterialPageRoute(builder: (context) => AllFoods()));
              },
            )
          ],
        ),
      );
}

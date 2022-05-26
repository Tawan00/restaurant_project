import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_project/Addmin/ControllerOrder/ControllerOrderfood/AdminAllBookOrder.dart';
import 'package:restaurant_project/Model/AEModel/EditModel.dart';
import 'package:restaurant_project/Model/BookTableModel/BookTableModel.dart';
import 'package:restaurant_project/Model/MessageModel.dart';
import 'package:restaurant_project/Model/ReceiveModel/ReceiptModel.dart';
import 'package:restaurant_project/Model/ReceiveModel/ReceiptModel.dart';
import 'package:restaurant_project/Model/TableModel/TableAllModel.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_project/Model/TableModel/TablesModel.dart';
import 'package:restaurant_project/Model/TableModel/TkTableModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminAddBookOrder extends StatefulWidget {

  @override
  State<AdminAddBookOrder> createState() => _AdminAddBookOrderState();
}

class _AdminAddBookOrderState extends State<AdminAddBookOrder> {
  int selectvalue;
  var tbtable = TextEditingController();
  Color greenColor = Color(0xFF5B8842);
  Color orangeColor = Color(0xFFF17532);

  @override
  void initState() {
    getToken();
    GetReceipt();
    super.initState();
  }

  String token = "";
  Future<Null> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString("token");
  }
  List<ReceiptModel> ReceiptData;
  List<BookTableModel> _tableallModel;


  Future<TkTablesModel> GetReceipt() async {
    // var url = "http://192.168.254.2:3000/receipt/getBookTableDistinct";
    var url = "http://itoknode@itoknode.comsciproject.com/receipt/getBookTableDistinct";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        final String responseString = response.body;
        _tableallModel = bookTableModelFromJson(responseString);
      });
      print(_tableallModel.length);
    }
  }

  Future<EditModel> AddReceipt(String bt_id) async {
    var url = "http://itoknode@itoknode.comsciproject.com/receipt/AddReceipt";
    final response = await http.post(Uri.parse(url),body: {
      "bt_id": bt_id
    });
    if (response.statusCode == 200) {
      setState(() {
        final String responseString = response.body;
        ReceiptData = receiptModelFromJson(responseString);
      });
      print(ReceiptData.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFCFAF8),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "เพิ่มใบสั่งจองอาหาร",
          style: GoogleFonts.prompt(textStyle: TextStyle(color: Colors.black)),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AdminAllBookOrder()));
          },
        ),

      ),
      body: (_tableallModel == null)
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
          : Container(
            child: Padding(
              padding: EdgeInsets.only(
                  top: 16.0, bottom: 16.0, left: 16.0, right: 16.0),
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
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Container(
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            border:
                            Border.all(color: Colors.black),
                            borderRadius:
                            BorderRadius.circular(15.0)),
                        child: DropdownButton(
                          hint: Center(child: Text("รหัสการสั่งจองโต๊ะ")),
                          dropdownColor: Colors.white,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                          iconSize: 24,
                          isExpanded: true,
                          style: const TextStyle(
                              color: Colors.black),
                          underline: SizedBox(),
                          value: selectvalue,
                          items:
                          _tableallModel.map((valueItem) {
                            if (valueItem
                                .toString()
                                .isEmpty) {
                            } else {
                              return DropdownMenuItem(
                                value: valueItem.btId,
                                child: Center(child: Text(
                                    valueItem.btId.toString()),),
                              );
                            }
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectvalue = newValue;
                              tbtable.text =
                                  newValue.toString();
                              print(tbtable.text);
                            });
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 120,
                            height: 45,
                            child: GestureDetector(
                              onTap: () async {
                                try{
                                  if(tbtable.text.isEmpty){
                                    showEnterDialog(context);
                                  }else{

                                    final EditModel add = await AddReceipt(tbtable.text);
                                    if (add.message == "Success") {
                                      showEndDialog(context);
                                    }else{
                                    }

                                  }
                                }catch(e){

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
    );
  }

}
Future showEndDialog(BuildContext context) => showDialog(
  context: context,
  barrierDismissible: false,
  builder: (context) => AlertDialog(
    title: Center(
        child: Text(
          'เพิ่มใบสั่งจองเสร็จสมบูรณ์',
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
              .push(MaterialPageRoute(builder: (context) => AdminAllBookOrder()));
        },
      )
    ],
  ),
);

Future showEnterDialog(BuildContext context) => showDialog(
  context: context,
  barrierDismissible: false,
  builder: (context) => AlertDialog(
    title: Center(
        child: Text(
          'กรุณาเลือกรหัสการสั่งจองโต๊ะ',
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
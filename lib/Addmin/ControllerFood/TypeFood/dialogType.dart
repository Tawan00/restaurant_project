import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'TypeFoods.dart';
// -------------------- TYPE FOOD --------------------

Future showEnterAllDialog(BuildContext context) => showDialog(
  context: context,
  barrierDismissible: false,
  builder: (context) => AlertDialog(
    title: Center(
        child: Text(
          'กรุณากรอกชื่อประเภทอาหาร',
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

Future showFailDialog(BuildContext context) => showDialog(
  context: context,
  barrierDismissible: false,
  builder: (context) => AlertDialog(
    title: Center(
        child: Text(
          'มีประเภทอาหารนี้แล้ว',
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

Future showEndDialog(BuildContext context) => showDialog(
  context: context,
  barrierDismissible: false,
  builder: (context) => AlertDialog(
    title: Center(
        child: Text(
          'เพิ่มข้อมูลเสร็จสมบูรณ์',
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
              .push(MaterialPageRoute(builder: (context) => TypeFoods()));
        },
      )
    ],
  ),
);

//---------------------------------------  EDIT TYPE ------------------------------------------------
Future showEditEndDialog(BuildContext context) => showDialog(
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
              .push(MaterialPageRoute(builder: (context) => TypeFoods()));
        },
      )
    ],
  ),
);
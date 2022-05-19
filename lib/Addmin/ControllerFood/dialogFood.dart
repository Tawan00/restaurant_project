import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'AllFoods.dart';

Future showEnterDialog(BuildContext context) => showDialog(
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

Future showPassDialog(BuildContext context) => showDialog(
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
        onPressed: () async {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AllFoods()));
        },
      )
    ],
  ),
);

Future showFaildDialog(BuildContext context) => showDialog(
  context: context,
  barrierDismissible: false,
  builder: (context) => AlertDialog(
    title: Center(
        child: Text(
          'มีชื่ออาหารนี้แล้ว ไม่สามารถเพิ่มได้',
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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ListPromotion.dart';


Future showProDisDialog(BuildContext context) => showDialog(
  context: context,
  barrierDismissible: false,
  builder: (context) => AlertDialog(
    title: Center(
        child: Text(
          'ส่วนลดสูงสุด 100 % กรุณากรอกส่วนลดใหม่อีกครั้ง',
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

Future showDateDialog(BuildContext context) => showDialog(
  context: context,
  barrierDismissible: false,
  builder: (context) => AlertDialog(
    title: Center(
        child: Text(
          'กรุณาเลือกวันที่สิ้นสุดให้มากกว่าหรือเท่ากับวันที่เริ่มต้น',
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
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ListPro()));
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
          'มีชื่อโปรโมชันนี้แล้ว ไม่สามารถเพิ่มได้',
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


//-------------------------------EDIT PRO ---------------------------------------
Future showEditPassDialog(BuildContext context) => showDialog(
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
              .push(MaterialPageRoute(builder: (context) => ListPro()));
        },
      )
    ],
  ),
);

Future showEditFailDialog(BuildContext context) => showDialog(
  context: context,
  barrierDismissible: false,
  builder: (context) => AlertDialog(
    title: Center(
        child: Text(
          'มีโปรโมชันนี้แล้ว ไม่สามารถแก้ไขได้',
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

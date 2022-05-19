import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_project/Addmin/ControllerFood/editFoods.dart';

import 'TableList.dart';

Future showAddEndDialog(BuildContext context) => showDialog(
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
              .push(MaterialPageRoute(builder: (context) => TableList()));
        },
      )
    ],
  ),
);

Future showEnterAllDialog(BuildContext context) => showDialog(
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

Future showAddEnterCountDialog(BuildContext context) => showDialog(
  context: context,
  barrierDismissible: false,
  builder: (context) => AlertDialog(
    title: Center(
        child: Text(
          'กรุณากรอกจำนวนมากกว่า 0',
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

Future showAddFailDialog(BuildContext context) => showDialog(
  context: context,
  barrierDismissible: false,
  builder: (context) => AlertDialog(
    title: Center(
        child: Text(
          'มีเบอร์โต๊ะนี้แล้ว',
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

// EDIT

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
              .push(MaterialPageRoute(builder: (context) => TableList()));
        },
      )
    ],
  ),
);

Future showEditEnterCountDialog(BuildContext context) => showDialog(
  context: context,
  barrierDismissible: false,
  builder: (context) => AlertDialog(
    title: Center(
        child: Text(
          'กรุณากรอกจำนวนน้อยกว่า 3',
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

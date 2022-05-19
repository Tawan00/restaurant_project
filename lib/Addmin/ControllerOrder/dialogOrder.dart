import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


Future showEnterAllDialog(BuildContext context) => showDialog(
  context: context,
  barrierDismissible: false,
  builder: (context) => AlertDialog(
    title: Center(
        child: Text(
          'กรุณาเลือกโต๊ะ',
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
import 'package:restaurant_project/Homepage/HomePage.dart';
import 'package:restaurant_project/Model/FoodModel/FoodsModel.dart';
import 'package:restaurant_project/Model/PromotionModel/ProModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';

class SearchPromotion extends StatefulWidget {
  @override
  _SearchPromotionState createState() => _SearchPromotionState();
}

class _SearchPromotionState extends State<SearchPromotion> {
  @override
  void initState() {
    super.initState();
    GetPro();
  }

  var control;
  List<FoodsModel> items;
  List<PromotionModel> filterItems;
  List<PromotionModel> _Prodata;
  Future<Null> GetPro() async {
    var url = "http://itoknode.comsciproject.com/pro/ProAll";
    final response = await http.get(Uri.parse(url));
    print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() {
        final String responseString = response.body;
        _Prodata = promotionModelFromJson(responseString);
        filterItems = _Prodata;
      });
    }
    print(_Prodata);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFCFAF8),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "ค้นหาโปรโมชั่น",
          style: GoogleFonts.prompt(textStyle: TextStyle(color: Colors.black)),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: TextField(
              style: GoogleFonts.kanit(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.black)),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                hintText: "กรอกวันที่",
                hintStyle: GoogleFonts.kanit(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.black54)),
                icon: Icon(
                  Icons.search,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  filterItems = _Prodata.where((u) => (u.proStartDate
                      .toString()
                      .toLowerCase()
                      .contains(value.toLowerCase()))).toList();
                });
              },
            ),
          ),
          Expanded(
              child: (_Prodata == null)
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
                  : ListView.builder(
                      itemCount: filterItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: Text(
                            "${filterItems[index].proName}",
                            style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                    // fontWeight: FontWeight.w600,
                                    color: Colors.black)),
                          ),
                          title: Text(
                            "${filterItems[index].proDesc}",
                            style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                    // fontWeight: FontWeight.w600,
                                    color: Colors.black)),
                          ),
                          subtitle: Text(
                            "วันที่ ${filterItems[index].proStartDate.day} ถึง ${filterItems[index].proEndDate.day}/${filterItems[index].proEndDate.month}/${filterItems[index].proEndDate.year}",
                            style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                    // fontWeight: FontWeight.w600,
                                    color: Colors.black54)),
                          ),
                        );
                      })),
        ],
      ),
    );
  }
}

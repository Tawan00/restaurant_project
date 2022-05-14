import 'package:restaurant_project/Homepage/HomePage.dart';
import 'package:restaurant_project/Model/FoodModel/FoodsModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';

class SearchFood extends StatefulWidget {
  @override
  _SearchFoodState createState() => _SearchFoodState();
}

class _SearchFoodState extends State<SearchFood> {
  @override
  void initState() {
    super.initState();
    Getfoods();
  }

  var control;
  List<FoodsModel> items;
  List<FoodsModel> filterItems;
  Future<Null> Getfoods() async {
    var url = "http://itoknode@itoknode.comsciproject.com/foods/Foods";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        final String responseString = response.body;
        items = foodsModelFromJson(responseString);
        filterItems = items;
      });
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
          "ค้นหาอาหาร",
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
                hintText: "ชื่ออาหาร หรือ ราคา",
                hintStyle: GoogleFonts.kanit(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.black54)),
                icon: Icon(
                  Icons.search,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  filterItems = items
                      .where((u) => (u.foodName
                              .toLowerCase()
                              .contains(value.toLowerCase()) ||
                          u.foodPrice
                              .toString()
                              .toLowerCase()
                              .contains(value.toLowerCase())))
                      .toList();
                });
              },
            ),
          ),
          Expanded(
              child: (items == null)
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
                          leading: Image.network(
                            filterItems[index].foodImg,
                            fit: BoxFit.cover,
                            width: 50,
                            height: 50,
                          ),
                          title: Text(
                            "${filterItems[index].foodName}",
                            style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                    // fontWeight: FontWeight.w600,
                                    color: Colors.black)),
                          ),
                          subtitle: Text(
                            "${filterItems[index].foodPrice}",
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

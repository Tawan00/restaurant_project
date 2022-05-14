import 'package:restaurant_project/Model/FoodModel/FoodsModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class DataFood extends StatefulWidget {
  @override
  _DataFoodState createState() => _DataFoodState();
}

class _DataFoodState extends State<DataFood> {
  List<FoodsModel> DataFood;
  Future<Null> foodsJson() async {
    var url = "http://itoknode@itoknode.comsciproject.com/foods/Foods";
    final response = await http.get(Uri.parse(url));
    print(response.statusCode);
    if (response.statusCode == 400) {
      setState(() {
        final String responseString = response.body;
        DataFood = foodsModelFromJson(responseString);
      });
    }
    print(DataFood);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: null,
    );
  }

  Widget _buildSuggestion() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: DataFood.length,
        itemBuilder: (context, i) {
          return ListTile(
            title: Text(DataFood[i].foodName,
                style: GoogleFonts.kanit(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.black54))),
          );
        });
  }
}

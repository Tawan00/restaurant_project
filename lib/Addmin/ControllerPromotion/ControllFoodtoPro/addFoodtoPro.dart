import 'package:restaurant_project/Addmin/ControllerPromotion/ListPromotion.dart';
import 'package:restaurant_project/Foods/DataFoods.dart';
import 'package:restaurant_project/Model/FoodModel/FoodsModel.dart';
import 'package:restaurant_project/Model/MessageModel.dart';
import 'package:restaurant_project/Model/PromotionModel/ProFoodModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class AddFoodToPro extends StatefulWidget {
  @override
  _AddFoodToProState createState() => _AddFoodToProState();
  int pro_id;
  int pro_discount;
  AddFoodToPro({this.pro_id, this.pro_discount});
}

class _AddFoodToProState extends State<AddFoodToPro> {
  @override
  void initState() {
    super.initState();
    getfoods();
    getprofood();
    proId = this.widget.pro_id;
    proDis = this.widget.pro_discount;
    print(proId);
    print(proDis);
  }

  var proId;
  int proDis;
  double newPrice;
  List<String> tempArray = [];
  List<FoodsModel> DataFood;
  Future<Null> getfoods() async {
    var url = "http://itoknode.comsciproject.com/foods/Foods";
    final response = await http.get(Uri.parse(url));
    print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() {
        final String responseString = response.body;
        DataFood = foodsModelFromJson(responseString);
      });
    }
    print(DataFood[0].foodPrice.toString());
    // print(DataFood);
  }

  void calPrice() {}
  List<ProFoodModel> Profood;
  Future<Null> getprofood() async {
    var url = "http://itoknode.comsciproject.com/pro/FoodProAll2";
    final response = await http.get(Uri.parse(url));
    print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() {
        final String responseString = response.body;
        Profood = proFoodModelFromJson(responseString);
      });
    }
    print(Profood);
    for (var i = 0; i < Profood.length; i++) {
      tempArray.add(Profood[i].foodId.toString());
    }
  }

  Future<MessageModel> add(String pro_id, String food_id) async {
    final url = "http://itoknode.comsciproject.com/pro/AddFoodToPro";
    final response = await http
        .post(Uri.parse(url), body: {"pro_id": pro_id, "food_id": food_id});
    if (response.statusCode == 200) {
      String responseString = response.body;
      return messageModelFromJson(responseString);
    } else {
      return null;
    }
  }

  Future<MessageModel> updateNewfood(
      String food_id, String food_price_new) async {
    final url = "http://itoknode.comsciproject.com/pro/UpdateNewPrice";
    final response = await http.post(Uri.parse(url),
        body: {"food_id": food_id, "food_price_new": food_price_new});
    if (response.statusCode == 200) {
      String responseString = response.body;
      return messageModelFromJson(responseString);
    } else {
      return null;
    }
  }

  Future<MessageModel> delete(String food_id) async {
    final url = 'http://itoknode.comsciproject.com/pro/delete';
    final response =
        await http.post(Uri.parse(url), body: {"food_id": food_id});
    if (response.statusCode == 200) {
      String responseString = response.body;
      return messageModelFromJson(responseString);
    } else {
      return null;
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
              "เลือกอาหาร",
              style:
                  GoogleFonts.kanit(textStyle: TextStyle(color: Colors.black)),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => ListPro()));
                // Navigator.of(context).pop();
              },
            )),
        body: (DataFood == null)
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
            : _buildSuggestion());
  }

  Widget _buildSuggestion() {
    // final alreadySaave
    return ListView.builder(
        itemCount: DataFood.length,
        itemBuilder: (context, i) {
          return InkWell(
            onTap: () async {
              setState(() {});
              newPrice = DataFood[i].foodPrice.toInt() -
                  (proDis * DataFood[i].foodPrice.toInt()) / 100;
              print("newPrince" + newPrice.toString());
              if (tempArray.contains(DataFood[i].foodId.toString())) {
                tempArray.remove(DataFood[i].foodId.toString());
                final MessageModel DELETE =
                    await delete(DataFood[i].foodId.toString());
                if (DELETE.message == 'Success') {
                  print("Delete Success");
                } else {
                  print('Delete Failed');
                }
                final MessageModel UPDATE = await updateNewfood(
                    DataFood[i].foodId.toString(), 0.toString());
                if (UPDATE.message == 'Success') {
                  print("Updete Success");
                } else {
                  print('Update Failed');
                }
              } else {
                tempArray.add(DataFood[i].foodId.toString());
                final MessageModel ADD = await add(
                    this.widget.pro_id.toString(),
                    DataFood[i].foodId.toString());
                if (ADD.message == 'Success') {
                  print("Add Success");
                } else {
                  print('Add Failed');
                }
                final MessageModel UPDATE = await updateNewfood(
                    DataFood[i].foodId.toString(), newPrice.toString());
                if (UPDATE.message == 'Success') {
                  print("Updete Success");
                } else {
                  print('Update Failed');
                }
              }
              print(tempArray.toString());
            },
            child: Card(
              child: ListTile(
                title: Text(DataFood[i].foodName,
                    style: GoogleFonts.kanit(
                        textStyle: TextStyle(color: Colors.black54))),
                trailing: Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                      color: tempArray.contains(DataFood[i].foodId.toString())
                          ? Colors.red
                          : Colors.green,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                        tempArray.contains(DataFood[i].foodId.toString())
                            ? 'Remove'
                            : 'Add',
                        style: GoogleFonts.kanit(
                            textStyle: TextStyle(color: Colors.white))),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

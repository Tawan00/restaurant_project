// import 'package:EERestaurant/Foods/OrderList.dart';
// import 'package:EERestaurant/Homepage/BottomBar.dart';
// import 'package:EERestaurant/Model/FoodModel/FoodsModel.dart';
// import 'package:EERestaurant/Model/FoodModel/TypeFoodsModel.dart';
// import 'package:EERestaurant/Model/OrderModel/OrderModel.dart';
// import 'package:EERestaurant/Table/ReceiveTable.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Food2 extends StatefulWidget {
//   @override
//   _Food2State createState() => _Food2State();
// }

// class _Food2State extends State<Food2> {
//   @override
//   void initState() {
//     super.initState();
//     getToken();
//   }

//   var f = TextEditingController();
//   List<int> Foodid = [];
//   List<String> Img = [];
//   List<String> nameFood = [];
//   List<int> priceFood = [];
//   int foodlength = 0;
//   TabController _tabControllor;

//   List<TypeFoodsModel> _typeFoods;
//   int len;
//   List<int> x;

//   Future<Null> GetTypefoods() async {
//     var url = "http://itoknode@itoknode.comsciproject.com/foods/TypeFoods";
//     final response = await http.get(Uri.parse(url));

//     print(response.statusCode);
//     if (response.statusCode == 200) {
//       setState(() {
//         final String responseString = response.body;
//         _typeFoods = typeFoodsModelFromJson(responseString);
//       });
//     }

//     Getfood(_typeFoods[0].tfId.toString());
//   }

//   List<FoodsModel> _type;
//   Future<Null> Getfood(String type_id) async {
//     var url = "http://itoknode@itoknode.comsciproject.com/search/FoodOnType";
//     final response =
//         await http.post(Uri.parse(url), body: {"type_id": type_id});
//     //print(response.statusCode);
//     print(response.statusCode);
//     if (response.statusCode == 200) {
//       setState(() {
//         final String responseString = response.body;
//         _type = foodsModelFromJson(responseString);
//         print(_type[0].foodName);
//       });
//     }
//   }

//   String token = "";
//   Future<Null> getToken() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     token = preferences.getString("token");

//     getdata();
//     GetTypefoods();
//   }

//   List<OrderModel> _orderModel;
//   Future<Null> getdata() async {
//     final String url =
//         "http://itoknode@itoknode.comsciproject.com/table/AuthTable";
//     final response = await http
//         .get(Uri.parse(url), headers: {"Authorization": "Bearer $token"});
//     if (response.statusCode == 200) {
//       setState(() {
//         var responseString = response.body;
//         //print(response.body);
//         _orderModel = orderModelFromJson(responseString);
//         // accName.text = userModel[0].accName;
//         // accId.text = userModel[0].accId.toString();
//         // accTel.text = userModel[0].accTel;
//         print(_orderModel[0].btId);
//         print(_orderModel[0].accId);
//         print(_orderModel[0].accName);
//         print(_orderModel[0].btCount);
//         print(_orderModel[0].btDateCheckIn);
//         print(_orderModel[0].btStartTime);
//         print(_orderModel[0].btEndTime);
//       });
//     } else {
//       return null;
//     }
//   }

//   int selected = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xFFFCFAF8),
//         elevation: 0,
//         centerTitle: true,
//         title: Text(
//           "สั่งจองอาหาร",
//           style: GoogleFonts.kanit(textStyle: TextStyle(color: Colors.black)),
//         ),
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back_ios,
//             color: Colors.black,
//           ),
//           onPressed: () {
//             Navigator.of(context).push(MaterialPageRoute(
//                 builder: (context) => ReceiveTales(
//                     //username: this.widget.username,
//                     )));
//           },
//         ),
//         actions: [
//           Stack(
//             children: [
//               IconButton(
//                 icon: Icon(
//                   Icons.shopping_basket,
//                   color: Colors.grey[400],
//                 ),
//                 onPressed: () {
//                   print("count = ${Foodid.length}");

//                   Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => OrderList(
//                             bt_id: _orderModel[0].btId,
//                             id: Foodid,
//                             nameFood: nameFood,
//                             imgFood: Img,
//                             priceFood: priceFood,
//                           )));
//                 },
//               ),
//               Positioned(
//                 top: 1,
//                 right: 3,
//                 child: Container(
//                   height: 18,
//                   width: 18,
//                   decoration: BoxDecoration(
//                     color: Color(0xFFFF4848),
//                     shape: BoxShape.circle,
//                     border: Border.all(width: 1.5, color: Colors.white),
//                   ),
//                   child: Center(
//                     child: Text(
//                       "${Foodid.length}",
//                       style: GoogleFonts.kanit(
//                           textStyle: TextStyle(
//                               fontSize: 10.0,
//                               height: 1,
//                               color: Colors.white,
//                               fontWeight: FontWeight.w600)),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             width: 20,
//           )
//         ],
//       ),
//       body: (_typeFoods == null || _type == null)
//           ? Material(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[CircularProgressIndicator()],
//                   ),
//                 ],
//               ),
//             )
//           : ListView(
//               padding: EdgeInsets.only(left: 20.0, right: 20.0),
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     height: 40,
//                     padding: EdgeInsets.symmetric(horizontal: 10),
//                     child: ListView.separated(
//                       padding: EdgeInsets.symmetric(horizontal: 0),
//                       scrollDirection: Axis.horizontal,
//                       itemCount: _typeFoods.length,
//                       itemBuilder: (context, index) => GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             selected = index;
//                             Getfood(_typeFoods[index].tfId.toString());
//                           });
//                         },
//                         child: Container(
//                           padding: EdgeInsets.symmetric(
//                               vertical: 10, horizontal: 15),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                             color: selected == index
//                                 ? Colors.grey[400]
//                                 : Colors.white,
//                           ),
//                           child: Text(
//                             _typeFoods[index].tfName,
//                             style: GoogleFonts.kanit(
//                                 textStyle: TextStyle(
//                                     fontSize: 15.0,
//                                     color: selected == index
//                                         ? Colors.white
//                                         : Color(0xFFC88D67))),
//                           ),
//                         ),
//                       ),
//                       separatorBuilder: (_, index) => SizedBox(
//                         width: 15,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   //padding: EdgeInsets.only(right: 15.0),
//                   width: MediaQuery.of(context).size.width,
//                   height: MediaQuery.of(context).size.height - 190,
//                   child: GridView.builder(
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2,
//                           mainAxisSpacing: 15.0,
//                           crossAxisSpacing: 10.0,
//                           childAspectRatio: 0.8),
//                       itemCount: _type.length,
//                       itemBuilder: (context, index) {
//                         return _buildCard(
//                             index,
//                             _type[index].foodName,
//                             "฿" + _type[index].foodPrice.toString(),
//                             _type[index].foodImg,
//                             false,
//                             false,
//                             context);
//                       }),
//                 ),
//               ],
//             ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Navigator.of(context).pop();
//         },
//         backgroundColor: Color(0xFFF17532),
//         child: Icon(Icons.fastfood),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       bottomNavigationBar: BottomBar(),
//     );
//   }

//   Widget _buildCard(int index, String name, String price, String imgPath,
//       bool added, bool isFaverite, context) {
//     return Padding(
//       padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
//       child: InkWell(
//         onTap: () {},
//         child: Container(
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(15.0),
//               boxShadow: [
//                 BoxShadow(
//                     color: Colors.grey.withOpacity(0.2),
//                     spreadRadius: 3.0,
//                     blurRadius: 5.0)
//               ],
//               color: Colors.white),
//           child: Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(5.0),
//               ),
//               Container(
//                 height: 75.0,
//                 width: 75.0,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                       image: NetworkImage(imgPath), fit: BoxFit.contain),
//                 ),
//               ),
//               SizedBox(
//                 height: 7.0,
//               ),
//               Text(price,
//                   style: GoogleFonts.kanit(
//                       textStyle: TextStyle(
//                     fontSize: 14.0,
//                     color: Color(0xFFCC8053),
//                   ))),
//               Text(
//                 name,
//                 style: GoogleFonts.kanit(
//                     textStyle: TextStyle(
//                   fontSize: 14.0,
//                   color: Color(0xFF575E67),
//                 )),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Container(
//                   color: Color(0xFFEBEBEB),
//                   height: 1.0,
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
//                 child: GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       foodlength += 1;
//                     });

//                     print(_type[index].foodId);
//                     Foodid.add(_type[index].foodId);
//                     Img.add(_type[index].foodImg);
//                     nameFood.add(_type[index].foodName);
//                     priceFood.add(_type[index].foodPrice);
//                   },
//                   child: Container(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         if (!added) ...[
//                           Icon(Icons.shopping_basket,
//                               color: Color(0xFFD17E50), size: 12.0),
//                           SizedBox(
//                             width: 5.0,
//                           ),
//                           Text('เพิ่มใส่ตะกร้า',
//                               style: GoogleFonts.kanit(
//                                 textStyle: TextStyle(
//                                     color: Color(0xFFD17E50), fontSize: 14.0),
//                               )),
//                         ],
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

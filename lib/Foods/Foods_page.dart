// import 'package:EERestaurant/Shopping/shopping.dart';
// import 'package:bloc_pattern/bloc_pattern.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:EERestaurant/Model/FoodsModel.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/services.dart';
// import 'package:EERestaurant/Cart/Cart.dart';
// import 'dart:convert';
// import 'dart:io';

// class FoodsPage extends StatefulWidget {
//   @override
//   _FoodsPageState createState() => _FoodsPageState();
// }

// class _FoodsPageState extends State<FoodsPage> {
//   @override
//   void initState() {
//     super.initState();
//     foodsJson();
//   }

//   List<int> id = [];
//   List<String> imgFood = [
//     'https://static.thairath.co.th/media/Dtbezn3nNUxytg04N1N15XzM3svhGU7Pm1V0V1moxNSBTk.jpg',
//   ];
//   List<FoodsModel> items;
//   Future<Null> foodsJson() async {
//     var url = "http://itoknode@itoknode.comsciproject.com/foods/Foods";
//     final response = await http.get(Uri.parse(url));
//     print(response.statusCode);
//     if (response.statusCode == 200) {
//       setState(() {
//         final String responseString = response.body;
//         items = foodsModelFromJson(responseString);
//       });
//     }
//     print(items);
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
//                 padding: EdgeInsets.only(left: 5.0, right: 5.0),
//                 child: GestureDetector(
//                   onTap: () {
//                     print(items[index].foodId);
//                     id.add(items[index].foodId);
//                   },
//                   child: Container(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         if (!added) ...[
//                           // TextButton.icon(
//                           //   onPressed: () {},
//                           //   icon: Icon(Icons.shopping_basket,
//                           //       color: Color(0xFFD17E50), size: 12.0),
//                           //   label: Text('เพิ่มใส่ตะกร้า',
//                           //       style: GoogleFonts.kanit(
//                           //         textStyle: TextStyle(
//                           //             color: Color(0xFFD17E50), fontSize: 12.0),
//                           //       )),
//                           // ),
//                           Icon(Icons.shopping_basket,
//                               color: Color(0xFFD17E50), size: 12.0),
//                           SizedBox(
//                             width: 5.0,
//                           ),
//                           Text('เพิ่มใส่ตะกร้า',
//                               style: GoogleFonts.kanit(
//                                 textStyle: TextStyle(
//                                     color: Color(0xFFD17E50), fontSize: 12.0),
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

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFFCFAF8),
//       body: (items == null)
//           ? Material(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       // Text(
//                       //   "Initialization",
//                       //   style: TextStyle(
//                       //     fontSize: 32,
//                       //     fontWeight: FontWeight.bold,
//                       //   ),
//                       // ),
//                       // SizedBox(height: 20),
//                       CircularProgressIndicator()
//                     ],
//                   ),
//                 ],
//               ),
//             )
//           : ListView(
//               children: [
//                 Container(
//                   padding: EdgeInsets.only(right: 15.0),
//                   width: MediaQuery.of(context).size.width - 30.0,
//                   height: MediaQuery.of(context).size.height,
//                   child: GridView.builder(
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         mainAxisSpacing: 15.0,
//                         crossAxisSpacing: 10.0,
//                         childAspectRatio: 0.8),
//                     itemCount: items.length,
//                     itemBuilder: (context, index) => _buildCard(
//                         index,
//                         items[index].foodName,
//                         "฿" + items[index].foodPrice.toString(),
//                         imgFood[0],
//                         false,
//                         false,
//                         context),
//                   ),
//                 ),
//                 SizedBox(height: 150.0),
//               ],
//             ),
//     );
//   }
// }

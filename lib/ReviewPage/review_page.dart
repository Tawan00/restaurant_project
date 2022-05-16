import 'package:restaurant_project/Addmin/ControllerUser/AddUser.dart';
import 'package:restaurant_project/Homepage/HomePage.dart';
import 'package:restaurant_project/Model/AEModel/TkAddModel.dart';
import 'package:restaurant_project/Model/ReviewModel/reviewAllModel.dart';
import 'package:restaurant_project/Model/UserModel/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewPage extends StatefulWidget {
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  @override
  void initState() {
    super.initState();
    GetReview();
    getToken();
  }

  var score = TextEditingController();
  String token = "";
  Future<Null> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString("token");
    getdata();
  }

  List<UserModel> userModel;
  Future<Null> getdata() async {
    final String url = "http://itoknode@itoknode.comsciproject.com/user/User";
    final response = await http
        .get(Uri.parse(url), headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      setState(() {
        var responseString = response.body;
        userModel = userModelFromJson(responseString);
      });
    } else {
      return null;
    }
  }

  List<ReviewAllModel> filterItems;
  List<ReviewAllModel> DataReview;
  Future<Null> GetReview() async {
    var url = "http://itoknode@itoknode.comsciproject.com/review/ShowReviewAll";
    final response = await http.get(Uri.parse(url));
    //print(response.statusCode);
    print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() {
        final String responseString = response.body;
        DataReview = reviewAllModelFromJson(responseString);
        filterItems = DataReview;
      });
    }
  }

  Future<TkAddModel> Add(String acc_id, String rv_desc, String rv_score) async {
    final String url =
        "http://itoknode@itoknode.comsciproject.com/review/AddReview";
    final response = await http.post(Uri.parse(url),
        body: {"acc_id": acc_id, "rv_desc": rv_desc, "rv_score": rv_score});

    print(response.statusCode);
    if (response.statusCode == 200) {
      String responseString = response.body;
      return tkAddModelFromJson(responseString);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCFAF8),
      appBar: AppBar(
        backgroundColor: Color(0xFFFCFAF8),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "รีวิวร้านและอาหาร",
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
                hintText: "ชื่อ หรือ ราคา",
                hintStyle: GoogleFonts.kanit(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.black54)),
                icon: Icon(
                  Icons.search,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  filterItems = DataReview.where((u) =>
                      (u.accName.toLowerCase().contains(value.toLowerCase()) ||
                          u.rvScore
                              .toString()
                              .toLowerCase()
                              .contains(value.toLowerCase()))).toList();
                });
              },
            ),
          ),
          Expanded(
            child: (DataReview == null)
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
                    shrinkWrap: true,
                    itemCount: filterItems.length,
                    itemBuilder: (BuildContext context, index) {
                      return Card(
                        child: ListTile(
                          enabled: true,
                          dense: true,
                          leading: (filterItems[index].accImg == null ||
                                  filterItems[index].accImg == "")
                              ? Icon(
                                  Icons.person,
                                  color: Colors.black,
                                  size: 60.0,
                                )
                              : Image.network(filterItems[index].accImg),
                          title: Row(
                            children: [
                              Text("${filterItems[index].accName} • ",
                                  style: GoogleFonts.kanit(
                                      textStyle: TextStyle(
                                          // fontWeight: FontWeight.w600,
                                          color: Colors.black))),
                              Icon(
                                Icons.star,
                                color: Color(0xFFF4C464),
                                size: 14.0,
                              ),
                              Text("${filterItems[index].rvScore}",
                                  style: GoogleFonts.kanit(
                                      textStyle:
                                          TextStyle(color: Colors.black54))),
                            ],
                          ),
                          subtitle: Text(filterItems[index].rvDesc,
                              style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                      color: Colors.black45, fontSize: 13.0))),
                          trailing: Text(
                              "${filterItems[index].rvDate.day}-${filterItems[index].rvDate.month}-${filterItems[index].rvDate.year}",
                              style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                      color: Colors.black54, fontSize: 13.0))),
                          isThreeLine: true,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          CreateDialogAddReview();
        },
        backgroundColor: Color(0xFFF17532),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  var user = TextEditingController();
  var desc = TextEditingController();
  double rating = 0;
  Future CreateDialogAddReview() => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Container(
            height: 70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "เพิ่มรีวิว",
                  style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
                ),
                Text(
                  "รีวิวของท่าน ทางร้านจะนำไปปรับปรุงและแก้ไขให้ดีขึ้น",
                  style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                    fontSize: 12.0,
                    color: Colors.black54,
                  )),
                ),
              ],
            ),
          ),
          content: Container(
            height: 130,
            child: Column(
              children: [
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      this.rating = rating;
                      score.text = this.rating.toString();
                      print(score.text);
                    });
                  },
                ),
                TextField(
                  controller: desc,
                  decoration: InputDecoration(
                      labelText: 'กรอกข้อความ',
                      labelStyle: GoogleFonts.kanit(
                          textStyle: TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey.withOpacity(0.5))),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      icon: Icon(
                        Icons.email,
                        size: 20,
                      )),
                ),
              ],
            ),
          ),
          actions: [
            FlatButton(
              child: Text(
                'ยกเลิก',
                style: GoogleFonts.kanit(
                    textStyle: TextStyle(
                  color: Colors.red[400],
                  fontWeight: FontWeight.w600,
                )),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                'ยืนยัน',
                style: GoogleFonts.kanit(
                    textStyle: TextStyle(
                  color: Colors.green[400],
                  fontWeight: FontWeight.w600,
                )),
              ),
              onPressed: () async {
                if (desc.text != "" && score.text != "") {
                  final TkAddModel add = await Add(
                      userModel[0].accId.toString(), desc.text, score.text);

                  if (add.message == "Success") {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ReviewPage()));
                  }
                }
              },
            ),
          ],
        ),
      );
}

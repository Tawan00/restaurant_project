import 'dart:ui';
import 'package:restaurant_project/Homepage/HomePage.dart';
import 'package:restaurant_project/Login/Login.dart';
import 'package:restaurant_project/Model/UserModel/UserModel.dart';
import 'package:restaurant_project/ReviewPage/review_page.dart';
import 'package:restaurant_project/Search/searchpromotion.dart';
import 'package:restaurant_project/Store/ShowStore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_project/Table/ReceiveTable.dart';
import 'package:restaurant_project/Profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class NavBar extends StatefulWidget {
  NavBar({Key key, this.token}) : super(key: key);
  String token;
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  void initState() {
    super.initState();
    //getToken();

    if (this.widget.token != "" && this.widget.token != null) {
      getdata();
    }
  }

  // String token;
  // Future<Null> getToken() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   token = preferences.getString("token");
  //   print("token " + token);
  //   if (token != "" && token != null) {
  //     getdata();
  //   }
  // }

  List<UserModel> userModel;
  var accEmail = TextEditingController();
  var accName = TextEditingController();
  var accSname = TextEditingController();
  Future<Null> getdata() async {
    final String url = "http://itoknode@itoknode.comsciproject.com/user/User";
    final response = await http.get(Uri.parse(url),
        headers: {"Authorization": "Bearer ${this.widget.token}"});

    if (response.statusCode == 200) {
      setState(() {
        var responseString = response.body;
        userModel = userModelFromJson(responseString);
        accEmail.text = userModel[0].accEmail;
        accName.text = userModel[0].accName;
        accSname.text = userModel[0].accSname;
      });
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return (userModel == null && this.widget.token != null)
        ? Drawer(
            child: Center(child: CircularProgressIndicator()),
          )
        : Drawer(
            child: (this.widget.token == null || this.widget.token == null)
                ? ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      UserAccountsDrawerHeader(
                        accountName: Text(''),
                        accountEmail: Text(''),
                        currentAccountPicture: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: ClipOval(
                            // child: Image.asset('assets/icon/user1.png',
                            //     width: 90, height: 90, fit: BoxFit.cover),
                            child: Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/bg_default.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.person),
                        title: Text('Login'),
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.local_offer_outlined),
                        title: Text('Promotion'),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SearchPromotion()));
                        },
                      ),
                    ],
                  )
                : ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      UserAccountsDrawerHeader(
                        accountName: Text(
                            '${userModel[0].accName} ${userModel[0].accSname}'),
                        accountEmail: Text('${userModel[0].accEmail}'),
                        currentAccountPicture: (userModel[0].accImg == null ||
                                userModel[0].accImg == "")
                            ? CircleAvatar(
                                backgroundColor: Colors.white,
                                child: ClipOval(
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.black,
                                    size: 40.0,
                                  ),
                                ),
                              )
                            : CircleAvatar(
                                backgroundImage:
                                    NetworkImage(userModel[0].accImg),
                              ),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/bg_default.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.person),
                        title: Text('Profile'),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Profile()));
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.home),
                        title: Text('Home'),
                        onTap: () => Navigator.of(context).pop(),
                      ),
                      ListTile(
                        leading: Icon(Icons.shopping_cart),
                        title: Text('Shopping'),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ReceiveTables()));
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.local_offer_outlined),
                        title: Text('Promotion'),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SearchPromotion()));
                        },
                      ),
                      ListTile(
                          leading: Icon(Icons.notifications),
                          title: Text('Review'),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ReviewPage()));
                          }),
                      Divider(),
                      // ListTile(
                      //   leading: Icon(Icons.settings),
                      //   title: Text('Setting'),
                      //   onTap: () => null,
                      // ),
                      ListTile(
                        leading: Icon(Icons.info),
                        title: Text('About'),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Showstore()));
                        },
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.logout),
                        title: Text('Logout'),
                        onTap: () async {
                          if (this.widget.token != "" &&
                              this.widget.token != null) {
                            showExitDialog();
                          } else {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Login()));
                          }
                        },
                      ),
                    ],
                  ),
          );
  }

  Future showExitDialog() => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Center(
              child: Text(
            'ต้องการออกจากระบบ?',
            style: GoogleFonts.kanit(
                textStyle: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w600)),
          )),
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
                'ใช่',
                style: GoogleFonts.kanit(
                    textStyle: TextStyle(
                  color: Colors.green[400],
                  fontWeight: FontWeight.w600,
                )),
              ),
              onPressed: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                preferences.clear();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => Login()),
                    (route) => false);
              },
            ),
          ],
        ),
      );
}

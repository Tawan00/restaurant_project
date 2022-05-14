import 'package:restaurant_project/Login/Login.dart';
import 'package:restaurant_project/Model/UserModel/UserModel.dart';
import 'package:restaurant_project/MyOrder/myorder.dart';
import 'package:restaurant_project/Search/searchfood.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_project/Profile/profile.dart';
import 'package:restaurant_project/main.dart';
import 'package:restaurant_project/Homepage/HomePage.dart';
import 'package:restaurant_project/Addmin/ControllerUser/UserList.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  void initState() {
    super.initState();
    getToken();
  }

  String token = "";
  Future<Null> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString("token");
    if (token != "" && token != null) {
      getdata();
    }
  }

  List<UserModel> userModel;

  Future<Null> getdata() async {
    final String url = "http://itoknode@itoknode.comsciproject.com/user/User";
    final response = await http
        .get(Uri.parse(url), headers: {"Authorization": "Bearer $token"});
    print(response.body);
    if (response.statusCode == 200) {
      setState(() {
        var responseString = response.body;
        print(response.body);
        userModel = userModelFromJson(responseString);
        print(userModel[0].accName);
      });
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 6.0,
      color: Colors.transparent,
      elevation: 9.0,
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: 50.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
            color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width / 2 - 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.home, color: Color(0xFFEF7532)),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.person_outline, color: Color(0xFF676E79)),
                    onPressed: () {
                      if (token != "" && token != null) {
                        print("PROFILE");
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Profile()));
                      } else {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Login()));
                      }

                      // if (userModel[0].accType == 0) {

                      // } else {
                      //   Navigator.of(context).push(MaterialPageRoute(
                      //       builder: (context) => UserList()));
                      // }
                    },
                  )
                ],
              ),
            ),
            Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width / 2 - 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.search, color: Color(0xFFEF7532)),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SearchFood()));
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.pending_actions, color: Color(0xFF676E79)),
                    onPressed: () {
                      if (token != "" && token != null) {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => MyOrder()));
                      } else {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Login()));
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

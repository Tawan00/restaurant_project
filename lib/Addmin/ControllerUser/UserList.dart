import 'package:restaurant_project/Addmin/ControllerUser/AddUser.dart';
import 'package:restaurant_project/Addmin/ControllerUser/EditUser.dart';
import 'package:restaurant_project/Addmin/MainAdmin.dart';
import 'package:restaurant_project/Homepage/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_project/Model/UserModel/UserModel.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  TextEditingController _NameController;
  TextEditingController _LastNameController;

  @override
  void initState() {
    super.initState();
    getToken();
  }

  String token = "";

  Future<Null> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString("token");
    GetUser();
  }

  List<UserModel> UserData;

  Future<Null> GetUser() async {
    var url = "http://itoknode@itoknode.comsciproject.com/user/AllUser";
    final response = await http.get(Uri.parse(url));
    //print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() {
        final String responseString = response.body;
        UserData = userModelFromJson(responseString);
      });
    }
    print(UserData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFCFAF8),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "จัดการข้อมูลผู้ใช้งาน",
          style: GoogleFonts.kanit(textStyle: TextStyle(color: Colors.black)),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => MainAdmin()));
            // Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AddUser()));
            },
          ),
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.black,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: (UserData == null)
          ? Material(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Text(
                      //   "Initialization",
                      //   style: TextStyle(
                      //     fontSize: 32,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // SizedBox(height: 20),
                      CircularProgressIndicator()
                    ],
                  ),
                ],
              ),
            )
          : ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        horizontalMargin: 0,
                        columnSpacing: 0,
                        columns: [
                          DataColumn(
                              label: Text(
                            'ชื่อ',
                            style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                    color: Color(0xFFD17E50),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600)),
                          )),
                          DataColumn(
                              label: Text(
                            'นามสกุล',
                            style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                    color: Color(0xFFD17E50),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600)),
                          )),
                          DataColumn(
                              label: Text(
                            'แก้ไข',
                            style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                    color: Color(0xFFD17E50),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600)),
                          )),
                        ],
                        rows: List<DataRow>.generate(
                            UserData.length,
                            (index) => DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text(
                                      UserData[index].accName,
                                      style: GoogleFonts.kanit(
                                          textStyle:
                                              TextStyle(color: Colors.black)),
                                    )),
                                    DataCell(Text(
                                      UserData[index].accSname,
                                      style: GoogleFonts.kanit(
                                          textStyle:
                                              TextStyle(color: Colors.black)),
                                    )),
                                    DataCell(ListTile(
                                      leading: Icon(
                                        Icons.edit,
                                        color: Colors.green[600],
                                      ),
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) => EditUser(
                                                    id: UserData[index].accId,
                                                    name:
                                                        UserData[index].accName,
                                                    lname: UserData[index]
                                                        .accSname,
                                                    img: UserData[index].accImg,
                                                    addr:
                                                        UserData[index].accAddr,
                                                    tel: UserData[index].accTel,
                                                    email: UserData[index]
                                                        .accEmail,
                                                    username:
                                                        UserData[index].accUser,
                                                    pass:
                                                        UserData[index].accPass,
                                                    line:
                                                        UserData[index].accLine,
                                                    face: UserData[index].accFB,
                                                    typeuser:
                                                        UserData[index].accType,
                                                    status: UserData[index]
                                                        .accStatus)));
                                      },
                                    )),
                                  ],
                                )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

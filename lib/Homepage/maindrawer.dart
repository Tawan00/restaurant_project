import 'package:restaurant_project/Login/Login.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_project/Profile/profile.dart';

class maindrawer extends StatefulWidget {
  maindrawer({Key key}) : super(key: key);

  @override
  _maindrawerState createState() => _maindrawerState();
}

class _maindrawerState extends State<maindrawer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          /* decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg3.jpg'),
            ),
          ),*/
          child: Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage('assets/images/profile.jpg'),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'Tawan Joothaisong',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  '61011212037@msu.ac.th',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        new Divider(),
        ListTile(
          title: Text('Profile'),
          leading: Icon(
            Icons.person,
            color: Colors.red[400],
          ),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Profile()));
          },
        ),
        ListTile(
          title: Text('Shopping'),
          leading: Icon(
            Icons.shopping_cart,
            color: Colors.red[400],
          ),
          onTap: () {},
        ),
        ListTile(
          title: Text('Settings'),
          leading: Icon(
            Icons.settings,
            color: Colors.red[400],
          ),
          onTap: () {},
        ),
        new Divider(),
        ListTile(
          title: Text('About'),
          leading: Icon(
            Icons.info,
            color: Colors.red[400],
          ),
          onTap: () {},
        ),
        ListTile(
          title: Text('Logout'),
          leading: Icon(
            Icons.logout,
            color: Colors.red[400],
          ),
          onTap: () {},
        ),
      ],
    );
  }
}

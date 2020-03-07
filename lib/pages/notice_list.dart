import 'package:flutter/material.dart';
import 'package:noticeboard_app/services/auth.dart';

class NoticeList extends StatelessWidget {
  final String userId;
  const NoticeList({Key key, this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> mykey = GlobalKey<ScaffoldState>();
    return Scaffold(
        key: mykey,
        endDrawer: SafeArea(
          child: Drawer(
            child: Column(
              children: <Widget>[
                DrawerHeader(
                  child: Text('Trial'),
                ),
                InkWell(
                  child: Container(
                    height: 54,
                    child: Text('New'),
                  ),
                  onTap: (){
                    Navigator.pushNamed(context, '/edit');
                  },
                ),
                Container(
                  height: 54,
                  child: Text('Profile'),
                ),
                Container(
                  height: 54,
                  child: Text('Users List'),
                ),
                Container(
                  height: 54,
                  child: Text('Add User'),
                ),
                Container(
                  height: 54,
                  child: Text('About'),
                ),
                Container(
                  height: 54,
                  child: InkWell(
                    child: Text('Logout'),
                    onTap: (){
                      Authentication().signOut();
                      Navigator.pushNamed(context, '/');
                    },
                    ),
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blue,
          actions: <Widget>[SizedBox.shrink()],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Hero(
                tag: 'MMU logo',
                child: Image(
                  image: AssetImage('assets/images/Logo.png'),
                  height: 36,
                  width: 59,
                ),
              ),
              Text(
                'NOTICES',
                style: TextStyle(
                    color: Color(0xAA243782),
                    fontSize: 24,
                    fontFamily: 'Orbitron'),
              ),
              InkWell(
                child: Icon(
                  Icons.menu,
                  color: Color(0xAA243782),
                  size: 33,
                ),
                onTap: () {
                  mykey.currentState.openEndDrawer();
                },
              ),
            ],
          ),
        ),
        body: Container(
          color: Color(0xAAAB8B3F2),
          child: Center(
            child: Text('Trial'),
          ),
        ));
  }
}

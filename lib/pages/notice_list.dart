import 'package:flutter/material.dart';
import 'package:noticeboard_app/methods/file_handling_methods.dart';
import 'package:noticeboard_app/models/user.dart';
import 'package:noticeboard_app/services/auth.dart';
import 'package:provider/provider.dart';

import '../notifiers.dart';

class NoticeList extends StatelessWidget {
  const NoticeList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
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
                user == null
                    ? SizedBox.shrink()
                    : InkWell(
                        child: Container(
                          height: 54,
                          width: double.infinity,
                          child: Center(
                            child: Text('New'),
                          ),
                        ),
                        onTap: () async {
                          await showDialog(
                              builder: (context) {
                                return AlertDialog(
                                  content: Container(
                                    height: MediaQuery.of(context).size.width * 0.5,
                                    child: Column(
                                      children: <Widget>[
                                        TextField(
                                          style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                              bottom: 15,
                                              left: 10,
                                            ),
                                            fillColor: Colors.white,
                                            filled: true,
                                            hintText: 'Notice Title',
                                            hintStyle: TextStyle(
                                              fontFamily: 'Lato',
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                width: 3,
                                                color: Color(0xAAA7287DC),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                width: 3,
                                                color: Color(0xAAA243782),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              context: context);
                          String pdfPath = await Pdf().getPdf();
                          Navigator.pop(context);
                          Provider.of<NotificationModel>(context, listen: false)
                              .addFile(pdfPath, user);
                          Navigator.pushNamed(context, '/edit',
                              arguments: {'pdfPath': pdfPath});
                        },
                      ),
                user == null
                    ? SizedBox.shrink()
                    : Container(
                        height: 54,
                        width: double.infinity,
                        child: Center(
                          child: Text('New'),
                        ),
                      ),
                user == null
                    ? SizedBox.shrink()
                    : Container(
                        height: 54,
                        width: double.infinity,
                        child: Center(
                          child: Text('New'),
                        ),
                      ),
                user == null
                    ? SizedBox.shrink()
                    : Container(
                        height: 54,
                        width: double.infinity,
                        child: Center(
                          child: Text('New'),
                        ),
                      ),
                user.id == null
                    ? SizedBox.shrink()
                    : Container(
                        height: 54,
                        width: double.infinity,
                        child: Center(
                          child: Text('New'),
                        ),
                      ),
                InkWell(
                  child: Container(
                    height: 54,
                    width: double.infinity,
                    child: Center(
                      child: Text(user.id == null ? 'login' : 'logout'),
                    ),
                  ),
                  onTap: () {
                    if (user == null) {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/login');
                    } else {
                      Authentication().signOut();
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/');
                    }
                  },
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

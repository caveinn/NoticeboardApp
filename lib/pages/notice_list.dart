import 'package:flutter/material.dart';
import 'package:noticeboard_app/methods/file_handling_methods.dart';
import 'package:noticeboard_app/services/auth.dart';
import 'package:provider/provider.dart';

class NoticeList extends StatelessWidget {
  const NoticeList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('prividing ${"\n"*5}');
    print(Provider.of<String>(context));
    final String userId = Provider.of<String>(context);
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
                userId == null
                    ? SizedBox.shrink()
                    : InkWell(
                        child: Container(
                          height: 54,
                          width: double.infinity,
                          child: Center(
                            child: Text('New'),
                          ),
                        ),
                        onTap: ()  async {
                          String pdfPath = await Pdf().getPdf();
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/edit', arguments: {'pdfPath': pdfPath});
                        },
                      ),
                userId == null
                    ? SizedBox.shrink()
                    : Container(
                        height: 54,
                        width: double.infinity,
                        child: Center(
                          child: Text('New'),
                        ),
                      ),
                userId == null
                    ? SizedBox.shrink()
                    : Container(
                        height: 54,
                        width: double.infinity,
                        child: Center(
                          child: Text('New'),
                        ),
                      ),
                userId == null
                    ? SizedBox.shrink()
                    : Container(
                        height: 54,
                        width: double.infinity,
                        child: Center(
                          child: Text('New'),
                        ),
                      ),
                userId == null
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
                      child: Text(userId == null ? 'login' : 'logout'),
                    ),
                  ),
                  onTap: () {
                    if (userId == null) {
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

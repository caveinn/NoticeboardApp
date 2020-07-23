import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

    final notification = Provider.of<NotificationModel>(context, listen: false);
    TextEditingController titleController = TextEditingController();
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
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  content: Container(
                                    height: 80,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50))),
                                    child: Column(
                                      children: <Widget>[
                                        TextField(
                                          controller: titleController,
                                          style: TextStyle(
                                              fontFamily: 'Lato',
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
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
                                                color: Color(0xFFA7287DC),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                width: 3,
                                                color: Color(0xFFA243782),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: InkWell(
                                            child: Container(
                                                color: Colors.yellow,
                                                child: Text('continue')),
                                            onTap: () {
                                              notification.setTitle(
                                                  titleController.text);
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              context: context);
                          String pdfPath = await Pdf().getPdf();
                          if (pdfPath != null) {
                            notification.setFile(pdfPath);
                            Navigator.pushNamed(context, '/edit',
                                arguments: {'edit': true});
                          }
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
                user == null
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
                      child: Text(user == null ? 'login' : 'logout'),
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
          backgroundColor: Color(0xFFB8B3F2),
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
                    color: Color(0xFF243782),
                    fontSize: 24,
                    fontFamily: 'Orbitron'),
              ),
              InkWell(
                child: Icon(
                  Icons.menu,
                  color: Color(0xFF243782),
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
            color: Color(0xFFFFFF),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 19, left: 22, right: 22, bottom: 19),
              child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('notices').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return new Text('Loading...');
                    default:
                      return new ListView(
                        children: snapshot.data.documents
                            .map((DocumentSnapshot document) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom:19 ),
                            child: InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: Color(0x27B8B3F2),

                                ),
                                child: new ListTile(
                                  title: new Text(document['title']),
                                  subtitle: new Text(
                                      convertTime(document['time'].toDate()),
                                ),
                              )),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    child: AlertDialog(
                                      content: Text('Opening...'),
                                    ));
                                notification.setAll(
                                    notificationCloudPath: document['url'],
                                    notificationFile: '',
                                    notificationTitle: document['title']);
                                notification.saveFileFromCloud().then((value) {
                                  Navigator.of(context).pop();
                                  Navigator.pushNamed(context, '/edit',
                                      arguments: {'edit': false});
                                });
                              },
                            ),
                          );
                        }).toList(),
                      );
                  }
                },
              ),
            )));
  }
  String convertTime(DateTime date){
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var diff = now.difference(date);
    var time = '';

    print(diff.inSeconds);
    print(diff.inDays);
    print('\n\n\n\n');

    if(diff.inDays >= 7){
      time = (diff.inDays / 7).floor().toString() + ' Weeks ago';
      return time;
    }
    else if(diff.inDays >= 1){
       time = (diff.inDays).toString() + ' Days ago';
       return time;
    }
    else if(diff.inHours >= 1 ){
      time = (diff.inHours).toString() + ' Hours ago';
      return time;
    }

    else if(diff.inMinutes >= 1){
      time = (diff.inMinutes).toString() + ' Minutes ago';
      return time;
    }
    else if(diff.inSeconds >= 1){
      time = (diff.inSeconds).toString() + ' Seconds ago';
      return time;
    }
    else{
      return 'just now';
    }
  }
}

import 'package:flutter/material.dart';

class NoticeList extends StatelessWidget {
  const NoticeList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image(
              image: AssetImage('assets/images/Logo.png'),
              height: 36,
              width: 49,
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
              onTap: (){

              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text("Trial"),
      ),
    );
  }
}
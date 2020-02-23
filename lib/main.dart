import 'package:flutter/material.dart';
import 'package:noticeboard_app/pages/login_page.dart';
import 'package:noticeboard_app/pages/notice_list.dart';
import 'package:noticeboard_app/pages/splash_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: {
        '/': (context) => SplashScreen(),
        '/notices_list': (context) => NoticeList(),
        '/login': (context) => LoginPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
    );
  }
}

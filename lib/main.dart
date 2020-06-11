import 'package:flutter/material.dart';
import 'package:noticeboard_app/pages/editor_page.dart';
import 'package:noticeboard_app/pages/login_page.dart';
import 'package:noticeboard_app/pages/notice_list.dart';
import 'package:noticeboard_app/pages/splash_page.dart';
import 'package:noticeboard_app/services/auth.dart';
import 'package:noticeboard_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'models/user.dart';
import 'notifiers.dart';

Future main() async {
  await DotEnv().load('.env');
  await DatabaseService().getUser("gUVTaiDeZ7dUaQ32iwPi0LYD1Dq1");
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureProvider<User>(
      create:(_) => Authentication().getCurrentUser,
      child: ChangeNotifierProvider(
              create:  (_) => NotificationModel() ,
              child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          routes: {
            '/': (context) => SplashScreen(),
            '/notices_list': (context) => NoticeList(),
            '/login': (context) => LoginPage(),
            '/edit': (context) => EditorPage()
          },
          theme: ThemeData(
            primarySwatch: Colors.indigo,
          ),
        ),
      ),
    );
  }
}

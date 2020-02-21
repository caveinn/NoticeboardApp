import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

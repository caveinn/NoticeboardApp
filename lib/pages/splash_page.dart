import 'package:flutter/material.dart';
import 'package:noticeboard_app/models/user.dart';
import 'package:provider/provider.dart';

import 'notice_list.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return user != null
        ? NoticeList()
        : Scaffold(
            body: SafeArea(
            child: Stack(children: [
              ClipPath(
                clipper: TriangleClipper(),
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.3,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                    color: Color(0xFFAB8B3F2),
                  ),
                ),
              ),
              ClipPath(
                clipper: SplashClipper(),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color(0xFFAB8B3F2),
                  ),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.17,
                top: MediaQuery.of(context).size.height * 0.15,
                child: Container(
                  child: Column(children: [
                    Hero(
                      tag: 'MMU logo',
                      child: Image(
                        image: AssetImage('assets/images/Logo.png'),
                        height: MediaQuery.of(context).size.height * 0.16,
                        width: MediaQuery.of(context).size.width * 0.65,
                      ),
                    ),
                    Text('NOTICE BOARD',
                        style: TextStyle(
                          fontFamily: 'Orbitron',
                          fontSize: 18,
                          color: Color(0xFFA243782),
                        ))
                  ]),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.65,
                left: MediaQuery.of(context).size.width * 0.13,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: 39,
                        child: RaisedButton(
                          color: Color(0xFFA243782),
                          child: Text(
                            'Login',
                            style: TextStyle(
                                fontFamily: 'Orbitron',
                                fontSize: 18,
                                color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          border:
                              Border.all(color: Color(0xFFA243782), width: 3),
                        ),
                        width: MediaQuery.of(context).size.width * 0.75 - 3,
                        height: 39,
                        child: RaisedButton(
                          color: Colors.white,
                          child: Text(
                            'View Notices',
                            style: TextStyle(
                                fontFamily: 'Orbitron',
                                fontSize: 18,
                                color: Color(0xFFA243782)),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/notices_list');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ));
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(0, size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class SplashClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height * 0.58);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.quadraticBezierTo(
        size.width * 0.7, size.height * 0.71, 0, size.height * 0.58);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

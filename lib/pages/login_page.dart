import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {

  LoginPage({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {

   void _showDialog(String err) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Error"),
          content: new Text(err),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async {
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  Future<String> signUp(String email, String password) async {
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Stack(children: [
          Positioned(
            top: 10,
            left: 10,
            child: Hero(
              tag: 'MMU logo',
              child: Image(
                image: AssetImage('assets/images/Logo.png'),
                height: MediaQuery.of(context).size.height * 0.26,
                width: MediaQuery.of(context).size.width * 0.65,
              ),
            ),
          ),
          ClipPath(
            clipper: LoginBackgroundClipper(),
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xAAAB8B3F2),
                )),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.54,
            left: MediaQuery.of(context).size.width * 0.13,
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: 41,
                      child: TextField(
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 18,
                        ),
                        controller: emailController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            bottom: 15,
                            left: 10,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
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
                      )),
                  SizedBox(height: 28),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: 41,
                      child: TextField(
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 18,
                        ),
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            bottom: 15,
                            left: 10,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
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
                      )),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width * 0.41,
                    height: 41,
                    child: RaisedButton(
                      color: Color(0xAAA243782),
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontFamily: 'Orbitron',
                            fontSize: 18,
                            color: Colors.white),
                      ),
                      onPressed: () async {
                        try {

                          print(await  signIn(emailController.text, passwordController.text));
                        } on Exception catch (_) {

                          _showDialog('Wromng Email or Password');
                        }
                        Navigator.pushNamed(context, '/notices_list');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    ));
  }
}

class LoginBackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height * 0.39);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.quadraticBezierTo(
        size.width * 0.7, size.height * 0.49, 0, size.height * 0.39);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

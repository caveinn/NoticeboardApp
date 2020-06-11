import 'package:firebase_auth/firebase_auth.dart';
import 'package:noticeboard_app/models/user.dart';

import 'database.dart';

class Authentication{
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
    return user != null ? user.uid : null;
  }

  Future<User> get getCurrentUser async {
    print('******I was called********');
    String userId;
    // _firebaseAuth.onAuthStateChanged.map((FirebaseUser user) => user != null ? user.uid : null ).listen((event) =>
    //   print(event)
    // ) ;
    FirebaseUser fireuser = await  _firebaseAuth.currentUser();
    userId = fireuser.uid;
    User user = await DatabaseService().getUser(userId);
    return user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
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

  Stream<User> get getCurrentUser  async* {

    var userId =  await _firebaseAuth.currentUser();
    User user = await DatabaseService().getUser(userId.uid);



    final users = _firebaseAuth.onAuthStateChanged;


    await for ( final fuser in users  ){
       print('getting curent user');
      print(fuser);
      print('\n\n\n\n\n\n');
      if(fuser != null){
        user = await DatabaseService().getUser(fuser.uid);
        print('yielding user \n\n\n\n\n\n\n\n');
        print(user);
        yield user;

      }else{

      yield null;
      }
    }

  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}

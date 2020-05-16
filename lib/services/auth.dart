import 'package:firebase_auth/firebase_auth.dart';

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

  Stream<String> get getCurrentUser {
    print('******I was called********');
    return _firebaseAuth.onAuthStateChanged.map((FirebaseUser user) => user != null ? user.uid : null );

  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}

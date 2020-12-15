import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:meal_planner/model/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User> user = FirebaseAuth.instance.authStateChanges().map((u) => u != null ? User(uid: u.uid) : null);

  Future signIn(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e.toString());
    }
  }

  Future logOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}

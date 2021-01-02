import 'package:firebase_auth/firebase_auth.dart';

class AService {
  final FirebaseAuth _firebaseAuth;

  AService(this._firebaseAuth);

  Stream<User> get aServiceChanges => _firebaseAuth.authStateChanges();

  Future<String> login({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return 'Signed in';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> register({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return 'Signed Up';
    } catch (e) {
      return e.message;
    }
  }

  Future<void> sigOut() async {
    await _firebaseAuth.signOut();
  }
}

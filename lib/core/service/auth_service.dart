import 'package:firebase_auth/firebase_auth.dart';
import 'package:love_book/core/api/auth_api.dart';

class AuthService implements AuthApi {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseAuth get auth => _auth;
  
  @override
  Future<FirebaseUser> register(String name, String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      return result.user;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<FirebaseUser> loginEmailPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return result.user;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      await _auth.signOut();
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }
}

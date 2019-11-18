import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthApi {
  
  Future<FirebaseUser> register(String name, String email, String password);

  Future<FirebaseUser> loginEmailPassword(String email, String password);
  
  Future<bool> signOut();
}
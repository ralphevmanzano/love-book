import 'package:firebase_auth/firebase_auth.dart';
import 'package:love_book/core/models/user.dart';

abstract class AuthApi {
  
  Future<User> register(User user, String password);

  Future<void> loginEmailPassword(String email, String password);
  
  Future<void> signOut();
}
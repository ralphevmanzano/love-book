import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:love_book/core/api/auth_api.dart';
import 'package:love_book/core/models/user.dart';
import 'package:love_book/core/viewmodels/auth_model.dart';

class AuthService implements AuthApi {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseAuth get auth => _auth;

  StreamController<AuthState> _authStateController = StreamController();
  
  Stream<AuthState> get authState => _authStateController.stream;
  
  String _uid;
  
  String get uid => _uid;

  AuthService() {
    _authStateController.add(AuthState.Loading);
    _auth.onAuthStateChanged.listen((user) {
      if (user == null) {
        _authStateController.add(AuthState.Unauthenticated);
      } else {
        _uid = user.uid;
        _authStateController.add(AuthState.Authenticated);
      }
    });
  }
  
  @override
  Future<User> register(String name, String email, String password) async {
    AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    FirebaseUser fbUser = result.user;
    _uid = fbUser.uid;

    User user = User.fromFirebaseUser(fbUser);
    user.name = name;
    return user;
  }

  @override
  Future<void> loginEmailPassword(String email, String password) async {
    AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    FirebaseUser fbUser = result.user;
    _uid = fbUser.uid;
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
    _uid = null;
  }
}

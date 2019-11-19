import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:love_book/core/models/user.dart';
import 'package:love_book/core/service/auth_service.dart';
import 'package:love_book/core/service/user_service.dart';
import 'package:love_book/core/viewmodels/base_model.dart';

import '../../locator.dart';
import '../viewstate.dart';

enum AuthState { Authenticated, Unauthenticated, Loading }

class AuthModel extends BaseModel {
  final AuthService _authService = locator<AuthService>();
  final UserService _userService = locator<UserService>();
  User _user;

  AuthState _authState = AuthState.Loading;

  AuthState get authState => _authState;

  User get user => _user;

  AuthModel() {
    _checkIfUserIsLoggedIn();
  }

  Future<void> _checkIfUserIsLoggedIn() async {
    _listenToAuthChanges();
  }

  void _listenToAuthChanges() {
    _authService.auth.onAuthStateChanged.listen((user) {
      if (user == null) {
        _user = null;
      } else {
        _user = User.fromFirebaseUser(user);
      }
      _authState =
          user != null ? AuthState.Authenticated : AuthState.Unauthenticated;
      setState(ViewState.Idle);
    });
  }

  Future<void> register(String name, String email, String password) async {
    try {
      setState(ViewState.Busy);
      final fbUser = await _authService.register(name, email, password);
      _user = User.fromFirebaseUser(fbUser);
      await _userService.addUser(_user.toJson());
    } catch (e) {
      print('Handled here $e');
      setState(ViewState.Idle);
    }
  }

  Future<void> loginEmailPassword(String email, String password) async {
    try {
      setState(ViewState.Busy);
      FirebaseUser firebaseUser =
          await _authService.loginEmailPassword(email, password);
      final user = User.fromFirebaseUser(firebaseUser);
      print(user);
    } catch (e) {
      setState(ViewState.Idle);
      print(e);
    }
  }

  Future<bool> logOut() async {
    try {
      setState(ViewState.Busy);
      final isSignedOut = await _authService.signOut();
      return isSignedOut;
    } catch (e) {
      setState(ViewState.Idle);
      return false;
    }
  }
}

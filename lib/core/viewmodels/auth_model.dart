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
  
  AuthState _authState = AuthState.Loading;
  
  AuthState get authState => _authState;

  AuthModel() {
    _checkIfUserIsLoggedIn();
  }

  Future<void> _checkIfUserIsLoggedIn() async {
    FirebaseUser user = await _authService.auth.currentUser();
    _authState =
        (user != null) ? AuthState.Authenticated : AuthState.Unauthenticated;
    notifyListeners();
    _listenToAuthChanges();
  }

  void _listenToAuthChanges() {
    _authService.auth.onAuthStateChanged.listen((user) {
      if (user != null) {
        _authState = AuthState.Authenticated;
        notifyListeners();
      } else {
        _authState = AuthState.Unauthenticated;
        notifyListeners();
      }
    });
  }

  Future<void> register(
      String name, String email, String password) async {
    try {
      setState(ViewState.Busy);
      final fbUser = await _authService.register(name, email, password);
      User user = User.fromFirebaseUser(fbUser);
      await _userService.addUser(user.toJson());
      setState(ViewState.Idle);
      _authState = AuthState.Authenticated;
    } catch (e) {
      print('Handled here $e');
      setState(ViewState.Idle);
    }
  }

  Future<void> loginEmailPassword(String email, String password) async {
    try {
      setState(ViewState.Busy);
      final user = await _authService.loginEmailPassword(email, password);
      setState(ViewState.Idle);
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
      setState(ViewState.Idle);
      return isSignedOut;
    } catch (e) {
      setState(ViewState.Idle);
      return false;
    }
  }
}

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
    _listenToAuthChanges();
  }

  void _listenToAuthChanges() {
    _authService.auth.onAuthStateChanged.listen((user) {
      _authState =
          user != null ? AuthState.Authenticated : AuthState.Unauthenticated;
      setState(ViewState.Idle);
    });
  }

  Future<void> register(String name, String email, String password) async {
    try {
      setState(ViewState.Busy);
      User user = await _authService.register(name, email, password);
      await _userService.addUser(user.userId, user.toJson());
    } catch (e) {
      setState(ViewState.Idle);
      print(e);
    }
  }

  Future<void> loginEmailPassword(String email, String password) async {
    try {
      setState(ViewState.Busy);
      await _authService.loginEmailPassword(email, password);
    } catch (e) {
      setState(ViewState.Idle);
      print(e);
    }
  }

  Future<void> logOut() async {
    try {
      setState(ViewState.Busy);
      await _authService.signOut();
    } catch (e) {
      setState(ViewState.Idle);
    }
  }
}

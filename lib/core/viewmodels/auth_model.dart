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
  
  Stream<AuthState> get authState => _authService.authState;
  
  Future<void> register(String name, String email, String password) async {
    try {
      setState(ViewState.Busy);
      User user = await _authService.register(name, email, password);
      await _userService.addUser(user.userId, user.toJson());
      setState(ViewState.Idle);
    } catch (e) {
      setState(ViewState.Idle);
      print(e);
    }
  }

  Future<void> loginEmailPassword(String email, String password) async {
    try {
      setState(ViewState.Busy);
      await _authService.loginEmailPassword(email, password);
      setState(ViewState.Idle);
    } catch (e) {
      setState(ViewState.Idle);
      print(e);
    }
  }

  Future<void> logOut() async {
    try {
      setState(ViewState.Busy);
      await _authService.signOut();
      setState(ViewState.Idle);
    } catch (e) {
      setState(ViewState.Idle);
    }
  }
}

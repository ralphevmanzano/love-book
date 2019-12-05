import 'package:love_book/core/models/user.dart';
import 'package:love_book/core/services/auth_service.dart';
import 'package:love_book/core/services/user_service.dart';
import 'package:love_book/core/viewmodels/base_model.dart';

import '../../locator.dart';
import '../viewstate.dart';

enum AuthState { Authenticated, Unauthenticated, Loading }

class AuthModel extends BaseModel {
  final AuthService _authService = locator<AuthService>();
  final UserService _userService = locator<UserService>();
  
  Stream<AuthState> get authState => _authService.authState;
  
  Future<void> register(User user, String password) async {
    try {
      setState(ViewState.Busy);
      User userRegistered = await _authService.register(user, password);
      await _userService.addUser(userRegistered.userId, userRegistered.toJson());
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

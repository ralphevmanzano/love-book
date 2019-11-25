import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:love_book/core/models/user.dart';
import 'package:love_book/core/service/auth_service.dart';
import 'package:love_book/core/service/user_service.dart';
import 'package:love_book/core/viewmodels/base_model.dart';
import 'package:love_book/core/viewstate.dart';
import 'package:love_book/locator.dart';

class UserModel extends BaseModel {
  final _userService = locator<UserService>();
  final _authService = locator<AuthService>();

  Stream<User> get user => _userService.user;

  void getUser() {
    _userService.getUser(_authService.uid);
  }

}

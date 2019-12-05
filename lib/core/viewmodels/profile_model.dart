import 'package:love_book/core/models/user.dart';
import 'package:love_book/core/services/auth_service.dart';
import 'package:love_book/core/services/user_service.dart';
import 'package:love_book/core/viewmodels/base_model.dart';
import 'package:love_book/locator.dart';

class ProfileModel extends BaseModel {
  bool _isEditing = false;
  bool get isEditing => _isEditing;

  final _userService = locator<UserService>();
  final _authService = locator<AuthService>();
  String get _uid => _authService.uid;
  
  User get user => _userService.user;
  
  void toggleEditing() {
    _isEditing = !_isEditing;
    print('Toggle: $_isEditing');
    notifyListeners();
  }
  
}
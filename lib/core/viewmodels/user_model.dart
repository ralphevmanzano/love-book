import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:love_book/core/models/user.dart';
import 'package:love_book/core/service/user_service.dart';
import 'package:love_book/core/viewmodels/base_model.dart';
import 'package:love_book/core/viewstate.dart';
import 'package:love_book/locator.dart';

class UserModel extends BaseModel {
  final _userService = locator<UserService>();

  User _user;

  User get user => _user;

  void getUser(String uid) {
    _userService.getUser(uid).listen((ds) {
      onUserChanged(uid, ds);
    });
  }

  void onUserChanged(String uid, DocumentSnapshot ds) {
    if (ds.data == null) return;

    print('User changed!');
    _user = User.fromMap(uid, ds.data);
    notifyListeners();
  }
}

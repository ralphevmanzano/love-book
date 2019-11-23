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
  
  Future<void> getUser(String uid) async {
    try {
//      setState(ViewState.Busy);
      DocumentSnapshot ds = await _userService.getUser(uid);
      _user = User.fromMap(uid, ds.data);
//      setState(ViewState.Idle);
    } catch (e) {
//      setState(ViewState.Idle);
      print(e);
    }
  }
}

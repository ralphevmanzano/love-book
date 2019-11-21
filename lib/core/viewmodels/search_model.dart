import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:love_book/core/models/user.dart';
import 'package:love_book/core/service/user_service.dart';
import 'package:love_book/core/viewmodels/base_model.dart';
import 'package:love_book/locator.dart';

import '../viewstate.dart';

class SearchModel extends BaseModel {
  final _userService = locator<UserService>();
  
  List<User> _users = [];
  List<User> get users => _users;
  
  Future<void> getUsers(String query) async {
    users.clear();
    try {
      setState(ViewState.Busy);
      QuerySnapshot qs = await _userService.getUsers(query);
      print(qs.documents.length);
      for(DocumentSnapshot docs in qs.documents) {
        User user = User.fromMap(docs.documentID, docs.data);
        print(user.toString());
        _users.add(user);
      }
      setState(ViewState.Idle);
    } catch (e) {
      setState(ViewState.Idle);
      print(e);
    }
  }
  
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:love_book/core/models/alert/alert_request.dart';
import 'package:love_book/core/models/request.dart';
import 'package:love_book/core/models/user.dart';
import 'package:love_book/core/service/requests_service.dart';
import 'package:love_book/core/service/user_service.dart';
import 'package:love_book/core/viewmodels/base_model.dart';
import 'package:love_book/locator.dart';

import '../viewstate.dart';

class SearchModel extends BaseModel {
  final _userService = locator<UserService>();
  final _requestsService = locator<RequestsService>();
  
  List<User> _users = [];
  
  List<User> get users => _users;
  
  Future<void> getUsers(String query) async {
    try {
      setState(ViewState.Busy);
      QuerySnapshot qs = await _userService.getUsers(query);
      users.clear(); /**/
      for (DocumentSnapshot docs in qs.documents) {
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
  
  void onRequest(User toUser) async {
    final fromUser = _userService.user;
    
    final response = await showAlert(AlertRequest(
        posButtonTitle: 'OK',
        negButtonTitle: 'CANCEL',
        title: 'Relationship request',
        photoUrl: fromUser.photoUrl,
        description:
        'Are you sure you want to send the relationship request?'));
    if (response.confirmed) {
      final request = Request(fromId: fromUser.userId,
          fromName: fromUser.name,
          fromPhotoUrl: fromUser.photoUrl,
          toId: toUser.userId);
      _requestsService.addRequest(toUser.userId, request);
    } else {
      print('Abort request!');
    }
  }
}

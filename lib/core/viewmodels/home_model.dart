import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:love_book/core/models/alert/alert_request.dart';
import 'package:love_book/core/models/request.dart';
import 'package:love_book/core/models/user.dart';
import 'package:love_book/core/services/auth_service.dart';
import 'package:love_book/core/services/requests_service.dart';
import 'package:love_book/core/services/user_service.dart';
import 'package:love_book/core/viewmodels/base_model.dart';
import 'package:love_book/core/viewstate.dart';
import 'package:love_book/locator.dart';

class HomeModel extends BaseModel {
  final _userService = locator<UserService>();
  final _authService = locator<AuthService>();
  final _requestsService = locator<RequestsService>();
  
  StreamSubscription<DocumentSnapshot> subscription;
  
  String get _uid => _authService.uid;
  
  User get user => _userService.user;

  Request _request;

  void listenRequests() {
    _requestsService.fetchRequests(_uid).listen(_onRequestsChanged);
  }

  void _onRequestsChanged(DocumentSnapshot snapshot) async {
    print(snapshot.data);
    if (snapshot.data == null)
      _request = null;
    else {
      _request = Request.fromSnapshot(snapshot);
      final alertRequest = AlertRequest(
          title: 'New relationship request!',
          description:
          '${_request.fromName} has requested a relationship with you. Do you confirm this request?',
          posButtonTitle: 'Confirm',
          negButtonTitle: 'Decline',
          photoUrl: _request.fromPhotoUrl);
    
      final response = await showAlert(alertRequest);
      if (response.confirmed) {
        print('Confirmed request!');
      } else {
        await _requestsService.removeRequest(_request.id);
        print('Canceled request!');
      }
    }
  }
  
  void getUser() {
    print('User service getUser $_uid');
    if (_uid == null) return;
  
    subscription = _userService.getUser(_uid).listen((ds) {
      onUserChanged(_uid, ds);
    });
  }
  
  @override
  void dispose() {
    if (subscription != null) {
      subscription.cancel();
    }
    super.dispose();
  }

  void onUserChanged(String uid, DocumentSnapshot ds) {
    if (ds.data == null) return;
    print('User changed!');
    _userService.onLocalUserUpdate(User.fromMap(_uid, ds.data));
    notifyListeners();
  }

}

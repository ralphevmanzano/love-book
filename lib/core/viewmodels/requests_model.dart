import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:love_book/core/models/alert/alert_request.dart';
import 'package:love_book/core/models/request.dart';
import 'package:love_book/core/service/requests_service.dart';
import 'package:love_book/core/viewmodels/base_model.dart';
import 'package:love_book/locator.dart';

class RequestsModel extends BaseModel {
  final _requestsService = locator<RequestsService>();

  Request request;

  void fetchRequests(String uid) {
    _requestsService.fetchRequests(uid).listen(_onRequestsChanged);
  }

  void _onRequestsChanged(DocumentSnapshot snapshot) {
    print('0000000000000000000000000');
    print(snapshot.data);
    if (snapshot.data == null)
      request = null;
    else {
      request = Request.fromMap(snapshot.data);
      final alertRequest = AlertRequest(
          title: 'New relationship request!',
          description:
              '${request.fromName} has requested a relationship with you. Do you confirm this request?',
          posButtonTitle: 'Ok',
          negButtonTitle: 'Cancel',
          imageUrl: request.fromPhotoUrl);
      showAlert(
        alertRequest,
        () => print('Completed-----'),
        () => print('Canceled-----'),
      );
    }
  }
}

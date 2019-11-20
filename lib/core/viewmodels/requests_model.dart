import 'dart:async';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:love_book/core/models/request.dart';
import 'package:love_book/core/service/requests_service.dart';
import 'package:love_book/locator.dart';

class RequestsModel extends ChangeNotifier {
  final _requestsService = locator<RequestsService>();

  Request request;

  void fetchRequests(String uid) {
    _requestsService.fetchRequests(uid).listen(_onRequestsChanged);
  }

  void _onRequestsChanged(DocumentSnapshot snapshot) {
    print(snapshot.data);
    if (snapshot.data == null) request = null;
    else {
      request = Request.fromMap(snapshot.data);
    }
    notifyListeners();
  }
}

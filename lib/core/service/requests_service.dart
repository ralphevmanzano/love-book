import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:love_book/core/api/requests_api.dart';
import 'package:love_book/core/models/request.dart';

class RequestsService implements RequestsApi {
  final Firestore _db = Firestore.instance;

  Stream<DocumentSnapshot> fetchRequests(String uid) {
    return _db.collection('requests').document(uid).snapshots();
  }

  @override
  Future<void> addRequest(String uid, Request request) {
    return _db.collection('requests').document(uid).setData(request.toJson());
  }

  @override
  Future<void> removeRequest(String requestId) {
    // TODO: implement removeRequest
    return null;
  }
}

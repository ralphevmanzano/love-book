import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:love_book/core/api/requests_api.dart';
import 'package:love_book/core/models/request.dart';

class RequestsService implements RequestsApi {
  final CollectionReference _ref = Firestore.instance.collection('requests');

  Stream<DocumentSnapshot> fetchRequests(String uid) {
    return _ref.document(uid).snapshots();
  }

  @override
  Future<void> addRequest(String uid, Request request) {
    return _ref.document(uid).setData(request.toJson());
  }

  @override
  Future<void> removeRequest(String requestId) {
    return _ref.document(requestId).delete();
  }
}

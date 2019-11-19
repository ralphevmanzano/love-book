import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:love_book/core/models/request.dart';

class RequestsService {
  final Firestore _db = Firestore.instance;
  final StreamController<Request> _requestController =
      StreamController<Request>();

  Stream<Request> get request => _requestController.stream;

  void fetchRequests(String uid) {
    _db
        .collection('users')
        .where('userId', isEqualTo: uid)
        .limit(1)
        .snapshots()
        .listen(_onRequestsUpdated);
  }

  void _onRequestsUpdated(QuerySnapshot snapshot) {
    snapshot.documentChanges.forEach((change) {
      if (change.document.data.containsKey('request')) {
        _requestController.add(Request.fromMap(change.document.data));
      } else {
        _requestController.add(null);
      }
      print(change.document.data.keys);
      print('docuChanges ${change.document.data}');
    });
//    _requestController.add(Request.fromSnapshot(snapshot));
  }
}

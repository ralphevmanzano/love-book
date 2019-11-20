import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:love_book/core/models/request.dart';

class RequestsService {
  final Firestore _db = Firestore.instance;
  

  Stream<DocumentSnapshot> fetchRequests(String uid) {
    return _db
        .collection('requests')
        .document(uid)
        .snapshots();
  }

  /*void _onRequestsUpdated(QuerySnapshot snapshot) {
    snapshot.documentChanges.forEach((change) {
      if (change.document.data.containsKey('request')) {
        requestController.add(Request.fromMap(change.document.data));
      } else {
        requestController.add(null);
      }
      print(change.document.data.keys);
      print('docuChanges ${change.document.data}');
    });
//    _requestController.add(Request.fromSnapshot(snapshot));
  }*/
}

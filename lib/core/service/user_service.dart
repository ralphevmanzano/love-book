import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:love_book/core/api/user_api.dart';
import 'package:love_book/core/models/user.dart';

class UserService implements UserApi {
  final Firestore _db = Firestore.instance;
  final String path = 'users';
  CollectionReference ref;
  
  User _user;
  User get user => _user;

  UserService() {
    ref = _db.collection(path);
  }

  void onLocalUserUpdate(User user) {
    _user = user;
  }
  
  @override
  Stream<DocumentSnapshot> getUser(String uid) {
    return ref.document(uid).snapshots();
  }
  
  @override
  Future<void> addUser(String uid, Map<String, dynamic> user) {
    return ref.document(uid).setData(user);
  }

  @override
  Future<void> updateUser(String uid, Map<String, dynamic> newData) async {
    await ref.document(uid).updateData(newData);
  }

  Future<QuerySnapshot> getUsers(String query) {
    print(query);
    return ref
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThanOrEqualTo: query + '\uf8ff')
        .limit(15)
        .getDocuments();
  }
}

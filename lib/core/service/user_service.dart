import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:love_book/core/api/user_api.dart';
import 'package:love_book/core/models/user.dart';

class UserService implements UserApi {
  final Firestore _db = Firestore.instance;
  final String path = 'users';
  CollectionReference ref;

  StreamController _userController = StreamController();

  Stream<User> get user => _userController.stream;

  UserService() {
    ref = _db.collection(path);
  }

  @override
  Future<DocumentReference> addUser(String uid, Map<String, dynamic> user) {
    return ref.document(uid).setData(user);
  }

  @override
  Future<void> updateUser(String uid, Map<String, dynamic> newData) async {
    await ref.document(uid).updateData(newData);
  }

  @override
  void getUser(String uid) {
    if (uid == null) return;

    ref.document(uid).snapshots().listen((ds) {
      onUserChanged(uid, ds);
    });
  }

  void onUserChanged(String uid, DocumentSnapshot ds) {
    if (ds.data == null) return;
    print('User changed!');
    _userController.add(User.fromMap(uid, ds.data));
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

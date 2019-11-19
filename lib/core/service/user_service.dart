import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:love_book/core/api/user_api.dart';

class UserService implements UserApi {
  final Firestore _db = Firestore.instance;
  final String path = 'users';
  CollectionReference ref;

  UserService() {
    ref = _db.collection(path);
  }

  @override
  Future<DocumentReference> addUser(Map<String, dynamic> user) {
    try {
      return ref.add(user);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> addPartner(String uid, Map<String, dynamic> partner) {
    try {
      return ref.document(uid).updateData(partner);
    } catch (e) {
      throw Exception(e);
    }
  }
}

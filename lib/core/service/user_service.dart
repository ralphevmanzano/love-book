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
  Future<DocumentReference> addUser(String uid, Map<String, dynamic> user) {
    try {
      return ref.document(uid).setData(user);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> updateUser(String uid, Map<String, dynamic> newData) {
    try {
      return ref.document(uid).updateData(newData);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<DocumentSnapshot> getUser(String uid) {
    try {
      return ref.document(uid).get();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<QuerySnapshot> getUsers(String query) {
    print(query);
    try {
      return ref
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThanOrEqualTo: query + '\uf8ff')
          .limit(15)
          .getDocuments();
    } catch (e) {
      throw Exception(e);
    }
  }
}

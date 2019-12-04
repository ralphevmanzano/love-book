import 'package:cloud_firestore/cloud_firestore.dart';

abstract class UserApi {
  Future<void> addUser(String uid, Map<String, dynamic> user);
  
  Stream<DocumentSnapshot> getUser(String uid);
  
  Future<QuerySnapshot> getUsers(String query);
  
  Future<void> updateUser(String uid, Map<String, dynamic> newData);
}
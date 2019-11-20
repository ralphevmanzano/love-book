import 'package:cloud_firestore/cloud_firestore.dart';

abstract class UserApi {
  Future<DocumentReference> addUser(String uid, Map<String, dynamic> user);
  
  Future<DocumentSnapshot> getUser(String uid);
  
  Future<void> updateUser(String uid, Map<String, dynamic> newData);
  
}
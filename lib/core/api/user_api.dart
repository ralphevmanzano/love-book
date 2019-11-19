import 'package:cloud_firestore/cloud_firestore.dart';

abstract class UserApi {
  Future<DocumentReference> addUser(Map<String, dynamic> user);
  
  Future<void> addPartner(String uid, Map<String, dynamic> partner);
}
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class UserApi {
  Future<DocumentReference> addUser(Map user);
}
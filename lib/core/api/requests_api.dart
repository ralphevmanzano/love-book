import 'package:cloud_firestore/cloud_firestore.dart';

abstract class RequestsApi {
  Future<DocumentReference> addRequest(Map<String, dynamic> request);
  
  Future<void> removeRequest(String requestId);
  
  Stream<DocumentSnapshot> fetchRequests(String uid);
}
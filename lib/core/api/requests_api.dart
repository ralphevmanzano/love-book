import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:love_book/core/models/request.dart';

abstract class RequestsApi {
  Future<void> addRequest(String uid, Request request);
  
  Future<void> removeRequest(String requestId);
  
  Stream<DocumentSnapshot> fetchRequests(String uid);
}
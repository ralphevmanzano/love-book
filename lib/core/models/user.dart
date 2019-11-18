import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class User {
  final String userId;
  final String email;
  String partnerId;
  String name;

  User({
    @required this.userId,
    @required this.email,
    this.name = '',
    this.partnerId = '',
  });

  toJson() {
    return {
      "userId": userId,
      "email": email,
    };
  }
  
  User.fromFirebaseUser(FirebaseUser fu)
      : userId = fu.uid ?? '',
        email = fu.email ?? '';
}

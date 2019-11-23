import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class User {
  final String userId;
  final String email;
  String photoUrl;
  String partnerId;
  String name;
  
  User({
    @required this.userId,
    @required this.email,
    this.name = '',
    this.partnerId = '',
    this.photoUrl = ''
  });
  
  toJson() {
    return {
      "email": email,
      "photoUrl": photoUrl,
      "partnerId": partnerId,
      "name": name,
    };
  }
  
  bool hasNoPartner() {
    return partnerId.isEmpty || partnerId == null;
  }


  @override
  String toString() {
    return 'email: $email, photoUrl: $photoUrl, partnerId: $partnerId, name: $name';
  }

  User.fromFirebaseUser(FirebaseUser fu)
      : userId = fu.uid ?? '',
        email = fu.email ?? '';
  
  User.fromMap(String uid, Map<String, dynamic> map)
      : name = map['name'] ?? '',
        userId = uid ?? '',
        email = map['email'] ?? '',
        photoUrl = map['photoUrl'] ?? '',
        partnerId = map['partnerId'] ?? '';
}

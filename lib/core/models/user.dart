import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jiffy/jiffy.dart';

class User {
  String userId;
  String email;
  String photoUrl;
  String partnerId;
  String name;
  Timestamp birthday;

  User({
    this.userId,
    this.email,
    this.name,
    this.partnerId,
    this.photoUrl,
    this.birthday,
  });

  toJson() {
    return {
      "email": email,
      "photoUrl": photoUrl,
      "partnerId": partnerId,
      "name": name,
      "birthday": birthday,
    };
  }

  String get formattedBirthday => Jiffy(
        DateTime.fromMicrosecondsSinceEpoch(
            this.birthday.microsecondsSinceEpoch),
      ).yMMMd;

  bool hasNoPartner() {
    return partnerId.isEmpty || partnerId == null;
  }

  @override
  String toString() {
    return 'email: $email, photoUrl: $photoUrl, partnerId: $partnerId, name: $name, birthday: ${birthday.toString()}';
  }

  User.fromFirebaseUser(FirebaseUser fu)
      : userId = fu.uid ?? '',
        email = fu.email ?? '';

  User.fromMap(String uid, Map<String, dynamic> map)
      : name = map['name'] ?? '',
        userId = uid ?? '',
        email = map['email'] ?? '',
        photoUrl = map['photoUrl'] ?? '',
        partnerId = map['partnerId'] ?? '',
        birthday = map['birthday'] ?? null;
}

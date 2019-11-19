import 'package:cloud_firestore/cloud_firestore.dart';

class Request {
  String fromId;
  String fromPhotoUrl;
  String toId;
  DateTime createdAt;

  Request({
    this.fromId,
    this.fromPhotoUrl,
    this.toId,
    this.createdAt,
  });

  toJson() {
    return {
      "fromId": fromId,
      "fromPhotoUrl": fromPhotoUrl,
      "toId": toId,
      "createdAt": createdAt,
    };
  }

  Request.fromSnapshot(DocumentSnapshot ss)
      : fromId = ss['fromId'] ?? '',
        toId = ss['toId'] ?? '',
        fromPhotoUrl = ss['fromPhotoUrl'],
        createdAt = ss['createdAt'];

  Request.fromMap(Map<String, dynamic> map)
      : fromId = map['fromId'] ?? '',
        toId = map['toId'] ?? '',
        fromPhotoUrl = map['fromPhotoUrl'],
        createdAt = map['createdAt'];
}

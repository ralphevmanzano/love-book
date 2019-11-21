import 'package:cloud_firestore/cloud_firestore.dart';

class Request {
  String fromId;
  String fromPhotoUrl;
  String toId;
  String fromName;
  DateTime createdAt;

  Request({
    this.fromId,
    this.fromPhotoUrl,
    this.toId,
    this.fromName,
    this.createdAt,
  });

  toJson() {
    return {
      "fromId": fromId,
      "fromPhotoUrl": fromPhotoUrl,
      "toId": toId,
      "fromName": fromName,
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
        createdAt = map['createdAt'],
        fromName = map['fromName'];
}

import 'package:cloud_firestore/cloud_firestore.dart';

class Request {
  String id;
  String fromId;
  String fromPhotoUrl;
  String toId;
  String fromName;
  Timestamp createdAt;

  Request({
    this.fromId,
    this.fromPhotoUrl,
    this.toId,
    this.fromName,
  }) {
    this.createdAt = Timestamp.now();
  }

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
      : id = ss.documentID,
        fromId = ss['fromId'] ?? '',
        toId = ss['toId'] ?? '',
        fromPhotoUrl = ss['fromPhotoUrl'],
        createdAt = ss['createdAt'],
        fromName = ss['fromName'];
}

import 'package:flutter/material.dart';

class AlertRequest {
  final String title;
  final String description;
  final String photoUrl;
  final String posButtonTitle;
  final String negButtonTitle;

  AlertRequest({
    @required this.title,
    @required this.description,
    this.posButtonTitle='Ok',
    this.photoUrl,
    this.negButtonTitle='Cancel',
  });
  
  bool hasImage() {
    return this.photoUrl != null && this.photoUrl.isNotEmpty;
  }
}

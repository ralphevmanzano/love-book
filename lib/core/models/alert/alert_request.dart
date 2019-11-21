import 'package:flutter/material.dart';

class AlertRequest {
  final String title;
  final String description;
  final String imageUrl;
  final String posButtonTitle;
  final String negButtonTitle;

  AlertRequest({
    @required this.title,
    @required this.description,
    @required this.posButtonTitle,
    this.imageUrl,
    this.negButtonTitle,
  });
}

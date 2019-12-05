import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:love_book/core/services/user_service.dart';
import 'package:love_book/core/viewmodels/auth_model.dart';
import 'package:love_book/locator.dart';

class StorageService {
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://love-book-bd315.appspot.com');
  UserService _userService = locator<UserService>();

  StorageReference _imageRef;
  StorageUploadTask _uploadTask;

  StorageReference get imageRef => _imageRef;

  StorageUploadTask get uploadTask => _uploadTask;

  void uploadFile(String uid, File file) async {
    String filePath = 'images/${DateTime.now()}.png';
    _imageRef = _storage.ref().child(filePath);
    _uploadTask = _imageRef.putFile(file);

    final StorageTaskSnapshot taskSnapshot = await _uploadTask.onComplete;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    _saveToUsersDb(uid, downloadUrl);
  }

  void _saveToUsersDb(String uid, String downloadUrl) async {
    try {
      await _userService.updateUser(uid, {'photoUrl': downloadUrl});
    } catch (e) {
      print(e);
    }
  }
}

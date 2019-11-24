import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:love_book/core/service/storage_service.dart';
import 'package:love_book/core/viewmodels/auth_model.dart';
import 'package:love_book/core/viewmodels/profile_model.dart';
import 'package:love_book/locator.dart';
import 'package:love_book/ui/views/base_view.dart';
import 'package:love_book/ui/widgets/choose_photo_widget.dart';
import 'package:love_book/utils/splash_effect.dart';
import 'package:provider/provider.dart';

class ProfileImage extends StatefulWidget {
  final double circleAvatarRadius;
  final String photoUrl;

  const ProfileImage(
      {Key key, @required this.photoUrl, @required this.circleAvatarRadius})
      : super(key: key);

  @override
  _ProfileImageState createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  final StorageService _storageService = locator<StorageService>();
  final AuthModel _authModel = locator<AuthModel>();
  File _imageFile;
  Uint8List _memImageFile;

  Future<void> _pickImage(ImageSource source, ThemeData theme) async {
    File selected = await ImagePicker.pickImage(source: source);
    if (selected != null) {
      _imageFile = selected;
      _cropImage(theme);
    }
  }

  Future<void> _cropImage(ThemeData theme) async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
      androidUiSettings: AndroidUiSettings(
        toolbarWidgetColor: theme.primaryColor,
        toolbarColor: Colors.white,
      ),
    );
    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
    _storageService.uploadFile(_authModel.uid, cropped ?? _imageFile);
  }

  @override
  Widget build(BuildContext context) {
    print('------------------------');
    final theme = Theme.of(context);
    return _buildProfileImageContainer(theme);
  }

  Widget _buildProfileImageContainer(ThemeData theme) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        _buildCircleProgress(),
        _buildCircleImageContainer(theme),
      ],
    );
  }

  Widget _buildCircleProgress() {
    if (_storageService.uploadTask != null) {
      return StreamBuilder<StorageTaskEvent>(
        stream: _storageService.uploadTask.events,
        builder: (context, taskEvent) {
          return _buildCircleProgressContent(taskEvent);
        },
      );
    } else {
      return Container();
    }
  }

  Widget _buildCircleProgressContent(
      AsyncSnapshot<StorageTaskEvent> taskEvent) {
    if (taskEvent.data != null) {
      print(taskEvent.connectionState);

      if (taskEvent.connectionState == ConnectionState.active) {
        return Container();
      }
      else if (taskEvent.connectionState == ConnectionState.waiting) {
        return SizedBox(
          height: 2 * (widget.circleAvatarRadius + 8),
          width: 2 * (widget.circleAvatarRadius + 8),
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        );
      }
    }
    return Container();
  }

  Widget _buildCircleImageContainer(ThemeData theme) {
    return Stack(children: <Widget>[
      _buildCircleAvatarImage(),
      _buildEditImageIcon(theme),
    ]);
  }

  Widget _buildCircleAvatarImage() {
    return CircleAvatar(
      radius: widget.circleAvatarRadius,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: widget.circleAvatarRadius - 2,
        backgroundImage: _renderImage(),
      ),
    );
  }

  Widget _buildEditImageIcon(ThemeData theme) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: GestureDetector(
        onTap: () {
          _showBottomSheet(context);
        },
        child: CircleAvatar(
          radius: 18,
          backgroundColor: theme.primaryColor,
          child: CircleAvatar(
            radius: 16,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.camera_alt,
              size: 18,
              color: theme.primaryColor,
            ),
          ),
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) async {
    final theme = Theme.of(context);
    final imgSource = await showModalBottomSheet(
      context: context,
      builder: (context) => ChoosePhotoWidget(),
      elevation: 6,
      backgroundColor: Colors.transparent,
      useRootNavigator: true,
    );
    if (imgSource != null) _pickImage(imgSource, theme);
  }

  ImageProvider _renderImage() {
    if (_imageFile != null) {
      print('Load image in file');
      return FileImage(_imageFile);
    }
    print('Load image in network');
    return NetworkImage(widget.photoUrl);
  }
}
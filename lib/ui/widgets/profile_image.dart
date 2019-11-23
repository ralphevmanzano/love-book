import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:love_book/core/viewmodels/profile_model.dart';
import 'package:love_book/ui/views/base_view.dart';
import 'package:provider/provider.dart';

class ProfileImage extends StatefulWidget {
  final double circleAvatarRadius;

  const ProfileImage({Key key, @required this.circleAvatarRadius})
      : super(key: key);

  @override
  _ProfileImageState createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  File _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);
    setState(() {
      _imageFile = selected;
    });
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
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final model = Provider.of<ProfileModel>(context);

    return _buildImageContainer(model, theme);
  }

  Widget _buildImageContainer(ProfileModel model, ThemeData theme) {
    return CircleAvatar(
      radius: widget.circleAvatarRadius,
      backgroundColor: theme.primaryColor,
      child: CircleAvatar(
        radius: widget.circleAvatarRadius - 4,
        backgroundImage: _renderImage(),
        child: GestureDetector(
          onTap: () {
            if (model.isEditing) {
              _pickImage(ImageSource.gallery);
            }
          },
          child: _buildImageMask(model),
        ),
      ),
    );
  }

  Widget _buildImageMask(ProfileModel model) {
    return SizedBox.expand(
      child: CircleAvatar(
        backgroundColor: model.isEditing
            ? Color.fromRGBO(83, 83, 83, 0.5)
            : Colors.transparent,
        child: model.isEditing
            ? Icon(Icons.camera_alt, color: Colors.white, size: 32)
            : Container(),
      ),
    );
  }

  ImageProvider _renderImage() {
    if (_imageFile != null) {
      return FileImage(_imageFile);
    }
    return NetworkImage(
        'https://scontent.fceb2-1.fna.fbcdn.net/v/t1.0-9/s960x960/41602575_2214526475242648_564062272641564672_o.jpg?_nc_cat=102&_nc_ohc=RpbPcFA3e9gAQl6cpA4Krkq7ASVIJzPqWspEcPt3HhDTbDV9yBWmQ8KWw&_nc_ht=scontent.fceb2-1.fna&oh=b4f51290ca5070138590e726d22bfcf9&oe=5E7DFB2F');
  }
}

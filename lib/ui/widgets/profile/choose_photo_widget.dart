import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:love_book/ui/routes/routes.dart';
import 'package:love_book/ui/widgets/profile/bottom_sheet_item.dart';
import 'package:love_book/utils/styles.dart';

class ChoosePhotoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(children: <Widget>[
      Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Choose Photo', style: Styles.profileItemHeader),
            SizedBox(height: 8),
            BottomSheetItem(
              label: 'Take photo',
              icon: Icon(Icons.camera_alt, color: Colors.black45),
              onTap: () {
                Routes.sailor.pop(ImageSource.camera);
              },
            ),
            BottomSheetItem(
              label: 'Upload from gallery',
              icon: Icon(Icons.photo, color: Colors.black45),
              onTap: () {
                Routes.sailor.pop(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    ]);
  }
}

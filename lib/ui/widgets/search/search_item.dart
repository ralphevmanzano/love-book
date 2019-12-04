import 'package:flutter/material.dart';
import 'package:love_book/ui/widgets/common/love_book_outlined_button.dart';
import 'package:love_book/utils/styles.dart';

class SearchItem extends StatelessWidget {
  final String photoUrl;
  final String name;
  final Function onRequest;

  const SearchItem({Key key, this.photoUrl, this.name, this.onRequest})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
        height: 62,
        child: Row(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1,
              child: CircleAvatar(
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(photoUrl),
                ),
              ),
            ),
            SizedBox(width: 16),
            Text(name, style: Styles.profileItemValue),
            Spacer(),
            LoveBookOutlinedButton(onPressed: onRequest)
          ],
        ),
      ),
    );
  }
}

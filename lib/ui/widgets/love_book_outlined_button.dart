import 'package:flutter/material.dart';
import 'package:love_book/utils/styles.dart';

class LoveBookOutlinedButton extends StatelessWidget {
  final Function onPressed;

  const LoveBookOutlinedButton({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return OutlineButton(
//      color: Colors.transparent,
      onPressed: onPressed,
      borderSide: BorderSide(
        width: 1,
        color: theme.primaryColor,
        style: BorderStyle.solid,
      ),
      textColor: theme.primaryColor,
      
      child: Text('Request'),
    );
  }
}

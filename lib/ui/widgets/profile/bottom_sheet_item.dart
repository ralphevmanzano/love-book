import 'package:flutter/material.dart';

class BottomSheetItem extends StatelessWidget {
  final String label;
  final Function onTap;
  final Icon icon;

  const BottomSheetItem({Key key, @required this.label, @required this.onTap, @required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap == null) return;
        onTap();
      },
      child: Container(
        height: 46,
        child: Row(
          children: <Widget>[
            icon,
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: Text(label,
                  style: Theme.of(context).textTheme.subhead,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

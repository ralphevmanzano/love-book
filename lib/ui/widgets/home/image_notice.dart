import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:love_book/ui/routes/routes.dart';
import 'package:love_book/utils/splash_effect.dart';

class ImageNotice extends StatelessWidget {
  final String noticeLabel;
  final String noticeImagePath;
  final Function onTap;
  
  const ImageNotice({Key key, this.noticeLabel, this.noticeImagePath, this.onTap}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 36),
        SplashEffect(
          radius: 16,
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: SvgPicture.asset(
              noticeImagePath,
              width: width * 0.7,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          width: width * 0.8,
          child: Text(
            noticeLabel,
            style: theme.textTheme.subtitle,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

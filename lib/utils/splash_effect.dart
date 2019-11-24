import 'package:flutter/material.dart';

class SplashEffect extends StatelessWidget {
  final Widget child;
  final Function onTap;
  final double radius;
  
  const SplashEffect({Key key, this.radius = 16.0, this.child, this.onTap}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        child: child,
        onTap: onTap,
      ),
    );
  }
}
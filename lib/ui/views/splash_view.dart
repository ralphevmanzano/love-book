import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                  'Lovebook',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Ubuntu',
                    fontSize: 28,
                  ),
                ),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:love_book/core/viewmodels/auth_model.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Container(
        child: Column(
          children: <Widget>[
            Text('Home View'),
            Consumer<AuthModel>(
              builder: (ctx, model, child) => RaisedButton(
                child: Text('Log out'),
                onPressed: () async {
                  final isSignedOut = await model.logOut();
                  if (!isSignedOut) {
                    Scaffold.of(context).hideCurrentSnackBar();
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Error signing out. Please try again',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

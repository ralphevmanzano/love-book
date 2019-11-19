import 'package:flutter/material.dart';
import 'package:love_book/core/viewmodels/auth_model.dart';
import 'package:love_book/core/viewmodels/home_model.dart';
import 'package:love_book/ui/views/base_view.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = Provider.of<AuthModel>(context, listen: false).user;
    String uid;
    if (user != null) uid = user.userId;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: theme.primaryColor),
      ),
      body: BaseView<HomeModel>(
        onModelReady: (model) {
          if (uid != null) {
            model.fetchRequests(uid);
          }
        },
        builder: (ctx, model, child) => Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(user.email),
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
              model.request != null
                  ? Column(
                      children: <Widget>[
                        Text('Fromid: ${model.request.fromId}'),
                        Text('toId: ${model.request.toId}'),
                        Text('fromPhotoUrl: ${model.request.fromPhotoUrl}'),
                      ],
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:love_book/core/models/user.dart';
import 'package:love_book/core/viewmodels/auth_model.dart';
import 'package:love_book/ui/routes/routes.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatelessWidget {
  final User user;

  HomeDrawer(this.user);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authModel = Provider.of<AuthModel>(context, listen: false);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: Text(user.email),
            arrowColor: Colors.white,
            currentAccountPicture: Image.network(user.photoUrl),
            accountName: Text(user.name),
          ),
          ListTile(
            title: Text('Profile'),
            leading: Icon(
              Icons.account_circle,
              color: theme.primaryColor,
            ),
            onTap: () {
              Routes.sailor.pop();
              Routes.sailor(Routes.PROFILE_VIEW);
            },
          ),
          ListTile(
            title: Text('Log out'),
            leading: Icon(
              Icons.exit_to_app,
              color: theme.primaryColor,
            ),
            onTap: () {
              Routes.sailor.pop();
              authModel.logOut();
            },
          )
        ],
      ),
    );
  }
}

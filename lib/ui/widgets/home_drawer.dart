import 'package:flutter/material.dart';
import 'package:love_book/core/viewmodels/auth_model.dart';
import 'package:love_book/ui/routes/routes.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authModel = Provider.of<AuthModel>(context, listen: false);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          ),
          ListTile(
            title: Text('Profile'),
            leading: Icon(
              Icons.account_circle,
              color: theme.primaryColor,
            ),
            onTap: () {
              Routes.sailor.pop();
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

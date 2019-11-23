import 'package:flutter/material.dart';
import 'package:love_book/core/models/user.dart';
import 'package:love_book/core/viewmodels/user_model.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final model = Provider.of<UserModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: theme.primaryColor),
        actions: <Widget>[
          // TODO: route to edit view
        ],
      ),
      body: _buildBody(
        context: context,
        user: model.user,
      ),
    );
  }

  Widget _buildBody({
    BuildContext context,
    User user,
  }) {
    ThemeData theme = Theme.of(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double aspectRatio = 16 / 9;
    double listHeight = height -
        width / aspectRatio -
        statusBarHeight -
        AppBar().preferredSize.height;

    return Column(
      children: <Widget>[
        AspectRatio(
          aspectRatio: aspectRatio,
          child: _buildProfileHeader(user: user, width: width, theme: theme),
        ),
        Container(
          height: listHeight,
          child: ListView.builder(
            itemCount: 20,
            itemBuilder: (ctx, i) => ListTile(
              title: Text('Title $i'),
            ),
          ),
        )
      ],
    );
  }

  ImageProvider _renderImage(String imgUrl) {
    return NetworkImage(imgUrl);
  }

  Widget _buildProfileHeader({double width, ThemeData theme, User user}) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: theme.primaryColor,
        boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 5)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: _renderImage(user.photoUrl),
            radius: width / 9,
          ),
          Text(
            user.name,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Ubuntu',
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }
}

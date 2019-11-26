import 'package:flutter/material.dart';
import 'package:love_book/core/models/user.dart';
import 'package:love_book/core/viewmodels/profile_model.dart';
import 'package:love_book/ui/widgets/profile_image.dart';
import 'package:love_book/utils/styles.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final model = Provider.of<ProfileModel>(context);
    print('Ni build ang profile view!!');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: theme.primaryColor),
        actions: <Widget>[
          // TODO: route to edit view
        ],
      ),
      body: Consumer<ProfileModel>(builder: (context, model, child) {
        return _buildBody(
          context: context,
          user: model.user,
        );
      }),
    );
  }

  Widget _buildBody({
    BuildContext context,
    User user,
  }) {
    ThemeData theme = Theme.of(context);
    double width = MediaQuery.of(context).size.width;
    double aspectRatio = 16 / 9;

    return Column(
      children: <Widget>[
        AspectRatio(
          aspectRatio: aspectRatio,
          child: _buildProfileHeader(user: user, width: width, theme: theme),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
//            height: listHeight,
            child: _buildProfileList(user, theme),
          ),
        )
      ],
    );
  }

  Widget _buildProfileList(User user, ThemeData theme) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ..._buildProfileItem(user, theme),
          ..._buildRelationshipItem(user, theme)
        ],
      ),
    );
  }

  Widget _buildProfileHeader({double width, ThemeData theme, User user}) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: _generateGradient(theme),
        borderRadius: BorderRadius.all(Radius.circular(16)),
        boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 5)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ProfileImage(
            userId: user.userId,
            photoUrl: user.photoUrl,
            circleAvatarRadius: width / 9,
          ),
          Text(
            user.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }

  LinearGradient _generateGradient(ThemeData theme) {
    return LinearGradient(
//          stops: [],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          stops: [
            0.3,
            0.6,
            0.8
          ],
          colors: [
            const Color(0xff380e7f),
            const Color(0xff6915cf),
            theme.primaryColor,
          ]);
  }

  List<Widget> _buildProfileItem(User user, ThemeData theme) {
    return [
      _buildProfileItemHeader('Profile'),
      _buildProfileItemValue(label: 'Email', value: user.email),
      _buildProfileItemValue(
        label: 'Birthday',
        value: 'August 23, 1996',
        isLargeDivider: true,
      ),
    ];
  }

  List<Widget> _buildRelationshipItem(User user, ThemeData theme) {
    return [
      _buildProfileItemHeader('Relationship'),
      _buildProfileItemValue(label: 'Partner', value: 'Julie Anne Acena'),
      _buildProfileItemValue(label: 'Anniversary', value: 'November 28, 2014'),
    ];
  }

  Widget _buildProfileItemHeader(String header) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Text(header, style: Styles.profileItemHeader),
    );
  }

  Widget _buildProfileItemValue(
      {String label, String value, bool isLargeDivider = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        InkWell(
          onTap: () {},
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 8),
            margin: EdgeInsets.fromLTRB(16, 0, 16, 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(value, style: Styles.profileItemValue),
                SizedBox(height: 4),
                Text(label, style: Styles.profileItemLabel),
              ],
            ),
          ),
        ),
        Container(
          padding: isLargeDivider
              ? EdgeInsets.fromLTRB(16, 0, 0, 0)
              : EdgeInsets.zero,
          width: double.infinity,
          height: isLargeDivider ? 8 : 1,
          color: Colors.black12,
        ),
      ],
    );
  }
}

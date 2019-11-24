import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:love_book/core/viewmodels/auth_model.dart';
import 'package:love_book/core/viewmodels/user_model.dart';
import 'package:love_book/ui/routes/routes.dart';
import 'package:love_book/ui/widgets/home_drawer.dart';
import 'package:love_book/utils/splash_effect.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final uid = Provider.of<AuthModel>(context, listen: false).uid;
    final model = Provider.of<UserModel>(context, listen: false);

    if (_isInit) {
      _isInit = false;
      
      model.getUser(uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;

    return Consumer<UserModel>(
      builder: (ctx, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: theme.primaryColor),
        ),
        drawer: HomeDrawer(),
        body: _buildBody(model, width, theme),
      ),
    );
  }

  Widget _buildBody(UserModel model, double width, ThemeData theme) {
    if (model.user != null) {
      return _buildBodyContent(model, width, theme);
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
        ],
      );
    }
  }

  Widget _buildBodyContent(UserModel model, double width, ThemeData theme) {
    return Container(
      width: width,
      child: (model.user.hasNoPartner())
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 36),
                SplashEffect(
                  radius: 16,
                  onTap: () {
                    Routes.sailor(Routes.SEARCH_VIEW);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: SvgPicture.asset(
                      'assets/images/img_love.svg',
                      width: width * 0.7,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  width: width * 0.8,
                  child: Text(
                    'Seems like you haven\'t added a relationship with your partner yet. Click the image to find your partner',
                    style: theme.textTheme.subtitle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            )
          : ListView.builder(itemBuilder: null),
      decoration: BoxDecoration(color: Colors.white),
    );
  }
}

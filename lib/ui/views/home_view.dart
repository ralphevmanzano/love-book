import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:love_book/core/models/user.dart';
import 'package:love_book/core/viewmodels/auth_model.dart';
import 'package:love_book/core/viewmodels/user_model.dart';
import 'package:love_book/core/viewmodels/requests_model.dart';
import 'package:love_book/core/viewstate.dart';
import 'package:love_book/ui/routes/routes.dart';
import 'package:love_book/ui/views/base_view.dart';
import 'package:love_book/ui/widgets/home_drawer.dart';
import 'package:love_book/utils/splash_effect.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var _isInit = true;
  ViewState _viewState = ViewState.Idle;

  void _loadState() {
    setState(() {
      _viewState = ViewState.Busy;
    });
  }

  void _idleState() {
    setState(() {
      _viewState = ViewState.Idle;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final uid = Provider.of<AuthModel>(context, listen: false).uid;
    final model = Provider.of<UserModel>(context, listen: false);

    if (_isInit) {
      _isInit = false;

      _loadState();

      model.getUser(uid).then((_) {
        _idleState();
      });
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
    if (_viewState == ViewState.Idle && model.user != null) {
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

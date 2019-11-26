import 'package:flutter/material.dart';
import 'package:love_book/core/models/user.dart';
import 'package:love_book/core/viewmodels/home_model.dart';
import 'package:love_book/ui/routes/routes.dart';
import 'package:love_book/ui/views/base_view.dart';
import 'package:love_book/ui/widgets/home_drawer.dart';
import 'package:love_book/ui/widgets/image_notice.dart';
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
    final homeModel = Provider.of<HomeModel>(context, listen: false);

    if (_isInit) {
      _isInit = false;
  
      homeModel.getUser();
      homeModel.listenRequests();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;

    return BaseView<HomeModel>(
      builder: (ctx, model, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: theme.primaryColor),
        ),
        drawer: HomeDrawer(),
        body: _buildBody(model.user, width, theme),
      ),
    );
  }

  Widget _buildBody(User user, double width, ThemeData theme) {
    if (user != null) {
      return _buildBodyContent(user, width, theme);
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
        ],
      );
    }
  }

  Widget _buildBodyContent(User user, double width, ThemeData theme) {
    return (user.hasNoPartner())
        ? Center(
            child: ImageNotice(
              noticeLabel:
                  'Seems like you haven\'t added a relationship with your partner yet. Click the image to find your partner',
              noticeImagePath: 'assets/images/img_love.svg',
              onTap: () {
                Routes.sailor(Routes.SEARCH_VIEW);
              },
            ),
          )
        : ListView.builder(itemBuilder: null);
  }
}

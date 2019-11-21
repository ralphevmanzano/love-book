import 'package:flutter/material.dart';
import 'package:love_book/core/models/user.dart';
import 'package:love_book/core/viewmodels/auth_model.dart';
import 'package:love_book/core/viewmodels/home_model.dart';
import 'package:love_book/core/viewmodels/requests_model.dart';
import 'package:love_book/core/viewstate.dart';
import 'package:love_book/ui/routes/routes.dart';
import 'package:love_book/ui/views/base_view.dart';
import 'package:love_book/ui/widgets/home_drawer.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final uid = Provider.of<AuthModel>(context, listen: false).uid;
    final width = MediaQuery.of(context).size.width;

    return BaseView<HomeModel>(
      onModelReady: (homeModel) async {
        print('home model onmodelready');
        await homeModel.getUser(uid);
        Provider.of<RequestsModel>(context, listen: false).fetchRequests(uid);
        print(homeModel.user.name);
      },
      builder: (ctx, homeModel, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: theme.primaryColor),
        ),
        drawer: HomeDrawer(),
        body: Container(
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              homeModel.state == ViewState.Idle
                  ? Text(homeModel.user.name)
                  : CircularProgressIndicator(),
              RaisedButton(
                child: Text('Search your partner'),
                onPressed: () {
                  Routes.sailor(Routes.SEARCH_VIEW);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

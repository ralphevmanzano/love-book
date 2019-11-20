import 'package:flutter/material.dart';
import 'package:love_book/core/models/user.dart';
import 'package:love_book/core/viewmodels/auth_model.dart';
import 'package:love_book/core/viewmodels/home_model.dart';
import 'package:love_book/core/viewmodels/requests_model.dart';
import 'package:love_book/core/viewstate.dart';
import 'package:love_book/ui/views/base_view.dart';
import 'package:love_book/ui/widgets/home_drawer.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final uid = Provider.of<AuthModel>(context, listen: false).uid;
    User user;

    return BaseView<HomeModel>(
      onModelReady: (homeModel) async {
        user = await homeModel.getUser(uid);
      },
      builder: (ctx, homeModel, child) => BaseView<RequestsModel>(
        onModelReady: (model) {
          if (uid != null) {
            model.fetchRequests(uid);
          }
        },
        builder: (ctx, model, child) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: theme.primaryColor),
          ),
          drawer: HomeDrawer(),
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                homeModel.state == ViewState.Busy
                    ? CircularProgressIndicator()
                    : user == null
                        ? CircularProgressIndicator()
                        : Text(user.name),
                model.request != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
      ),
    );
  }
}

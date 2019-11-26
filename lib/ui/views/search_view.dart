import 'package:flutter/material.dart';
import 'package:love_book/core/viewmodels/search_model.dart';
import 'package:love_book/core/viewstate.dart';
import 'package:love_book/ui/views/base_view.dart';
import 'package:love_book/ui/widgets/image_notice.dart';
import 'package:love_book/ui/widgets/search_item.dart';
import 'package:love_book/utils/debouncer.dart';

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController _queryControler = TextEditingController();
  final _debouncer = Debouncer(milliseconds: 300);

  void _queryUsers(SearchModel model, String query) async {
    if (query.isEmpty) return;
    await model.getUsers(query);
  }

  @override
  void dispose() {
    _queryControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BaseView<SearchModel>(
      builder: (ctx, model, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: theme.primaryColor),
          title: TextField(
            controller: _queryControler,
            maxLines: 1,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Search partner',
            ),
            onChanged: (value) {
              _debouncer.run(() => _queryUsers(model, value));
            },
          ),
        ),
        body: _buildBody(model),
      ),
    );
  }

  Widget _buildBody(SearchModel model) {
    if (model.users.length > 0) {
      return ListView.builder(
        itemCount: model.users.length,
        itemBuilder: (context, i) {
          return SearchItem(
            onRequest: () {model.onRequest(model.users[i]);},
            name: model.users[i].name,
            photoUrl: model.users[i].photoUrl,
          );
        },
      );
    }
    
    return Center(
        child: ImageNotice(
      noticeLabel: 'Search for your partner\'s profile',
      noticeImagePath: 'assets/images/img_searching.svg',
    ));
  }
}

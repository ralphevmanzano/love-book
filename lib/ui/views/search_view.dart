import 'package:flutter/material.dart';
import 'package:love_book/core/viewmodels/search_model.dart';
import 'package:love_book/core/viewstate.dart';
import 'package:love_book/ui/views/base_view.dart';
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
    return BaseView<SearchModel>(
      builder: (ctx, model, child) => Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: _queryControler,
            maxLines: 1,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search partner',
            ),
            onChanged: (value) {
              _debouncer.run(() => _queryUsers(model, value));
            },
          ),
        ),
        body: model.state == ViewState.Busy
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: model.users != null ? model.users.length : 0,
                itemBuilder: (context, i) {
                  if (model.users != null)
                    return ListTile(
                      title: Text(model.users[i].name),
                    );
                  else
                    return Text('Search for your partner');
                }),
      ),
    );
  }
}

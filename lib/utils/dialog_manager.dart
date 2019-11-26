import 'package:flutter/material.dart';
import 'package:love_book/core/models/alert/alert_request.dart';
import 'package:love_book/core/models/alert/alert_response.dart';
import 'package:love_book/core/service/dialog_service.dart';
import 'package:love_book/locator.dart';
import 'package:love_book/ui/routes/routes.dart';
import 'package:love_book/utils/styles.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DialogManager extends StatefulWidget {
  final Widget child;

  DialogManager({Key key, this.child}) : super(key: key);

  @override
  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  DialogService _dialogService = locator<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showDialog(AlertRequest request) {
    AlertDialog alert = AlertDialog(
      title: Text(request.title, style: Styles.profileItemHeader),
      content: Text(request.description),
      actions: <Widget>[
        _buildDialogButton(title: request.negButtonTitle, isPositive: false),
        _buildDialogButton(title: request.posButtonTitle, isPositive: true),
      ],
    );

    showDialog(context: context, builder: (context) => alert);
  }
  
  Widget _buildDialogButton({String title, bool isPositive}) {
    final theme = Theme.of(context);
  
    return FlatButton(
      child: Text(
        title,
        style: TextStyle(color: isPositive ? theme.primaryColor : Colors.red[400]),
      ),
      onPressed: () {
        Routes.sailor.pop();
        _dialogService.dialogComplete(AlertResponse(confirmed: isPositive));
      },
    );
  }
}

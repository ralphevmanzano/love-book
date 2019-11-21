import 'package:flutter/material.dart';
import 'package:love_book/core/models/alert/alert_request.dart';
import 'package:love_book/core/models/alert/alert_response.dart';
import 'package:love_book/core/service/dialog_service.dart';
import 'package:love_book/locator.dart';
import 'package:love_book/ui/routes/routes.dart';
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
    Alert(
        context: context,
        title: request.title,
        desc: request.description,
        closeFunction: () =>
            _dialogService.dialogComplete(AlertResponse(confirmed: false)),
        buttons: [
          DialogButton(
            child: Text(request.posButtonTitle),
            onPressed: () {
              _dialogService.dialogComplete(AlertResponse(confirmed: true));
              Routes.sailor.pop();
            },
          ),
          request.negButtonTitle != null
              ? DialogButton(
                  child: Text(request.negButtonTitle),
                  onPressed: () {
                    _dialogService
                        .dialogComplete(AlertResponse(confirmed: false));
                    Routes.sailor.pop();
                  },
                )
              : Container()
        ]).show();
  }
}

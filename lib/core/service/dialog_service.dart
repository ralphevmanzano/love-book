import 'dart:async';

import 'package:love_book/core/models/alert/alert_request.dart';
import 'package:love_book/core/models/alert/alert_response.dart';

class DialogService {
  Function(AlertRequest) _showDialogListener;
  Completer<AlertResponse> _dialogCompleter;

  /// Registers a callback function. Typically to show the dialog
  void registerDialogListener(Function(AlertRequest) showDialogListener) {
    _showDialogListener = showDialogListener;
  }

  /// Calls the dialog listener and returns a Future that will wait for dialogComplete.
  Future<AlertResponse> showDialog(AlertRequest alertRequest) {
    _dialogCompleter = Completer();
    _showDialogListener(AlertRequest(
      title: alertRequest.title,
      description: alertRequest.description,
      posButtonTitle: alertRequest.posButtonTitle,
      negButtonTitle: alertRequest.negButtonTitle,
      photoUrl: alertRequest.photoUrl,
    ));
    return _dialogCompleter.future;
  }

  /// Completes the _dialogCOmpleterr to resume the Future's execution call
  void dialogComplete(AlertResponse response) {
    _dialogCompleter.complete(response);
    _dialogCompleter = null;
  }
}

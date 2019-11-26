import 'package:flutter/material.dart';
import 'package:love_book/core/models/alert/alert_request.dart';
import 'package:love_book/core/models/alert/alert_response.dart';
import 'package:love_book/core/service/dialog_service.dart';
import 'package:love_book/locator.dart';

import '../viewstate.dart';

class BaseModel extends ChangeNotifier {
  final DialogService _dialogService = locator<DialogService>();

  ViewState _state = ViewState.Idle;
  
  ViewState get state => _state;
  
  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  Future<AlertResponse> showAlert(AlertRequest alertRequest) async {
    return await _dialogService.showDialog(alertRequest);
  }
}